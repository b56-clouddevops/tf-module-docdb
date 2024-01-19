resource "aws_route53_record" "docdb_dns_rec" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID 
  name    = "mongodb-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"
  type    = "CNAME"
  ttl     = 11
  records = [aws_docdb_cluster.docdb.endpoint]
}