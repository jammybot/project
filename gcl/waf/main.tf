 resource "google_compute_security_policy" "dvwa_waf_policy" {
  name        = "dvwa-waf-policy"
  description = "My Cloud Armor policy"

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }

  rule {
    action   = "deny(403)"
    priority = 1
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('sqli-v33-stable')"
        }
    }
    
  }

  rule {
    action   = "deny(403)"
    priority = 2
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('xss-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 3
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('lfi-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 4
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('rce-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 5
    match {
        expr {
            expression = " 	evaluatePreconfiguredWaf('rfi-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 6
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('methodenforcement-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 7
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('scannerdetection-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 8
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('php-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 9
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('sessionfixation-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 10
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('java-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 11
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('nodejs-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 12
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('cve-canary')"
        }

    }
  }
  rule {
    action   = "deny(403)"
    priority = 13
    match {
        expr {
            expression = "evaluatePreconfiguredWaf('json-sqli-canary', {'sensitivity':0, 'opt_in_rule_ids': ['owasp-crs-id942550-sqli']})"
        }

    }
  }
  rule {
    action   = "deny(403)"
    priority = 14
    match {
        expr {
            expression = "int(request.headers['content-length']) >= 8192"
        }

    }
  }
}
 