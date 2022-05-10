
data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = var.nsx_data_vars["transport_zone"]
}
data "nsxt_policy_tier0_gateway" "tier0_router" {
  display_name = var.nsx_data_vars["t0_router_name"]
}
data "nsxt_policy_edge_cluster" "edge_cluster" {
  display_name = var.nsx_data_vars["edge_cluster"]
}

resource "random_id" "random_num" {
  byte_length = 3
}

# Create Tier 1 Gateway for 3TA App (Policy API)
resource "nsxt_policy_tier1_gateway" "Tier1-3TA-Demo" {
  display_name              = "Tier1-3TA-tf-demo${lower(random_id.random_num.hex)}"
  description               = "Teir 1 Gateway created by TF"
  edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster.path
  failover_mode             = "PREEMPTIVE"
  default_rule_logging      = "false"
  enable_firewall           = "false"
  enable_standby_relocation = "false"
  tier0_path                = data.nsxt_policy_tier0_gateway.tier0_router.path
  route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]
  pool_allocation           = "ROUTING"

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }
}

# Create Web Tier Segment for 3TA App (Policy API)

resource "nsxt_policy_segment" "web" {
  display_name        = "web-tier-tf-demo${lower(random_id.random_num.hex)}"
  description         = "Segment created by TF"
  connectivity_path   = nsxt_policy_tier1_gateway.Tier1-3TA-Demo.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path

  subnet {
    cidr = "${var.web["gw"]}/${var.web["mask"]}"
  }

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }
  tag {
    scope = "tier"
    tag   = "web"
  }
}


# Create App Tier Segment for 3TA App (Policy API)

resource "nsxt_policy_segment" "app" {
  display_name        = "app-tier-tf-demo${lower(random_id.random_num.hex)}"
  description         = "Segment created by TF"
  connectivity_path   = nsxt_policy_tier1_gateway.Tier1-3TA-Demo.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path

  subnet {
    cidr = "${var.app["gw"]}/${var.app["mask"]}"
  }

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }
  tag {
    scope = "tier"
    tag   = "app"
  }
}

# Create DB Tier Segment for 3TA App (Policy API)

resource "nsxt_policy_segment" "db" {
  display_name        = "db-tier-tf-demo${lower(random_id.random_num.hex)}"
  description         = "Segment created by TF"
  connectivity_path   = nsxt_policy_tier1_gateway.Tier1-3TA-Demo.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path

  subnet {
    cidr = "${var.db["gw"]}/${var.db["mask"]}"
  }

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }
  tag {
    scope = "tier"
    tag   = "db"
  }
}
# Ensure the Policy is fully realized in the data plane before moving on
data "nsxt_policy_segment_realization" "web_rat" {
  path = nsxt_policy_segment.web.path
}
data "nsxt_policy_segment_realization" "app_rat" {
  path = nsxt_policy_segment.app.path
}
data "nsxt_policy_segment_realization" "db_rat" {
  path = nsxt_policy_segment.db.path
}