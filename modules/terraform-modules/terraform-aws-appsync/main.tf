# GraphQL API
resource "aws_appsync_graphql_api" "appsync_graphql_api" {
  name                = var.appsync_graphql_api_name
  authentication_type = var.authentication_type
  schema              = file("${path.module}/schema_graph.ql")

  log_config {
    cloudwatch_logs_role_arn = var.log_cloudwatch_logs_role_arn
    field_log_level          = var.log_field_log_level
    exclude_verbose_content  = var.log_exclude_verbose_content
  }

  tags = var.tags
}

# DynamoDB Datasource
resource "aws_appsync_datasource" "appsync_datasource" {
  api_id           = aws_appsync_graphql_api.appsync_graphql_api.id
  name             = var.datasource_name
  service_role_arn = var.service_role_arn
  type             = var.datasource_type

  dynamodb_config {
    table_name = var.dynamodb_table_name
  }
}

#Resolver - GetMetadataByDatasetID
resource "aws_appsync_resolver" "queryby_datasetid" {
  api_id           = aws_appsync_graphql_api.appsync_graphql_api.id
  field            = "queryMetadataByDatasetId"
  type             = "Query"
  request_template = <<EOF
      {
        "version": "2017-02-28",
        "operation": "Query",
        "query": {
          "expression": "#dataset_id = :dataset_id",
          "expressionNames": {
            "#dataset_id": "dataset_id",
          },
          "expressionValues": {
            ":dataset_id": $util.dynamodb.toDynamoDBJson($ctx.args.dataset_id),
          },
        },
        "limit": $util.defaultIfNull($ctx.args.first, 200),
        "nextToken": $util.toJson($util.defaultIfNullOrEmpty($ctx.args.after, null)),
        "select": "ALL_ATTRIBUTES",
      }
    EOF

  response_template = <<EOF
      $util.toJson($ctx.result)
    EOF
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      aws_appsync_function.query_by_datasetid.function_id
    ]
  }
}

#Resolver - GetMetadataByProjectID
resource "aws_appsync_resolver" "queryby_projectid" {
  api_id           = aws_appsync_graphql_api.appsync_graphql_api.id
  field            = "queryMetadataByProjectId"
  type             = "Query"
  request_template = <<EOF
      {
        "version": "2018-05-29",
        "operation": "Query",
        "query": {
          "expression": "#project_id = :project_id",
          "expressionNames": {
            "#project_id": "project_id",
          },
          "expressionValues": {
            ":project_id": $util.dynamodb.toDynamoDBJson($ctx.args.project_id),
          },
        },
        "index": "ProjectId-Index",
        "limit": $util.defaultIfNull($ctx.args.limit, 200),
        "nextToken": $util.toJson($util.defaultIfNullOrEmpty($ctx.args.nextToken, null)),
        "scanIndexForward": true,
        "select": "ALL_ATTRIBUTES",
      }
    EOF

  response_template = <<EOF
      $util.toJson($ctx.result)
    EOF
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      aws_appsync_function.query_by_projectid.function_id
    ]
  }
}

#Resolver - liststarcapmetadata
resource "aws_appsync_resolver" "list_metadata" {
  api_id           = aws_appsync_graphql_api.appsync_graphql_api.id
  field            = "listMetadata"
  type             = "Query"
  request_template = <<EOF
      {
        "version": "2018-05-29",
        "operation": "Scan",
        "filter": #if($context.args.filter) $util.transform.toDynamoDBFilterExpression($ctx.args.filter) #else null #end,
        "nextToken": $util.toJson($util.defaultIfNullOrEmpty($ctx.args.nextToken, null)),
        "limit": $util.defaultIfNull($ctx.args.limit, 20),
      }
    EOF

  response_template = <<EOF
      $util.toJson($ctx.result)
    EOF
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      aws_appsync_function.list_metadata.function_id
    ]
  }
}

#Resolver - Search Starcap Metadata
resource "aws_appsync_resolver" "search_metadata" {
  api_id           = aws_appsync_graphql_api.appsync_graphql_api.id
  field            = "searchMetadata"
  type             = "Query"
  request_template = <<EOF
      {
        "version" : "2017-02-28",
        "operation" : "Scan",
        
        #if ($ctx.args.filter.size() > 0)
          #set( $expression = "" )
          #set( $expNames  = {} )
          #set( $expValues = {} )
          #set( $valueindex = 0 )
          #set( $outerindex = 0 )

          #foreach( $entry in $ctx.args.filter.entrySet() )

            #foreach($filter in $entry.value.entrySet())

              #if ($filter.key == "eq")
                $!{expNames.put("#$entry.key", "$entry.key")}
                  #if($expression == "")
                    #set( $expression = "$expression #$entry.key = :0" )
                  #end
                  
            #foreach($valueentry in $filter.value)
                    #if($valueindex != 0)
                        #set($expression = $expression + " $ctx.args.filterOperation #$entry.key = :$valueindex ")
                    #end    
              
                    $!{expValues.put(":$valueindex", $util.dynamodb.toDynamoDB($valueentry))}
                      
              #set( $valueindex = $valueindex + 1 )
            #end
              #elseif( $filter.key == "between" )
                $!{expNames.put("#$entry.key", "$entry.key")}
                  #if($expression == "")
                    #set( $expression = "$expression #$entry.key BETWEEN :b0$outerindex AND :b1$outerindex" )
                  #else
                    #set($expression = $expression + " $ctx.args.filterOperation #$entry.key BETWEEN :b0$outerindex AND :b1$outerindex ")
                  #end
                  
                  $!{expValues.put(":b0$outerindex", $util.dynamodb.toDynamoDB($filter.value[0]))}
                  $!{expValues.put(":b1$outerindex", $util.dynamodb.toDynamoDB($filter.value[1]))}
              #end
              #set( $outerindex = $outerindex + 1 )
            #end

          #end
        
        "filter" : {
            "expression": "$expression",
            "expressionNames" : $utils.toJson($expNames),
            "expressionValues" : $utils.toJson($expValues)
        },
        #end
        "limit": $util.defaultIfNull($ctx.args.limit, 100),
        "nextToken": $util.toJson($util.defaultIfNullOrBlank($ctx.args.nextToken, null))
      }
    EOF

  response_template = <<EOF
      $util.toJson($ctx.result)
    EOF
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      aws_appsync_function.search_metadata.function_id
    ]
  }
}

