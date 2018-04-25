/**
 * Main API for api.tm.id.au. Currently under construction.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html
 */
resource "aws_api_gateway_rest_api" "api" {
  name                     = "api.tm.id.au"
  minimum_compression_size = 0
}

/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/api_gateway_account.html
 */
resource "aws_api_gateway_account" "default" {
  cloudwatch_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/apiGatewayToCloudWatchLogs"
}

/**
 * TODO: Enable when either import is supported, or we can safely delete and recreate the domain
 *       while still storing mapping and ACM settings.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/api_gateway_domain_name.html
 */
/*resource "aws_api_gateway_domain_name" "api-tm-id-au" {
  domain_name = "api.tm.id.au"
}*/


# aws_api_gateway_resource
# aws_api_gateway_method
# aws_api_gateway_method_response
# aws_api_gateway_method_settings
# aws_api_gateway_integration
# aws_api_gateway_integration_response
# aws_api_gateway_gateway_response
# aws_api_gateway_model

