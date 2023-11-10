resource "shoreline_notebook" "intrusion_detection_alerts_incident" {
  name       = "intrusion_detection_alerts_incident"
  data       = file("${path.module}/data/intrusion_detection_alerts_incident.json")
  depends_on = [shoreline_action.invoke_harden_system_and_firewall]
}

resource "shoreline_file" "harden_system_and_firewall" {
  name             = "harden_system_and_firewall"
  input_file       = "${path.module}/data/harden_system_and_firewall.sh"
  md5              = filemd5("${path.module}/data/harden_system_and_firewall.sh")
  description      = "Harden system configurations and policies, and deploy additional security measures such as firewalls and intrusion detection systems."
  destination_path = "/tmp/harden_system_and_firewall.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_harden_system_and_firewall" {
  name        = "invoke_harden_system_and_firewall"
  description = "Harden system configurations and policies, and deploy additional security measures such as firewalls and intrusion detection systems."
  command     = "`chmod +x /tmp/harden_system_and_firewall.sh && /tmp/harden_system_and_firewall.sh`"
  params      = ["REPLACE_WITH_NECESSARY_PORT_NUMBER","REPLACE_WITH_DEFAULT_UMASK","REPLACE_WITH_PASSWORD_WARNING_PERIOD","REPLACE_WITH_MINIMUM_PASSWORD_AGE","REPLACE_WITH_MAXIMUM_PASSWORD_AGE"]
  file_deps   = ["harden_system_and_firewall"]
  enabled     = true
  depends_on  = [shoreline_file.harden_system_and_firewall]
}

