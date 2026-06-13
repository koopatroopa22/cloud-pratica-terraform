output "dkim_tokens_munchakuppa" {
  value = aws_sesv2_email_identity.munchakuppa.dkim_signing_attributes[0].tokens
}
