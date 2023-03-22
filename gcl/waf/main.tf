 resource "google_compute_security_policy" "dvwa_waf_policy" {
  name        = "dvwa-waf-policy"
  description = "My Cloud Armor policy"

  rule {
    action   = "deny(403)"
    priority = 1
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-canary')"
        }
    }
    
  }

  rule {
    action   = "deny(403)"
    priority = 2
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('rce-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 3
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 4
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('xss-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 5
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('lfi-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 6
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('rce-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 7
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('rfi-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 8
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('methodenforcement-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 9
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('scannerdetection-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 10
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('java-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 11
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('sessionfixation-v33-stable')"
        }

    }
  }

  rule {
    action   = "deny(403)"
    priority = 12
    match {
        expr {
            expression = "evaluatePreconfiguredExpr('php-v33-stable')"
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
}
 