variable "prometheus_bucket_name" {
  description = "Name of the S3 bucket for Prometheus config"
  type        = string
}



variable "config_files" {
  description = "Map of configuration files to upload into S3"
  type        = map(string)
}
