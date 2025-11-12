resource "aws_acm_certificate" "cert" {
  domain_name       = "warsamememos.click"

}

resource "aws_route53_zone" "main_zone" {
  name = "warsamememos.click"
  comment = "HostedZone created by Route53 Registrar"
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.main_zone.id
  name    = aws_acm_certificate.cert.domain_name
  type    = "A"

  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }

  
}