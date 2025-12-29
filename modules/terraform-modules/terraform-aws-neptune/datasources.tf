data "aws_caller_identity" "this" {
}

data "aws_neptune_engine_version" "neptune" {
    preferred_versions = ["1.3.2.1"]
}