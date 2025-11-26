output "config_file_paths" {
  description = "Full S3 keys for each uploaded config file"
  value = {
    for name, obj in aws_s3_object.configs :
    name => obj.key
  }
}
