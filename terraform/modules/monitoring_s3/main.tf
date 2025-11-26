resource"aws_s3_bucket" "configs" {
   bucket = "my-config-bucket-${random_id.suffix.hex}"
    } 
    
resource "random_id" "suffix" { byte_length = 2 }

#
resource "aws_s3_object" "configs" {
  for_each = var.config_files

  bucket = aws_s3_bucket.configs.bucket
  key    = "${each.key}/${basename(each.value)}"
  source = each.value
  etag   = filemd5(each.value)
}
