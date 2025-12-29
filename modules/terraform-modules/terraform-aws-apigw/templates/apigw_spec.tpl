{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "SFTP-API",
    "version" : "2023-07-13T11:16:35Z"
  },
  "servers" : [ {
    "url" : "https://bvf81j1x0g.execute-api.eu-central-1.amazonaws.com/{basePath}",
    "variables" : {
      "basePath" : {
        "default" : "dev"
      }
    }
  } ],
  "paths" : {
    "/sftp-auth/servers/{serverId}/users/{username}/config" : {
      "get" : {
        "parameters" : [ {
          "name" : "serverId",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "username",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "sourceIp",
          "in" : "query",
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "Password",
          "in" : "header",
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "protocol",
          "in" : "query",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "200 response",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/UserConfigResponseModel"
                }
              }
            }
          }
        },
        "security" : [ {
          "sigv4" : [ ]
        } ],
        "x-amazon-apigateway-integration" : {
          "type" : "aws",
          "httpMethod" : "POST",
          "uri" : "arn:aws:apigateway:${region}:lambda:path/2015-03-31/functions/${auth_lambda_arn}/invocations",
          "responses" : {
            "default" : {
              "statusCode" : "200"
            }
          },
          "requestTemplates" : {
            "application/json" : "{ \"username\": \"$input.params('username')\", \"password\": \"$util.escapeJavaScript($input.params('Password')).replaceAll(\"\\\\'\",\"'\")\", \"serverId\": \"$input.params('serverId')\", \"protocol\": \"$input.params('protocol')\",\"sourceIp\": \"$input.params('sourceIp')\" }"
          },
          "passthroughBehavior" : "when_no_templates",
          "contentHandling" : "CONVERT_TO_TEXT"
        }
      }
    }
  },
  "components" : {
    "schemas" : {
      "UserConfigResponseModel" : {
        "title" : "UserUserConfig",
        "type" : "object",
        "properties" : {
          "Role" : {
            "type" : "string"
          },
          "Policy" : {
            "type" : "string"
          },
          "HomeDirectory" : {
            "type" : "string"
          },
          "PublicKeys" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          }
        }
      }
    },
    "securitySchemes" : {
      "sigv4" : {
        "type" : "apiKey",
        "name" : "Authorization",
        "in" : "header",
        "x-amazon-apigateway-authtype" : "awsSigv4"
      }
    }
  }
}