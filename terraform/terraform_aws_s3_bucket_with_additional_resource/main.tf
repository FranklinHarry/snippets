terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_s3_bucket" "cloudavail_test_bucket_new" {
  provider = aws.us-east-1
  bucket   = "cloudavail-test-use1"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudavail_test_bucket_encryption" {
  # note that the provider must match the bucket's region or else the following error occurs:
  #│ Error: creating S3 Bucket (cloudavail-test-use1)
  # Server-side Encryption Configuration: operation error S3: PutBucketEncryption, https response error StatusCode: 301, RequestID: 13YFSSB0Y78DE718, HostID: FzhKGGTe02zHPk97CptU7GPjH1Ta8MTmmkKfaiUYab4QV/rGbrrzJ5UhhbO8icFboydGxkSuE6Q=, api error
  # PermanentRedirect: The bucket you are attempting to access must be addressed using the specified endpoint.
  # Please send all future requests to this endpoint.
  provider = aws.us-east-1
  bucket   = aws_s3_bucket.cloudavail_test_bucket_new.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
