locals {

  resource_group_name = data.azurerm_resource_group.resource_group.name
  # resource_group_name = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location                                  = data.azurerm_resource_group.resource_group.location
  Firewall_Name                             = "${var.tenant_name}-platform-${var.environment}-afw-${var.location_shortname}-01"
  firewall_policy_name                      = "${var.tenant_name}-platform-${var.environment}-afw-policy-${var.location_shortname}-01"
  PIP_Name                                  = "${var.tenant_name}-platform-${var.environment}-afw-pip-${var.location_shortname}-01"
  Ip_Configuration_name                     = "${var.tenant_name}-platform-${var.environment}-afw-pip-ipc-${var.location_shortname}-01"
  proxy_enabled                             = true
  hub_network_rg_name                       = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  firewall_subnet_name                      = "AzureFirewallSubnet"
  management_subnet_name                    = "AzureFirewallManagementSubnet"
  hub_virtual_network_name                  = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"
  rule_collection_group_name_shrd_hub       = "duicthub"
  application_rule_collection_name_shrd_hub = "hubapp"
  network_rule_collection_name_shrd_hub     = "hubnet"
  Mgnt_PIP_Name                             = "${var.tenant_name}-platform-${var.environment}-afw-mgnt-pip-${var.location_shortname}-01"
  management_ip_configuration_name          = "${var.tenant_name}-platform-${var.environment}-afw-mgnt-pip-ipc-${var.location_shortname}-01"
  #   application_rules_shrd_hub = ""
  #   network_rules_shrd_hub = ""

  #   rule_collection_group_name_ccai_dev        = "duictccai"
  #   application_rule_collection_name_ccai_dev  = "ccaiapp"
  #   network_rule_collection_name_ccai_dev      = "ccainet"

  rule_collection_group_name_cognitive       = "duictcognitive" //duictcognitive
  application_rule_collection_name_cognitive = "cogapp"
  network_rule_collection_name_cognitive     = "cognet"

  ## CCAI Dev firewall rules
  application_rules_shrd_hub = [
    {
      name              = "sha-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.196", "10.81.48.197"]
      destination_fqdns = ["*.microsoft.com", "*.azureedge.net", "*.powershellgallery.com", "pypi.org", "files.pythonhosted.org", "aka.ms", "management.core.windows.net", "*.blob.core.windows.net", "*.vsassets.io", "*.aadcdn.msftauth.net", "*.logincdn.msftauth.net", "*.msauth.net", "*.microsoftonline-p.com", "*.azure.com", "*.microsoftonline.com", "*.visualstudio.com", "*.sharepointonline.com", "*.live.com", "*.azure.net", "vssps.dev.azure.com", "settings-win.data.microsoft.com", "slscr.update.microsoft.com", "v10.events.data.microsoft.com", "nf.smartscreen.microsoft.com", "msedge.api.cdp.microsoft.com", "geo.prod.do.dsp.mp.microsoft.com", "cp601.prod.do.dsp.mp.microsoft.com", "geover.prod.do.dsp.mp.microsoft.com", "config.edge.skype.com", "kv601.prod.do.dsp.mp.microsoft.com", "v20.events.data.microsoft.com", "dev.azure.com", "checkappexec.microsoft.com", "wdcp.microsoft.com", "wdcpalt.microsoft.com", "go.microsoft.com", "www.microsoft.com", "definitionupdates.microsoft.com", "*.menalab.corp.local", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net"]
      protocols = [
        {
          port = "443"
          type = "Https"
        },
        {
          port = "80"
          type = "Http"
        },
        {
          port = "9141"
          type = "Https"
        },
        {
          port = "9142"
          type = "Https"
        },
        {
          port = "9143"
          type = "Https"
        },
        {
          port = "9144"
          type = "Https"
        },
        {
          port = "9102"
          type = "Https"
        }
      ]
    },
    {
      name              = "jbx01-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.200"]
      destination_fqdns = ["*.aadcdn.msftauth.net", "*.anaconda.com", "*.applicationinsights.azure.com", "*.azure.com", "*.azure.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dev.azure.com", "*.getpostman.com", "*.live.com", "*.logincdn.msftauth.net", "*.microsoft.com", "*.microsoftonline-p.com", "*.microsoftonline.com", "*.monitor.azure.com", "*.office.com", "*.office365.com", "*.onmicrosoft.com", "*.onedrive.com", "*.outlook.com", "*.postman.com", "*.powershellgallery.com", "*.pstmn.io", "*.python.org", "*.sharepoint.com", "*.sharepointonline.com", "*.sfx.ms", "*.svc.ms", "*.trafficmanager.net", "*.visualstudio.com", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.windows.com", "*.vsasset.io", "*getpostman.com", "aadcdn.msauth.net", "aka.ms", "bifrost-v10.getpostman.com", "dev.azure.com", "files.pythonhosted.org", "login.microsoftonline.com", "main.vscode-cdn.net", "management.azure.com", "management.core.windows.net", "microsoft.com", "portal.azure.com", "pypi.org", "spoprod-a.akamaihd.net", "update.code.visualstudio.com", "vstsagentpackage.azureedge.net", "*.du.ae", "*.corp.du.ae", "res.public.onecdn.static.microsoft", "static.edge.microsoftapp.net", "config.edge.skype.com", "git-scm.com", "*.git-scm.com", "github.com", "vscode.download.prss.microsoft.com", "code.visualstudio.com", "marketplace.visualstudio.com", "ms-python.gallerycdn.vsassets.io", "ms-vscode.gallerycdn.vsassets.io", "ms-azuretools.gallerycdn.vsassets.io", "cdn.vsassets.io", "vsaex.dev.azure.com", "vssps.dev.azure.com", "login.live.com", "autologon.microsoftazuread-sso.com", "aadcdn.msauthimages.net", "amcdn.msftauth.net", "uhf.microsoft.com", "azure.microsoft.com", "go.microsoft.com", "definitionupdates.microsoft.com", "registry-1.docker.io", "auth.docker.io", "production.cloudflare.docker.com", "contactcenteracr.azurecr.io", "api.github.com", "raw.githubusercontent.com", "objects.githubusercontent.com", "repo.anaconda.com", "nodejs.org", "cdn.jsdelivr.net", "fonts.googleapis.com", "*.gstatic.com", "gstatic.com", "cdn.segment.com", "cdn.auth0.com", "accounts.google.com", "apis.google.com", "www.googleapis.com", "oauth2.googleapis.com", "browser.events.data.microsoft.com", "mobile.events.data.microsoft.com", "v20.events.data.microsoft.com", "js.monitor.azure.com", "*.npmjs.org", "*.postman.co", "*.microsoft.net", "*.postmanlabs.com", "*.office.net", "*.msn.com", "*.menalab.corp.local", "ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "*.netops.site", "preview.api.du.ae", "*.docker.com", "docker.com", "*.prod.corp.du.ae", "downloadplugins.citrix.com", "vscode-unpkg.net", "docker-pinata-support.s3.us-east-1.amazonaws.com", "api.segment.io", "visualstudio.microsoft.com", "api.githubcopilot.com", "dl.delivery.mp.microsoft.com", "msedge.f.dl.delivery.mp.microsoft.com", "update.googleapis.com", "msedge.b.tlu.dl.delivery.mp.microsoft.com", "ctldl.windowsupdate.com", "ocsp.digicert.com", "crl3.digicert.com", "crl4.digicert.com", "oneocsp.microsoft.com", "ocsp.usertrust.com", "crl.usertrust.com", "*.microsoftonline.com", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net", "api.nuget.org", "nuget.org", "*.apps.ocp-lab.menalab.corp.local", "*.cloudflare.com"]
      protocols = [
        {
          port = "443"
          type = "Https"
        },
        {
          port = "80"
          type = "Http"
        },
        {
          port = "9141"
          type = "Https"
        },
        {
          port = "9143"
          type = "Https"
        },
        {
          port = "9142"
          type = "Https"
        },
        {
          port = "9144"
          type = "Https"
        },
        {
          port = "9102"
          type = "Https"
        }


      ]
    },
    {
      name              = "jbx02-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.198"]
      destination_fqdns = ["*.aadcdn.msftauth.net", "*.anaconda.com", "*.applicationinsights.azure.com", "*.azure.com", "*.azure.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dev.azure.com", "*.getpostman.com", "*.live.com", "*.logincdn.msftauth.net", "*.microsoft.com", "*.microsoftonline-p.com", "*.microsoftonline.com", "*.monitor.azure.com", "*.office.com", "*.office365.com", "*.onmicrosoft.com", "*.onedrive.com", "*.outlook.com", "*.postman.com", "*.powershellgallery.com", "*.pstmn.io", "*.python.org", "*.sharepoint.com", "*.sharepointonline.com", "*.sfx.ms", "*.svc.ms", "*.trafficmanager.net", "*.visualstudio.com", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.windows.com", "*.vsasset.io", "*getpostman.com", "aadcdn.msauth.net", "aka.ms", "bifrost-v10.getpostman.com", "dev.azure.com", "files.pythonhosted.org", "login.microsoftonline.com", "main.vscode-cdn.net", "management.azure.com", "management.core.windows.net", "microsoft.com", "portal.azure.com", "pypi.org", "spoprod-a.akamaihd.net", "update.code.visualstudio.com", "vstsagentpackage.azureedge.net", "*.du.ae", "*.corp.du.ae", "res.public.onecdn.static.microsoft", "static.edge.microsoftapp.net", "config.edge.skype.com", "git-scm.com", "*.git-scm.com", "github.com", "vscode.download.prss.microsoft.com", "code.visualstudio.com", "marketplace.visualstudio.com", "ms-python.gallerycdn.vsassets.io", "ms-vscode.gallerycdn.vsassets.io", "ms-azuretools.gallerycdn.vsassets.io", "cdn.vsassets.io", "vsaex.dev.azure.com", "vssps.dev.azure.com", "login.live.com", "autologon.microsoftazuread-sso.com", "aadcdn.msauthimages.net", "amcdn.msftauth.net", "uhf.microsoft.com", "azure.microsoft.com", "go.microsoft.com", "definitionupdates.microsoft.com", "registry-1.docker.io", "auth.docker.io", "production.cloudflare.docker.com", "contactcenteracr.azurecr.io", "api.github.com", "raw.githubusercontent.com", "objects.githubusercontent.com", "repo.anaconda.com", "nodejs.org", "cdn.jsdelivr.net", "fonts.googleapis.com", "*.gstatic.com", "gstatic.com", "cdn.segment.com", "cdn.auth0.com", "accounts.google.com", "apis.google.com", "www.googleapis.com", "oauth2.googleapis.com", "browser.events.data.microsoft.com", "mobile.events.data.microsoft.com", "v20.events.data.microsoft.com", "js.monitor.azure.com", "*.npmjs.org", "*.postman.co", "*.microsoft.net", "*.postmanlabs.com", "*.office.net", "*.msn.com", "*.menalab.corp.local", "ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "*.netops.site", "preview.api.du.ae", "*.docker.com", "docker.com", "*.prod.corp.du.ae", "downloadplugins.citrix.com", "vscode-unpkg.net", "docker-pinata-support.s3.us-east-1.amazonaws.com", "api.segment.io", "visualstudio.microsoft.com", "api.githubcopilot.com", "*.microsoftonline.com", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net", "api.nuget.org", "nuget.org", "*.apps.ocp-lab.menalab.corp.local", "*.cloudflare.com"]

      protocols = [
        {
          port = "443"
          type = "Https"
        },

        {
          port = "80"
          type = "Http"
        },
        {
          port = "9141"
          type = "Https"
        },
        {
          port = "9143"
          type = "Https"
        },
        {
          port = "9142"
          type = "Https"
        },
        {
          port = "9144"
          type = "Https"
        },
        {
          port = "9102"
          type = "Https"
        }
      ]
    },
    {
      name              = "jbx03-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.201"]
      destination_fqdns = ["*.aadcdn.msftauth.net", "*.anaconda.com", "*.applicationinsights.azure.com", "*.azure.com", "*.azure.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dev.azure.com", "*.getpostman.com", "*.live.com", "*.logincdn.msftauth.net", "*.microsoft.com", "*.microsoftonline-p.com", "*.microsoftonline.com", "*.monitor.azure.com", "*.office.com", "*.office365.com", "*.onmicrosoft.com", "*.onedrive.com", "*.outlook.com", "*.postman.com", "*.powershellgallery.com", "*.pstmn.io", "*.python.org", "*.sharepoint.com", "*.sharepointonline.com", "*.sfx.ms", "*.svc.ms", "*.trafficmanager.net", "*.visualstudio.com", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.windows.com", "*.vsasset.io", "*getpostman.com", "aadcdn.msauth.net", "aka.ms", "bifrost-v10.getpostman.com", "dev.azure.com", "files.pythonhosted.org", "login.microsoftonline.com", "main.vscode-cdn.net", "management.azure.com", "management.core.windows.net", "microsoft.com", "portal.azure.com", "pypi.org", "spoprod-a.akamaihd.net", "update.code.visualstudio.com", "vstsagentpackage.azureedge.net", "*.du.ae", "*.corp.du.ae", "res.public.onecdn.static.microsoft", "static.edge.microsoftapp.net", "config.edge.skype.com", "git-scm.com", "*.git-scm.com", "github.com", "vscode.download.prss.microsoft.com", "code.visualstudio.com", "marketplace.visualstudio.com", "ms-python.gallerycdn.vsassets.io", "ms-vscode.gallerycdn.vsassets.io", "ms-azuretools.gallerycdn.vsassets.io", "cdn.vsassets.io", "vsaex.dev.azure.com", "vssps.dev.azure.com", "login.live.com", "autologon.microsoftazuread-sso.com", "aadcdn.msauthimages.net", "amcdn.msftauth.net", "uhf.microsoft.com", "azure.microsoft.com", "go.microsoft.com", "definitionupdates.microsoft.com", "registry-1.docker.io", "auth.docker.io", "production.cloudflare.docker.com", "contactcenteracr.azurecr.io", "api.github.com", "raw.githubusercontent.com", "objects.githubusercontent.com", "repo.anaconda.com", "nodejs.org", "cdn.jsdelivr.net", "fonts.googleapis.com", "*.gstatic.com", "gstatic.com", "cdn.segment.com", "cdn.auth0.com", "accounts.google.com", "apis.google.com", "www.googleapis.com", "oauth2.googleapis.com", "browser.events.data.microsoft.com", "mobile.events.data.microsoft.com", "v20.events.data.microsoft.com", "js.monitor.azure.com", "*.npmjs.org", "*.postman.co", "*.microsoft.net", "*.postmanlabs.com", "*.office.net", "*.msn.com", "*.menalab.corp.local", "ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "*.netops.site", "preview.api.du.ae", "*.docker.com", "docker.com", "*.prod.corp.du.ae", "downloadplugins.citrix.com", "vscode-unpkg.net", "docker-pinata-support.s3.us-east-1.amazonaws.com", "api.segment.io", "visualstudio.microsoft.com", "api.githubcopilot.com", "*.microsoftonline.com", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net", "api.nuget.org", "nuget.org", "*.apps.ocp-lab.menalab.corp.local", "*.cloudflare.com"]

      protocols = [
        {
          port = "443"
          type = "Https"
        },
        {
          port = "80"
          type = "Http"
        },
        {
          port = "9141"
          type = "Https"
        },
        {
          port = "9143"
          type = "Https"
        },
        {
          port = "9142"
          type = "Https"
        },
        {
          port = "9144"
          type = "Https"
        },
        {
          port = "9102"
          type = "Https"
        }
      ]
    },
    {
      name              = "jbx04-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.199"]
      destination_fqdns = ["*.aadcdn.msftauth.net", "*.anaconda.com", "*.applicationinsights.azure.com", "*.azure.com", "*.azure.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dev.azure.com", "*.getpostman.com", "*.live.com", "*.logincdn.msftauth.net", "*.microsoft.com", "*.microsoftonline-p.com", "*.microsoftonline.com", "*.monitor.azure.com", "*.office.com", "*.office365.com", "*.onmicrosoft.com", "*.onedrive.com", "*.outlook.com", "*.postman.com", "*.powershellgallery.com", "*.pstmn.io", "*.python.org", "*.sharepoint.com", "*.sharepointonline.com", "*.sfx.ms", "*.svc.ms", "*.trafficmanager.net", "*.visualstudio.com", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.windows.com", "*.vsasset.io", "*getpostman.com", "aadcdn.msauth.net", "aka.ms", "bifrost-v10.getpostman.com", "dev.azure.com", "files.pythonhosted.org", "login.microsoftonline.com", "main.vscode-cdn.net", "management.azure.com", "management.core.windows.net", "microsoft.com", "portal.azure.com", "pypi.org", "spoprod-a.akamaihd.net", "update.code.visualstudio.com", "vstsagentpackage.azureedge.net", "*.du.ae", "*.corp.du.ae", "res.public.onecdn.static.microsoft", "static.edge.microsoftapp.net", "config.edge.skype.com", "git-scm.com", "*.git-scm.com", "github.com", "vscode.download.prss.microsoft.com", "code.visualstudio.com", "marketplace.visualstudio.com", "ms-python.gallerycdn.vsassets.io", "ms-vscode.gallerycdn.vsassets.io", "ms-azuretools.gallerycdn.vsassets.io", "cdn.vsassets.io", "vsaex.dev.azure.com", "vssps.dev.azure.com", "login.live.com", "autologon.microsoftazuread-sso.com", "aadcdn.msauthimages.net", "amcdn.msftauth.net", "uhf.microsoft.com", "azure.microsoft.com", "go.microsoft.com", "definitionupdates.microsoft.com", "registry-1.docker.io", "auth.docker.io", "production.cloudflare.docker.com", "contactcenteracr.azurecr.io", "api.github.com", "raw.githubusercontent.com", "objects.githubusercontent.com", "repo.anaconda.com", "nodejs.org", "cdn.jsdelivr.net", "fonts.googleapis.com", "*.gstatic.com", "gstatic.com", "cdn.segment.com", "cdn.auth0.com", "accounts.google.com", "apis.google.com", "www.googleapis.com", "oauth2.googleapis.com", "browser.events.data.microsoft.com", "mobile.events.data.microsoft.com", "v20.events.data.microsoft.com", "js.monitor.azure.com", "*.npmjs.org", "*.postman.co", "*.microsoft.net", "*.postmanlabs.com", "*.office.net", "*.msn.com", "*.menalab.corp.local", "ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "*.netops.site", "preview.api.du.ae", "*.docker.com", "docker.com", "*.prod.corp.du.ae", "downloadplugins.citrix.com", "vscode-unpkg.net", "docker-pinata-support.s3.us-east-1.amazonaws.com", "api.segment.io", "visualstudio.microsoft.com", "api.githubcopilot.com", "*.microsoftonline.com", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net", "api.nuget.org", "nuget.org", "*.apps.ocp-lab.menalab.corp.local", "*.cloudflare.com"]
      protocols = [
        {
          port = "443"
          type = "Https"
        },
        {
          port = "80"
          type = "Http"
        },
        {
          port = "9141"
          type = "Https"
        },
        {
          port = "9143"
          type = "Https"
        },
        {
          port = "9142"
          type = "Https"
        },
        {
          port = "9144"
          type = "Https"
        },
        {
          port = "9102"
          type = "Https"
        }
      ]
    },
    {
      name              = "jbx05-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.203"]
      destination_fqdns = ["*", "*.aadcdn.msftauth.net", "*.anaconda.com", "*.applicationinsights.azure.com", "*.azure.com", "*.azure.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dev.azure.com", "*.getpostman.com", "*.live.com", "*.logincdn.msftauth.net", "*.microsoft.com", "*.microsoftonline-p.com", "*.microsoftonline.com", "*.monitor.azure.com", "*.office.com", "*.office365.com", "*.onmicrosoft.com", "*.onedrive.com", "*.outlook.com", "*.postman.com", "*.powershellgallery.com", "*.pstmn.io", "*.python.org", "*.sharepoint.com", "*.sharepointonline.com", "*.sfx.ms", "*.svc.ms", "*.trafficmanager.net", "*.visualstudio.com", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.windows.com", "*.vsasset.io", "*getpostman.com", "aadcdn.msauth.net", "aka.ms", "bifrost-v10.getpostman.com", "dev.azure.com", "files.pythonhosted.org", "login.microsoftonline.com", "main.vscode-cdn.net", "management.azure.com", "management.core.windows.net", "microsoft.com", "portal.azure.com", "pypi.org", "spoprod-a.akamaihd.net", "update.code.visualstudio.com", "vstsagentpackage.azureedge.net", "*.du.ae", "*.corp.du.ae", "res.public.onecdn.static.microsoft", "static.edge.microsoftapp.net", "config.edge.skype.com", "git-scm.com", "*.git-scm.com", "github.com", "vscode.download.prss.microsoft.com", "code.visualstudio.com", "marketplace.visualstudio.com", "ms-python.gallerycdn.vsassets.io", "ms-vscode.gallerycdn.vsassets.io", "ms-azuretools.gallerycdn.vsassets.io", "cdn.vsassets.io", "vsaex.dev.azure.com", "vssps.dev.azure.com", "login.live.com", "autologon.microsoftazuread-sso.com", "aadcdn.msauthimages.net", "amcdn.msftauth.net", "uhf.microsoft.com", "azure.microsoft.com", "go.microsoft.com", "definitionupdates.microsoft.com", "registry-1.docker.io", "auth.docker.io", "production.cloudflare.docker.com", "contactcenteracr.azurecr.io", "api.github.com", "raw.githubusercontent.com", "objects.githubusercontent.com", "repo.anaconda.com", "nodejs.org", "cdn.jsdelivr.net", "fonts.googleapis.com", "*.gstatic.com", "gstatic.com", "cdn.segment.com", "cdn.auth0.com", "accounts.google.com", "apis.google.com", "www.googleapis.com", "oauth2.googleapis.com", "browser.events.data.microsoft.com", "mobile.events.data.microsoft.com", "v20.events.data.microsoft.com", "js.monitor.azure.com", "*.npmjs.org", "*.postman.co", "*.microsoft.net", "*.postmanlabs.com", "*.office.net", "*.msn.com", "*.menalab.corp.local", "ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "*.netops.site", "preview.api.du.ae", "*.docker.com", "docker.com", "*.prod.corp.du.ae", "downloadplugins.citrix.com", "vscode-unpkg.net", "docker-pinata-support.s3.us-east-1.amazonaws.com", "api.segment.io", "visualstudio.microsoft.com", "api.githubcopilot.com", "*.microsoftonline.com", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net", "api.nuget.org", "nuget.org", "*.apps.ocp-lab.menalab.corp.local", "*.cloudflare.com"]
      protocols = [
        {
          port = "443"
          type = "Https"
        },
        {
          port = "80"
          type = "Http"
        },
        {
          port = "9141"
          type = "Https"
        },
        {
          port = "9143"
          type = "Https"
        },
        {
          port = "9142"
          type = "Https"
        },
        {
          port = "9144"
          type = "Https"
        },
        {
          port = "9102"
          type = "Https"
        }
      ]
    },
    {
      name              = "linux-testvm-shrd-hub-to-internet"
      source_addresses  = ["10.81.48.202"]
      destination_fqdns = ["*.actions.githubusercontent.com", "*.azure.net", "*.azuredatabricks.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.digicert.com", "*.github.com", "*.githubusercontent.com", "*.hashicorp.com", "*.microsoft.com", "*.pkg.github.com", "*.powershellgallery.com", "aadcdn.msftauth.net", "api.github.com", "avatars.githubusercontent.com", "codeload.github.com", "developer.hashicorp.com", "github.githubassets.com", "github-registry-files.githubusercontent.com", "github-releases.githubusercontent.com", "login.live.com", "login.microsoftonline.com", "*", "logincdn.msftauth.net", "management.azure.com", "objects.githubusercontent.com", "objects-origin.githubusercontent.com", "portal.azure.com", "raw.githubusercontent.com", "releases.hashicorp.com", "results-receiver.actions.githubusercontent.com", "www.hashicorp.com", "www.terraform.io", "*.terraform.io", "aadcdn.msftauthimages.net", "dev.azure.com", "*.dev.azure.com", "aka.ms", "management.core.windows.net", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.msftauth.net", "c2rsetup.officeapps.live.com", "*.visualstudio.com", "pypi.org", "files.pythonhosted.org", "vstsagentpackage.azureedge.net", "edge.microsoft.com", "ecs.office.com", "vssps.dev.azure.com", "vsblobprodweu2.vsblob.visualstudio.com", "spsprodneu1.vssps.visualstudio.com", "github.com", "inference.location.live.net", "th.bing.com", "r.bing.com", "www2.bing.com", "fp.msedge.net", "*.menalab.corp.local", "ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "*.microsoftonline.com", "*.devicetrust.com", "aadcdn.msftauth.net", "www.vscode-unpkg.net", "api.nuget.org", "nuget.org", "*.apps.ocp-lab.menalab.corp.local", "*.cloudflare.com"]
      protocols = [
        {
          port = "443"
          type = "Https"
        },
        {
          port = "80"
          type = "Http"
        }
      ]
    },
    {
      name              = "comp-shrd-hub-to-pep-cog-prd"
      source_addresses  = ["10.81.48.192/27"]
      destination_fqdns = ["ict-platform-ccai-srch.search.windows.net", "ict-platform-ccai-docintel.cognitiveservices.azure.com", "ict-platform-ccai-spch.cognitiveservices.azure.com", "ict-platform-ccai-lang.cognitiveservices.azure.com", "ict-platform-ccai-oai.openai.azure.com", "api.cognitive.microsofttranslator.com", "ict-platform-ccai-trsl.cognitiveservices.azure.com", "ict-platform-ccai-kv.vault.azure.net", "ictplatformccaiacruaen01.azurecr.io", "dusaccaisharedtfstate.blob.core.windows.net", "dusaictshrdhubtfstate.blob.core.windows.net", "ict-platform-shrd-hub-kv.vault.azure.net", "ictplatformccaiuatacruaen01.azurecr.io"]
      protocols = [
        {
          port = "443"
          type = "Https"
        }
      ]
    }
  ]

  network_rules_shrd_hub = [
    {
      name                  = "comp-shrd-hub-to-comp-ccai-dev"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["10.81.50.32/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-comp-ccai-uat"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["10.81.51.32/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "jbx05-shrd-hub-to-internet"
      source_addresses      = ["10.81.48.202/31"]
      destination_ports     = ["*"]
      destination_addresses = ["*"]
      protocols             = ["Any"]
    },
    {
      name                  = "comp-shrd-hub-to-comp-ccai-prd"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["10.81.52.32/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-comp-ccai-dr"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["10.81.53.32/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-comp-cog-prd"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["10.81.54.32/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-pep-ccai-dev"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.50.0/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-shrd-hub-to-pep-ccai-uat"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.51.0/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-shrd-hub-to-pep-ccai-prd"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.52.0/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-shrd-hub-to-pep-ccai-dr"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.53.0/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-shrd-hub-to-pep-cog-prd"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.54.0/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-shrd-hub-to-mongoDB"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["27017", "27018", "27019", "443", "80"]
      destination_addresses = ["87.200.26.219/32", "87.200.26.232/32"]
      protocols             = ["Any"]
    },
    {
      name                  = "comp-ocp-onprem-to-ict-shrd-hub-01"
      source_addresses      = ["10.141.97.0/24"]
      destination_ports     = ["80", "443", "22", "3389", "9141", "9142"]
      destination_addresses = ["10.81.48.0/23"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-comp-ocp-onprem"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["80", "443", "22", "3389", "9141", "9142"]
      destination_addresses = ["10.141.97.0/24"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-workspace-du"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["80", "443"]
      destination_addresses = ["94.203.233.213/32", "5.32.6.157/32", "5.32.4.189/32"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-eitc-hub-to-ict-shrd-hub"
      source_addresses      = ["10.81.24.0/23"]
      destination_ports     = ["80", "443", "22", "3389", "9141", "9142"]
      destination_addresses = ["10.81.48.0/23"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-shrd-hub-to-comp-eitc-hub"
      source_addresses      = ["10.81.48.192/27"]
      destination_ports     = ["80", "443", "22", "3389", "9141", "9142"]
      destination_addresses = ["10.81.24.0/23"]
      protocols             = ["TCP", "ICMP"]
    },
  ]

  # Cognitive firewall rules
  application_rules_cognitive = [
    {
      name             = "sha-cog-prd-to-internet"
      source_addresses = ["10.81.54.36/32"]
      destination_fqdns = [
        "*.microsoft.com", "*.azureedge.net", "*.powershellgallery.com", "pypi.org", "files.pythonhosted.org", "aka.ms",
        "management.core.windows.net", "*.blob.core.windows.net", "*.vsassets.io", "*.aadcdn.msftauth.net",
        "*.logincdn.msftauth.net", "*.msauth.net", "*.microsoftonline-p.com", "*.azure.com", "*.microsoftonline.com",
        "*.visualstudio.com", "*.sharepointonline.com", "*.live.com", "*.azure.net", "vssps.dev.azure.com",
        "settings-win.data.microsoft.com", "slscr.update.microsoft.com", "v10.events.data.microsoft.com",
        "nf.smartscreen.microsoft.com", "msedge.api.cdp.microsoft.com", "geo.prod.do.dsp.mp.microsoft.com",
        "cp601.prod.do.dsp.mp.microsoft.com", "geover.prod.do.dsp.mp.microsoft.com", "config.edge.skype.com",
        "kv601.prod.do.dsp.mp.microsoft.com", "v20.events.data.microsoft.com", "dev.azure.com",
        "checkappexec.microsoft.com", "wdcp.microsoft.com", "wdcpalt.microsoft.com", "go.microsoft.com", "www.microsoft.com",
        "definitionupdates.microsoft.com", "*.menalab.corp.local", "*.devicetrust.com", "aadcdn.msftauth.net",
        "www.vscode-unpkg.net"
      ]
      protocols = [
        {
          port = "80"
          type = "Http"
        },
        {
          port = "443"
          type = "Https"
        }
      ]
    },
    {
      name             = "sha-cog-prd-to-pep-cog-prd"
      source_addresses = ["10.81.54.36/32"]
      destination_fqdns = [
        "ict-platform-ccai-srch.search.windows.net",
        "ict-platform-ccai-docintel.cognitiveservices.azure.com",
        "ict-platform-ccai-spch.cognitiveservices.azure.com",
        "ict-platform-ccai-lang.cognitiveservices.azure.com",
        "ict-platform-ccai-oai.openai.azure.com",
        "api.cognitive.microsofttranslator.com",
        "ict-platform-ccai-trsl.cognitiveservices.azure.com",
        "ict-platform-ccai-kv.vault.azure.net",
        "ictplatformccaiacruaen01.azurecr.io",
        "dusaccaisharedtfstate.blob.core.windows.net",
        "dusaictshrdhubtfstate.blob.core.windows.net",
        "ict-platform-shrd-hub-kv.vault.azure.net",
        "ictplatformccaiuatacruaen01.azurecr.io"
      ]
      protocols = [
        {
          port = "80"
          type = "Http"
        },
        {
          port = "443"
          type = "Https"
        }
      ]
    }
  ]

  network_rules_cognitive = [
    {
      name                  = "comp-cog-prd-to-workspace-du"
      source_addresses      = ["10.81.54.32/27"]
      destination_ports     = ["80", "443"]
      destination_addresses = ["94.203.233.213/32", "5.32.6.157/32", "5.32.4.189/32"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-cog-prd-to-comp-shrd-hub"
      source_addresses      = ["10.81.54.32/27"]
      destination_ports     = ["80", "443", "22", "3389"]
      destination_addresses = ["10.81.48.192/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-cog-prd-to-pep-shrd-hub"
      source_addresses      = ["10.81.54.32/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.48.224/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-cog-prd-to-pep-ccai-dev"
      source_addresses      = ["10.81.54.32/27"]
      destination_ports     = ["443"]
      destination_addresses = ["10.81.50.0/27"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-cog-prd-to-comp-ocp-onprem"
      source_addresses      = ["10.81.54.32/27"]
      destination_ports     = ["80", "443", "9141", "9142", "9143", "22", "3389"]
      destination_addresses = ["10.141.97.0/24"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-cog-prd-to-comp-eitc-hub"
      source_addresses      = ["10.81.54.32/27"]
      destination_ports     = ["80", "443", "9141", "9142", "9143", "22", "3389"]
      destination_addresses = ["10.81.24.0/24"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-ocp-onprem-to-comp-cog-prd"
      source_addresses      = ["10.141.97.0/24"]
      destination_ports     = ["80", "443", "22", "3389"]
      destination_addresses = ["10.81.54.32/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-eitc-hub-to-comp-cog-prd"
      source_addresses      = ["10.81.24.0/24"]
      destination_ports     = ["80", "443", "22", "3389"]
      destination_addresses = ["10.81.54.32/27"]
      protocols             = ["TCP", "ICMP"]
    }
  ]
}