# DEV_1268599_appsync-api-key-inclusion-changes
resource "aws_appsync_api_key" "appsync_api_key" {
  api_id      = aws_appsync_graphql_api.appsync_graphql_api.id
  description = var.api_key_description
  expires     = var.api_key_expires
}

#Resolver - Search Starcap Metadata Project Key
resource "aws_appsync_resolver" "search_metadata_projectkey" {
  api_id           = aws_appsync_graphql_api.appsync_graphql_api.id
  field            = "searchMetadataByProjectkey"
  type             = "Query"
  request_template = <<EOF
      {
        "version" : "2017-02-28",
        "operation" : "Scan",
        ## Verify if exists filter and prepare Dynamo Query **
        #if ($ctx.args.filter.size() > 0)
            #set( $outerexpression = "" )
            #set( $expression = "" )
            #set( $appendedexpression = "" )
            #set( $expNames  = {} )
            #set( $expValues = {} )
            #set( $entrysize = 0 )
            #set( $index = 0 )
            #set( $valueindex = 0 )
            #set( $nextindex = 0 )
            #set( $outerindex = 0 )
            #set( $filterConcat = "+")
            #set( $checkopt = {})
            #set( $searchquerymap = {} )
            #set( $completeexpression = "" )
          #foreach( $entrydata in $ctx.args.filter.entrySet())
            #foreach($filterdata in $entrydata.value.entrySet())
                #if($filterdata.key == 'order')
                $!{searchquerymap.put($filterdata.value, $entrydata)}
                  #end
              #end
          #end
          #if(!$searchquerymap.isEmpty())
            #set($entrysize = $searchquerymap.size())
              #set($entrysize = $entrysize - 1)
          #end

          #foreach( $entryindex in [0..$entrysize])
          #set($entry = $searchquerymap.get($entryindex))
            #foreach($filter in $entry.value.entrySet())

              #if ($filter.key == "eq")
                $!{expNames.put("#$entry.key", "$entry.key")}

                  #if($outerexpression == "")
                    #set( $outerexpression = "$outerexpression #$entry.key = :$valueindex$outerindex" )
                  #end
                  #if($expression == "" && $outerexpression != "")
                    #set( $expression = "$expression #$entry.key = :$valueindex$outerindex" )
                  #end
            #foreach($valueentry in $filter.value)
                    #if($valueindex != 0)
                        #set($expression = $expression + " OR #$entry.key = :$valueindex$outerindex ")
                    #end
                    $!{expValues.put(":$valueindex$outerindex", $util.dynamodb.toDynamoDB($valueentry))}
              #set( $valueindex = $valueindex + 1 )
            #end
                  #set( $valueindex = 0)
              #elseif( $filter.key == "between" )
                $!{expNames.put("#$entry.key", "$entry.key")}
                  #if($expression == "")
                    #set( $expression = "$expression #$entry.key BETWEEN :b0$outerindex AND :b1$outerindex" )
                  #else
                    #set($expression = $expression + " OR #$entry.key BETWEEN :b0$outerindex AND :b1$outerindex ")
                  #end
                  $!{expValues.put(":b0$outerindex", $util.dynamodb.toDynamoDB($filter.value[0]))}
                  $!{expValues.put(":b1$outerindex", $util.dynamodb.toDynamoDB($filter.value[1]))}
              #end
          #if($appendedexpression == "" && ($filter.key == "between" || $filter.key == "eq"))
            #set($appendedexpression = "($expression)")
          #elseif($filter.key == "between" || $filter.key == "eq")
            #set($appendedexpression = $appendedexpression + " ($expression)")
              #elseif($filter.key == "operation")
            #set($appendedexpression = $appendedexpression + (" $filter.value"))
              #end
              #set( $expression = "" )
              #set( $outerindex = $outerindex + 1 )
              #if($filter.operation)
            #set($appendedexpression = $appendedexpression + (" $filter.operation.value"))
              #end
            #end

          #end
        #set($completeexpression = $outerexpression + " AND (" + $appendedexpression + ")")
        #set($checkopt = {
            "expression": "$completeexpression",
            "expressionNames" : $utils.toJson($expNames),
            "expressionValues" : $utils.toJson($expValues)
        })
        "filter" : {
            "expression": "$completeexpression",
            "expressionNames" : $utils.toJson($expNames),
            "expressionValues" : $utils.toJson($expValues)
        },
        #end
        "limit": $util.defaultIfNull($ctx.args.limit, 1000),
        "nextToken": $util.toJson($util.defaultIfNullOrBlank($ctx.args.nextToken, null))
      }
    EOF

  response_template = <<EOF
      $util.toJson($ctx.result)
    EOF
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      aws_appsync_function.search_metadata_projectkey.function_id
    ]
  }
}