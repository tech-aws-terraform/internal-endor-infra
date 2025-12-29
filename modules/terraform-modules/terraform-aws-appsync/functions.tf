#query_by_datasetid
resource "aws_appsync_function" "query_by_datasetid" {
  api_id                   = aws_appsync_graphql_api.appsync_graphql_api.id
  data_source              = aws_appsync_datasource.appsync_datasource.name
  name                     = "queryMetadataByDatasetId"
  request_mapping_template = <<EOF
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

  response_mapping_template = <<EOF
      $util.toJson($ctx.result)
    EOF
}

#query_by_projectid
resource "aws_appsync_function" "query_by_projectid" {
  api_id                   = aws_appsync_graphql_api.appsync_graphql_api.id
  data_source              = aws_appsync_datasource.appsync_datasource.name
  name                     = "queryMetadataByProjectId"
  request_mapping_template = <<EOF
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

  response_mapping_template = <<EOF
      $util.toJson($ctx.result)
    EOF
}

#listmetadata
resource "aws_appsync_function" "list_metadata" {
  api_id                   = aws_appsync_graphql_api.appsync_graphql_api.id
  data_source              = aws_appsync_datasource.appsync_datasource.name
  name                     = "listMetadata"
  request_mapping_template = <<EOF
      {
        "version": "2018-05-29",
        "operation": "Scan",
        "filter": #if($context.args.filter) $util.transform.toDynamoDBFilterExpression($ctx.args.filter) #else null #end,
        "nextToken": $util.toJson($util.defaultIfNullOrEmpty($ctx.args.nextToken, null)),
        "limit": $util.defaultIfNull($ctx.args.limit, 20),
      }
    EOF

  response_mapping_template = <<EOF
      $util.toJson($ctx.result)
    EOF
}

#searchmetadata
resource "aws_appsync_function" "search_metadata" {
  api_id                   = aws_appsync_graphql_api.appsync_graphql_api.id
  data_source              = aws_appsync_datasource.appsync_datasource.name
  name                     = "searchMetadata"
  request_mapping_template = <<EOF
      {
        "version" : "2017-02-28",
        "operation" : "Scan",
        ## Verify if exists filter and prepare Dynamo Query **
        #if ($ctx.args.filter.size() > 0)
          #set( $expression = "" )
        #set( $appendedexpression = "" )
          #set( $expNames  = {} )
          #set( $expValues = {} )
          #set( $entrysize = 0 )
          #set( $index = 0 )
          #set( $valueindex = 0 )
          #set( $nextindex = 0 )
          #set( $outerindex = 0 )
          #set($filterConcat="+")
          #set($checkopt = {})

        #set( $searchquerymap = {} )

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
                  #if($expression == "")
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
        #set($checkopt = {
            "expression": "$appendedexpression",
            "expressionNames" : $utils.toJson($expNames),
            "expressionValues" : $utils.toJson($expValues)
        })

        "filter" : {
            "expression": "$appendedexpression",
            "expressionNames" : $utils.toJson($expNames),
            "expressionValues" : $utils.toJson($expValues)
        },
        #end
        "limit": $util.defaultIfNull($ctx.args.limit, 100),
        "nextToken": $util.toJson($util.defaultIfNullOrBlank($ctx.args.nextToken, null))
      }
    EOF

  response_mapping_template = <<EOF
      $util.toJson($ctx.result)
    EOF
}

#searchmetadata
resource "aws_appsync_function" "search_metadata_projectkey" {
  api_id                   = aws_appsync_graphql_api.appsync_graphql_api.id
  data_source              = aws_appsync_datasource.appsync_datasource.name
  name                     = "searchMetadataByProjectkey"
  request_mapping_template = <<EOF
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

  response_mapping_template = <<EOF
      $util.toJson($ctx.result)
    EOF
}