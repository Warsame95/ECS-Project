data "aws_acm_certificate" "cert" {
  domain       = "warsamememos.click"
  most_recent = true
  statuses = [ "ISSUED" ]

}

data "aws_route53_zone" "main_zone" {
  name = "warsamememos.click"
  private_zone = false
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.main_zone.zone_id
  name    = data.aws_acm_certificate.cert.domain
  type    = "A"

  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }

  
}