resource "aws_sesv2_email_identity" "munchakuppa" {
  email_identity = var.munchakuppa.domain
}

resource "aws_sesv2_email_identity_mail_from_attributes" "munchakuppa" {
  email_identity   = aws_sesv2_email_identity.munchakuppa.email_identity
  mail_from_domain = "mail.${var.munchakuppa.domain}"
}
