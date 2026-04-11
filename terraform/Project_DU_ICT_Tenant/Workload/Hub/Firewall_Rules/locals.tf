locals {

  firewall_policy_rule_collection_name = "DUICTHubFirewallRuleCollections"
  firewall_application_rule_name       = "DUICTHubFirewallApplicationRules"
  firewall_network_rule_name           = "DUICTHubFirewallNetworkRules"

  rule_collection_group_name_gitex       = "duictgitex"
  application_rule_collection_name_gitex = "gitexapp"
  network_rule_collection_name_gitex     = "gitexnet"

  rule_collection_group_name_ccai_dev        = "duictccai"
  application_rule_collection_name_ccai_dev  = "ccaiapp"
  network_rule_collection_name_ccai_dev      = "ccainet"
  rule_collection_group_name_cognitive       = "duictcognitive"
  application_rule_collection_name_cognitive = "cognitiveapp"
  network_rule_collection_name_cognitive     = "cognitivenet"

  firewall_application_rules = [
    {
      name              = "DUICTHubSHAVMtoInternet"
      source_addresses  = ["172.20.0.148"]
      destination_fqdns = ["*", "*.microsoft.com", "*.azureedge.net", "*.visualstudio.com", "*.powershellgallery.com", "pypi.org", "*.azure.net", "aadcdn.msftauth.net", "files.pythonhosted.org", "aka.ms", "vstsagentpackage.azureedge.net", "developer.hashicorp.com", "*.dev.azure.com", "dev.azure.com", "login.microsoftonline.com", "management.core.windows.net", "*.blob.core.windows.net", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.hashicorp.com", "*", "*.pypi.org", "login.live.com", "login.microsoftonline.com", "logincdn.msftauth.net", "management.azure.com", "portal.azure.com", "releases.hashicorp.com", "www.hashicorp.com", "www.terraform.io", "*.terraform.io", "edge.microsoft.com", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "slscr.update.microsoft.com", "mobile.events.data.microsoft.com", "displaycatalog.mp.microsoft.com", "watson.events.data.microsoft.com", "ecs.office.com", "dev.azure.com", "vssps.dev.azure.com", "management.azure.com", "vsblobprodweu2.vsblob.visualstudio.com", "spsprodneu1.vssps.visualstudio.com", "checkpoint-api.hashicorp.com", "registry.terraform.io", "releases.hashicorp.com", "github.com", "objects.githubusercontent.com", "inference.location.live.net", "fs.microsoft.com", "wdcp.microsoft.com", "wdcpalt.microsoft.com", "www.bing.com", "th.bing.com", "browser.pipe.aria.microsoft.com", "r.bing.com", "www2.bing.com", "fp.msedge.net", "ict-platform-hrbot-dev-py-app.scm.azurewebsites.net", "ict-platform-hrbot-dev-py-app.azurewebsites.net"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "DUICTHubSHAVMtoCCAI"
      source_addresses  = ["172.20.0.148"]
      destination_fqdns = ["*", "ict-platform-ccai-trsl.cognitiveservices.azure.com"]
      port              = "5000"
      type              = "Https"
    },
    {
      name              = "DUICTHubSHAVMtoApiGee"
      source_addresses  = ["172.20.0.148"]
      destination_fqdns = ["tqcmajor-apigwnonprod.corp.du.ae"]
      port              = "9102"
      type              = "Http"
    },
    {
      name              = "DUICTHubSHAVMtoMongoDB"
      source_addresses  = ["172.20.0.148", "172.20.0.149"]
      destination_fqdns = ["ict-platform-hrbot-dev-database-cosmos.mongo.cosmos.azure.com", "ict-platform-hrbot-prod-database-cosmos.mongo.cosmos.azure.com"]
      port              = "10255"
      type              = "Https"
    },
    {
      name              = "DUICTDevPBIVMHttpstoInternet"
      source_addresses  = ["172.20.4.164"]
      destination_fqdns = ["*", "*.azure.net", "*.powerbi.com", "apps.identrust.com", "cm.mgid.com", "code.yengo.com", "config.edge.skype.com", "dc.services.visualstudio.com", "js.monitor.azure.com", "login.live.com", "login.microsoftonline.com", "logincdn.msftauth.net", "management.azure.com", "*.microsoft.com", "r.msftstatic.com", "*.msn.com", "*.akamaized.net", "*.azureedge.net", "*.nelreports.net", "*.bing.com", "*.msauth.net", "*.msftncsi.com", "*.windows.net", "*.frontend.clouddatahub.net", "*.github.com", "*.githubusercontent.com", "github.githubassets.com", "edge.microsoft.com", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "ne.frontend.clouddatahub.net", "edr-weu3.eu.endpoint.security.microsoft.com", "v20.events.data.microsoft.com", "northeurope-2.in.applicationinsights.azure.com", "fe2cr.update.microsoft.com", "fe3cr.delivery.mp.microsoft.com", "wabi-north-europe-relay12.servicebus.windows.net", "msedge.api.cdp.microsoft.com", "config.edge.skype.com", "tsfe.trafficshaping.dsp.mp.microsoft.com", "business.bing.com", "wabi-north-europe-redirect.analysis.windows.net", "app.powerbi.com", "content.powerapps.com", "europe.ces.microsoftcloud.com", "g17-prod-db4-005-sb.servicebus.windows.net", "g0-prod-db4-005-sb.servicebus.windows.net", "g12-prod-db4-005-sb.servicebus.windows.net", "g5-prod-db4-005-sb.servicebus.windows.net", "pbipneu1-northeurope.pbidedicated.windows.net"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "DUICTDevPBIVMHttptoInternet"
      source_addresses  = ["172.20.4.164"]
      destination_fqdns = ["au.download.windowsupdate.com", "ctldl.windowsupdate.com", "download.windowsupdate.com", "*"]
      port              = "80"
      type              = "Http"
    },
    {
      name              = "DUICTDevPBIVMtoApiGee"
      source_addresses  = ["172.20.4.164"]
      destination_fqdns = ["tqcmajor-apigwnonprod.corp.du.ae"]
      port              = "9102"
      type              = "Http"
    },
    {
      name              = "DUICTDevVMDevtoInternet"
      source_addresses  = ["172.20.4.165", "172.20.4.166", "172.20.4.167"]
      destination_fqdns = ["*", "edge.microsoft.com", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "client.wns.windows.com", "eu-v20.events.endpoint.security.microsoft.com", "az764295.vo.msecnd.net", "login.microsoftonline.com", "events.launchdarkly.com", "mdav.eu.endpoint.security.microsoft.com", "settings-win.data.microsoft.com", "default.exp-tas.com", "v10.events.data.microsoft.com", "westus-0.in.applicationinsights.azure.com", "edge.microsoft.com", "go.microsoft.com", "login.live.com", "geo.prod.do.dsp.mp.microsoft.com", "cp601.prod.do.dsp.mp.microsoft.com", "kv601.prod.do.dsp.mp.microsoft.com", "geover.prod.do.dsp.mp.microsoft.com", "umwatson.events.data.microsoft.com", "clientstream.launchdarkly.com", "portal.azure.com", "js.monitor.azure.com", "learn.microsoft.com", "europe.smartscreen.microsoft.com", "wcpstatic.microsoft.com", "aadcdn.msftauth.net", "functional.events.data.microsoft.com", "srtb.msn.com", "browser.events.data.msn.com", "sb.scorecardresearch.com", "assets.msn.com", "r.msftstatic.com", "ntp.msn.com", "nav.smartscreen.microsoft.com", "aadcdn.msauth.net", "eu-mobile.events.data.microsoft.com", "enterpriseregistration.windows.net", "aadcdn.msftauthimages.net", "img-s-msn-com.akamaized.net", "c.msn.com", "c.bing.com", "api.msn.com", "aadcdn.msauthimages.net", "graph.microsoft.com"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "DUICTDevtoApiGee"
      source_addresses  = ["172.20.4.64/26", "172.20.4.0/26", "172.20.4.165", "172.20.4.166", "172.20.4.167"]
      destination_fqdns = ["tqcmajor-apigwnonprod.corp.du.ae"]
      port              = "9102"
      type              = "Http"
    },
    {
      name              = "DUICTDevPyintSnettoInternet"
      source_addresses  = ["172.20.4.0/26"]
      destination_fqdns = ["*.azure-api.net", "*.azurewebsites.net", "ict-platform-hrbot-prod-oai.openai.azure.com", "pypi.org", "*.pythonhosted.org", "*python.org", "*npmjs.com", "*npmjs.org", "*nodejs.org", "*.botframework.com", "token.botframework.com", "dc.applicationinsights.azure.com", "dc.applicationinsights.microsoft.com", "dc.services.visualstudio.com", "*.in.applicationinsights.azure.com", "live.applicationinsights.azure.com", "rt.applicationinsights.microsoft.com", "rt.services.visualstudio.com", "*.livediagnostics.monitor.azure.com", "login.windows.net", "login.microsoftonline.com", "sts.windows.net", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "login.windows.com", "*"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "DUICTDevPyintSnettoMongoDB"
      source_addresses  = ["172.20.4.0/26"]
      destination_fqdns = ["ict-platform-hrbot-dev-database-cosmos.mongo.cosmos.azure.com"]
      port              = "10255"
      type              = "Https"
    },
    {
      name              = "DUICTHubSqubetoInternet"
      source_addresses  = ["172.20.0.149"]
      destination_fqdns = ["*"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "DUICTDevNodeintSnettoInternet"
      source_addresses  = ["172.20.4.64/26"]
      destination_fqdns = ["*.azure-api.net", "*.azurewebsites.net", "*pypi.org", "*.pythonhosted.org", "*python.org", "*npmjs.com", "*npmjs.org", "*nodejs.org", "*.botframework.com", "token.botframework.com", "dc.applicationinsights.azure.com", "dc.applicationinsights.microsoft.com", "dc.services.visualstudio.com", "*.in.applicationinsights.azure.com", "live.applicationinsights.azure.com", "rt.applicationinsights.microsoft.com", "rt.services.visualstudio.com", "*.livediagnostics.monitor.azure.com", "login.windows.net", "login.microsoftonline.com", "sts.windows.net", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "login.windows.com", "uaenorth-0.in.applicationinsights.azure.com", "profiler.monitor.azure.com", "agent.azureserviceprofiler.net", "uaenorth.livediagnostics.monitor.azure.com", "dc.services.visualstudio.com", "eastus-2.in.applicationinsights.azure.com"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "DUICTDevtoApiGee9141"
      source_addresses  = ["172.20.4.0/26", "172.20.4.160/28", "172.20.0.144/28"]
      destination_fqdns = ["api.du.ae", "94.203.233.45", "5.32.4.189", "5.32.6.157"]
      port              = "9141"
      type              = "Https"
    },
    {
      name              = "DUICTDevtoApiGee9143"
      source_addresses  = ["172.20.4.0/26", "172.20.4.160/28", "172.20.0.144/28"]
      destination_fqdns = ["94.203.233.45"]
      port              = "9143"
      type              = "Https"
    },
    {
      name              = "DUICTDevtoApiGee9144"
      source_addresses  = ["172.20.4.0/26", "172.20.4.160/28", "172.20.0.144/28"]
      destination_fqdns = ["94.203.233.45"]
      port              = "9144"
      type              = "Https"
    },
    {
      name              = "DUICTDevtoApiGee9142"
      source_addresses  = ["172.20.4.0/26", "172.20.4.160/28", "172.20.0.144/28"]
      destination_fqdns = ["preview.api.du.ae", "94.203.233.45", "5.32.4.190"]
      port              = "9142"
      type              = "Https"
    },
    {
      name              = "comp-hr-hub-to-pep-ccai-dev"
      source_addresses  = ["172.20.0.144/28"]
      destination_fqdns = ["dusaccaidevadlsingestion.blob.core.windows.net", "dusaccaidevadlsingestion.dfs.core.windows.net", "dusaccaidevblobpostcall.blob.core.windows.net"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "comp-hr-hub-to-pep-cognitive"
      source_addresses  = ["172.20.0.144/28"]
      destination_fqdns = ["dusaccaiblobmlw.blob.core.windows.net","dusaccaiblobmlw.file.core.windows.net","ict-platform-ccai-docintel.cognitiveservices.azure.com","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.api.azureml.ms","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.cert.api.azureml.ms","ml-ict-platform-c-uaenorth-a79dcc8c-5548-4d19-b751-7cafcd04b8a2.uaenorth.notebooks.azure.net","*.a79dcc8c-5548-4d19-b751-7cafcd04b8a2.inference.uaenorth.api.azureml.ms"]
      port              = "443"
      type              = "Https"
    },
    ##Prod
    {
      name              = "du-hr-ict-prd-pbi-vm-to-internet-01"
      source_addresses  = ["172.20.6.164"]
      destination_fqdns = ["*", "*.azure.net", "*.powerbi.com", "apps.identrust.com", "cm.mgid.com", "code.yengo.com", "config.edge.skype.com", "dc.services.visualstudio.com", "js.monitor.azure.com", "login.live.com", "login.microsoftonline.com", "logincdn.msftauth.net", "management.azure.com", "*.microsoft.com", "r.msftstatic.com", "*.msn.com", "*.akamaized.net", "*.azureedge.net", "*.nelreports.net", "*.bing.com", "*.msauth.net", "*.msftncsi.com", "*.windows.net", "*.frontend.clouddatahub.net", "*.github.com", "*.githubusercontent.com", "github.githubassets.com", "edge.microsoft.com", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "ne.frontend.clouddatahub.net", "edr-weu3.eu.endpoint.security.microsoft.com", "v20.events.data.microsoft.com", "northeurope-2.in.applicationinsights.azure.com", "fe2cr.update.microsoft.com", "fe3cr.delivery.mp.microsoft.com", "wabi-north-europe-relay12.servicebus.windows.net", "msedge.api.cdp.microsoft.com", "config.edge.skype.com", "tsfe.trafficshaping.dsp.mp.microsoft.com", "business.bing.com", "wabi-north-europe-redirect.analysis.windows.net", "app.powerbi.com", "content.powerapps.com", "europe.ces.microsoftcloud.com", "g17-prod-db4-005-sb.servicebus.windows.net", "g0-prod-db4-005-sb.servicebus.windows.net", "g12-prod-db4-005-sb.servicebus.windows.net", "g5-prod-db4-005-sb.servicebus.windows.net", "pbipneu1-northeurope.pbidedicated.windows.net"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-pbi-vm-to-internet-02"
      source_addresses  = ["172.20.6.164"]
      destination_fqdns = ["au.download.windowsupdate.com", "ctldl.windowsupdate.com", "download.windowsupdate.com", "*"]
      port              = "80"
      type              = "Http"
    },
    {
      name              = "du-hr-ict-prd-pbi-vm-to-apigee"
      source_addresses  = ["172.20.6.164"]
      destination_fqdns = ["tqcmajor-apigwnonprod.corp.du.ae"]
      port              = "9102"
      type              = "Http"
    },
    {
      name              = "du-hr-ict-prd-development-vm-to-internet-01"
      source_addresses  = ["172.20.6.165", "172.20.6.166", "172.20.6.167"]
      destination_fqdns = ["*", "edge.microsoft.com", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "client.wns.windows.com", "eu-v20.events.endpoint.security.microsoft.com", "az764295.vo.msecnd.net", "login.microsoftonline.com", "events.launchdarkly.com", "mdav.eu.endpoint.security.microsoft.com", "settings-win.data.microsoft.com", "default.exp-tas.com", "v10.events.data.microsoft.com", "westus-0.in.applicationinsights.azure.com", "edge.microsoft.com", "go.microsoft.com", "login.live.com", "geo.prod.do.dsp.mp.microsoft.com", "cp601.prod.do.dsp.mp.microsoft.com", "kv601.prod.do.dsp.mp.microsoft.com", "geover.prod.do.dsp.mp.microsoft.com", "umwatson.events.data.microsoft.com", "clientstream.launchdarkly.com", "portal.azure.com", "js.monitor.azure.com", "learn.microsoft.com", "europe.smartscreen.microsoft.com", "wcpstatic.microsoft.com", "aadcdn.msftauth.net", "functional.events.data.microsoft.com", "srtb.msn.com", "browser.events.data.msn.com", "sb.scorecardresearch.com", "assets.msn.com", "r.msftstatic.com", "ntp.msn.com", "nav.smartscreen.microsoft.com", "aadcdn.msauth.net", "eu-mobile.events.data.microsoft.com", "enterpriseregistration.windows.net", "aadcdn.msftauthimages.net", "img-s-msn-com.akamaized.net", "c.msn.com", "c.bing.com", "api.msn.com", "aadcdn.msauthimages.net", "graph.microsoft.com"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-development-vm-to-internet-02"
      source_addresses  = ["172.20.6.165", "172.20.6.166", "172.20.6.167"]
      destination_fqdns = ["*", "edge.microsoft.com", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "client.wns.windows.com", "eu-v20.events.endpoint.security.microsoft.com", "az764295.vo.msecnd.net", "login.microsoftonline.com", "events.launchdarkly.com", "mdav.eu.endpoint.security.microsoft.com", "settings-win.data.microsoft.com", "default.exp-tas.com", "v10.events.data.microsoft.com", "westus-0.in.applicationinsights.azure.com", "edge.microsoft.com", "go.microsoft.com", "login.live.com", "geo.prod.do.dsp.mp.microsoft.com", "cp601.prod.do.dsp.mp.microsoft.com", "kv601.prod.do.dsp.mp.microsoft.com", "geover.prod.do.dsp.mp.microsoft.com", "umwatson.events.data.microsoft.com", "clientstream.launchdarkly.com", "portal.azure.com", "js.monitor.azure.com", "learn.microsoft.com", "europe.smartscreen.microsoft.com", "wcpstatic.microsoft.com", "aadcdn.msftauth.net", "functional.events.data.microsoft.com", "srtb.msn.com", "browser.events.data.msn.com", "sb.scorecardresearch.com", "assets.msn.com", "r.msftstatic.com", "ntp.msn.com", "nav.smartscreen.microsoft.com", "aadcdn.msauth.net", "eu-mobile.events.data.microsoft.com", "enterpriseregistration.windows.net", "aadcdn.msftauthimages.net", "img-s-msn-com.akamaized.net", "c.msn.com", "c.bing.com", "api.msn.com", "aadcdn.msauthimages.net", "graph.microsoft.com"]
      port              = "10255"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-development-vm-to-apigee"
      source_addresses  = ["172.20.6.0/26", "172.20.6.64/26", "172.20.6.165", "172.20.6.166", "172.20.6.167"]
      destination_fqdns = ["tqcmajor-apigwnonprod.corp.du.ae"]
      port              = "9102"
      type              = "Http"
    },
    {
      name              = "du-hr-ict-prd-py-app-to-internet"
      source_addresses  = ["172.20.6.64/26"]
      destination_fqdns = ["*.azure-api.net", "*.azurewebsites.net", "ict-platform-hrbot-prod-oai.openai.azure.com", "pypi.org", "*.pythonhosted.org", "*python.org", "*npmjs.com", "*npmjs.org", "*nodejs.org", "*.botframework.com", "token.botframework.com", "dc.applicationinsights.azure.com", "dc.applicationinsights.microsoft.com", "dc.services.visualstudio.com", "*.in.applicationinsights.azure.com", "live.applicationinsights.azure.com", "rt.applicationinsights.microsoft.com", "rt.services.visualstudio.com", "*.livediagnostics.monitor.azure.com", "login.windows.net", "login.microsoftonline.com", "sts.windows.net", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "login.windows.com", "*"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-py-app-to-prd-mongodb"
      source_addresses  = ["172.20.6.64/26"]
      destination_fqdns = ["ict-platform-hrbot-prod-database-cosmos.mongo.cosmos.azure.com"]
      port              = "10255"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-node-app-to-internet"
      source_addresses  = ["172.20.6.0/26"]
      destination_fqdns = ["*.azure-api.net", "*.azurewebsites.net", "*pypi.org", "*.pythonhosted.org", "*python.org", "*npmjs.com", "*npmjs.org", "*nodejs.org", "*.botframework.com", "token.botframework.com", "dc.applicationinsights.azure.com", "dc.applicationinsights.microsoft.com", "dc.services.visualstudio.com", "*.in.applicationinsights.azure.com", "live.applicationinsights.azure.com", "rt.applicationinsights.microsoft.com", "rt.services.visualstudio.com", "*.livediagnostics.monitor.azure.com", "login.windows.net", "login.microsoftonline.com", "sts.windows.net", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.openai.azure.com", "*.documents.azure.com", "*.mongo.cosmos.azure.com", "*.vaultcore.azure.net", "*.search.windows.net", "*.azurewebsites.net", "*.cognitiveservices.azure.com", "login.windows.com", "uaenorth-0.in.applicationinsights.azure.com", "profiler.monitor.azure.com", "agent.azureserviceprofiler.net", "uaenorth.livediagnostics.monitor.azure.com", "dc.services.visualstudio.com", "eastus-2.in.applicationinsights.azure.com"]
      port              = "443"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-to-apigee-01"
      source_addresses  = ["172.20.6.64/26", "172.20.6.160/28"]
      destination_fqdns = ["api.du.ae", "94.203.233.45", "5.32.4.189", "5.32.6.157"]
      port              = "9141"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-to-apigee-03"
      source_addresses  = ["172.20.6.64/26", "172.20.6.160/28"]
      destination_fqdns = ["94.203.233.45"]
      port              = "9143"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-to-apigee-04"
      source_addresses  = ["172.20.6.64/26", "172.20.6.160/28"]
      destination_fqdns = ["94.203.233.45"]
      port              = "9144"
      type              = "Https"
    },
    {
      name              = "du-hr-ict-prd-to-apigee-02"
      source_addresses  = ["172.20.6.64/26", "172.20.6.160/28"]
      destination_fqdns = ["preview.api.du.ae", "94.203.233.45", "5.32.4.190"]
      port              = "9142"
      type              = "Https"
    }
  ]

  firewall_network_rules = [
    {
      name                  = "HubVNettoDevCompSnet"
      source_addresses      = ["172.20.0.0/22"]
      destination_ports     = ["443", "3389"]
      destination_addresses = ["172.20.4.160/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-hr-hub-to-comp-gitex-prd"
      source_addresses      = ["172.20.0.144/28"]
      destination_ports     = ["3389"]
      destination_addresses = ["172.20.15.160/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "HubWorkloadSnettoApigeeIp"
      source_addresses      = ["172.20.0.144/28"]
      destination_ports     = ["9102", "443"]
      destination_addresses = ["94.203.233.45"]
      protocols             = ["TCP"]
    },
    {
      name                  = "DevVNettoHubVNet"
      source_addresses      = ["172.20.4.0/24"]
      destination_ports     = ["443", "80", "3389"]
      destination_addresses = ["172.20.0.0/22"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "DevVNettoProdVNet"
      source_addresses      = ["172.20.4.0/24"]
      destination_ports     = ["443", "80", "3389"]
      destination_addresses = ["172.20.6.0/24"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "DevVNettoApigeeIp"
      source_addresses      = ["172.20.4.0/26", "172.20.4.160/28"]
      destination_ports     = ["9102", "443"]
      destination_addresses = ["94.203.233.45"]
      protocols             = ["TCP"]
    },
    ##Prod
    {
      name                  = "du-hr-ict-shrd-to-prd-wrkld"
      source_addresses      = ["172.20.0.0/22"]
      destination_ports     = ["3389", "443", "80"]
      destination_addresses = ["172.20.6.160/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "du-hr-ict-prd-to-hub"
      source_addresses      = ["172.20.6.0/24"]
      destination_ports     = ["3389", "443", "80"]
      destination_addresses = ["172.20.0.0/22"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "du-hr-ict-prd-wrkld-to-apigee"
      source_addresses      = ["172.20.6.64/26", "172.20.6.160/28"]
      destination_ports     = ["9102", "443"]
      destination_addresses = ["94.203.233.45"]
      protocols             = ["TCP"]
    },
    {
      name                  = "du-hr-ict-prd-wrkld-to-dev-wrkld"
      source_addresses      = ["172.20.6.160/28"]
      destination_ports     = ["3389", "443"]
      destination_addresses = ["172.20.4.160/28"]
      protocols             = ["TCP", "ICMP"]
    }
  ]

  ## Gitex Firewall Rules

  application_rules_gitex = [
{
      name              = "sha-gitex-prd-to-internet"
      source_addresses  = ["172.20.15.164"]
      destination_fqdns = ["update.code.visualstudio.com","microsoft.com","*.actions.githubusercontent.com", "*.azure.net", "*.azuredatabricks.net", "*.azureedge.net", "*.blob.core.windows.net", "*.dfs.core.windows.net", "*.digicert.com", "*.github.com", "*.githubusercontent.com", "*.hashicorp.com", "*.microsoft.com", "*.pkg.github.com", "*.powershellgallery.com", "aadcdn.msftauth.net", "api.github.com", "avatars.githubusercontent.com", "codeload.github.com", "developer.hashicorp.com", "github.githubassets.com", "github-registry-files.githubusercontent.com", "github-releases.githubusercontent.com", "login.live.com", "login.microsoftonline.com", "logincdn.msftauth.net", "management.azure.com", "objects.githubusercontent.com", "objects-origin.githubusercontent.com", "portal.azure.com", "raw.githubusercontent.com", "releases.hashicorp.com", "results-receiver.actions.githubusercontent.com", "www.hashicorp.com", "www.terraform.io", "*.terraform.io", "aadcdn.msftauthimages.net", "dev.azure.com", "*.dev.azure.com", "aka.ms", "management.core.windows.net", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.msftauth.net", "c2rsetup.officeapps.live.com", "*.visualstudio.com", "pypi.org", "files.pythonhosted.org", "vstsagentpackage.azureedge.net", "edge.microsoft.com", "ecs.office.com", "vssps.dev.azure.com", "vsblobprodweu2.vsblob.visualstudio.com", "spsprodneu1.vssps.visualstudio.com", "github.com", "inference.location.live.net", "th.bing.com", "r.bing.com", "www2.bing.com", "fp.msedge.net"]
      protocols = [
        {
          type = "Https"
          port = 443
        }
      ]
    },
    {
      name              = "dev02-gitex-prd-to-internet"
      source_addresses  = ["172.20.15.165"]
      destination_fqdns = ["nodejs.org","npmjs.com","management.azure.com","*.ngrok-free.app","update.code.visualstudio.com","microsoft.com","bifrost-v10.getpostman.com", "*.microsoft.com", "login.microsoftonline.com", "*.applicationinsights.azure.com", "*.azureedge.net", "*.powershellgallery.com", "pypi.org", "files.pythonhosted.org", "aka.ms", "vstsagentpackage.azureedge.net", "dev.azure.com", "*.dev.azure.com", "management.core.windows.net", "*.vsasset.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.azure.net", "*.monitor.azure.com", "*.vsassets.io","main.vscode-cdn.net","portal.azure.com","aadcdn.msauth.net"]
      protocols = [
        {
          type = "Https"
          port = 443
        }
      ]
    },
    {
      name              = "dev01-gitex-prd-to-internet"
      source_addresses  = ["172.20.15.166"]
      destination_fqdns = ["nodejs.org","npmjs.com","management.azure.com","update.code.visualstudio.com","bifrost-v10.getpostman.com","*.microsoft.com", "login.microsoftonline.com", "*.applicationinsights.azure.com", "*.azureedge.net", "*.powershellgallery.com", "pypi.org", "files.pythonhosted.org", "aka.ms", "vstsagentpackage.azureedge.net", "dev.azure.com", "*.dev.azure.com", "management.core.windows.net", "*.vsassets.io", "*.vsblob.visualstudio.com", "*.vssps.visualstudio.com", "*.vstmr.visualstudio.com", "*.azure.net", "*.monitor.azure.com", "portal.azure.com", "aadcdn.msauth.net","main.vscode-cdn.net","*.vsassets.io"]
      protocols = [
        {
          type = "Https"
          port = 443
        }
      ]
    },
    {
      name              = "comp-gitex-prd-to-pep-gitex-prd"
      source_addresses  = ["172.20.15.160/28"]
      destination_fqdns = ["oryx-cdn.microsoft.io","strgacc421.blob.core.windows.net","ict-platform-gitex-prod-spch.cognitiveservices.azure.com","login.live.com","*.msftauth.net","dusagitexprodgitexdata.queue.core.windows.net","ict-platform-gitex-prod-node-app.azurewebsites.net", "ict-platform-gitex-prod-node-app.scm.azurewebsites.net", "ict-platform-gitex-prod-py-app.azurewebsites.net", "ict-platform-gitex-prod-py-app.scm.azurewebsites.net","static.edge.microsoftapp.net","ict-platform-ccai-oai.openai.azure.com", "ict-platform-gitex-prod-srch.search.windows.net", "ict-platform-gitex-prod-di.cognitiveservices.azure.com", "ict-plat-gitex-prod-kv.vault.azure.net", "dusagitexprodgitexdata.blob.core.windows.net", "dusagitexprodgitexdata.dfs.core.windows.net", "dusagitexprodtfstate.blob.core.windows.net"]
      protocols = [
        {
          type = "Https"
          port = 443
        }
      ]
    },
    {
      name              = "pyapp-gitex-prd-to-internet"
      source_addresses  = ["172.20.15.64/26"]
      destination_fqdns = ["oryx-cdn.microsoft.io","api.bing.microsoft.com","management.azure.com","pypi.org", "dc.services.visualstudio.com", "files.pythonhosted.org", "openaipublic.blob.core.windows.net", "*.applicationinsights.azure.com", "aadcdn.msauth.net"]
      protocols = [
        {
          type = "Https"
          port = 443
        }
      ]
    },
    {
      name              = "pyapp-gitex-prd-to-pep-gitex-prd"
      source_addresses  = ["172.20.15.64/26"]
      destination_fqdns = ["dusagitexprodgitexdata.queue.core.windows.net","ict-platform-ccai-oai.openai.azure.com", "ict-platform-gitex-prod-spch.cognitiveservices.azure.com","login.live.com","*.msftauth.net","ict-platform-gitex-prod-srch.search.windows.net", "ict-platform-gitex-prod-di.cognitiveservices.azure.com", "ict-plat-gitex-prod-kv.vault.azure.net", "dusagitexprodgitexdata.blob.core.windows.net", "dusagitexprodgitexdata.dfs.core.windows.net"]
      protocols = [
        {
          type = "Https"
          port = 443
        }
      ]
    }

  ]

  firewall_network_rules_gitex = [
    {
      name                  = "comp-gitex-prd-to-comp-hr-hub"
      source_addresses      = ["172.20.15.160/28"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["172.20.0.144/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-gitex-prd-to-comp-cognitive"
      source_addresses      = ["172.20.15.160/28"]
      destination_ports     = ["22", "3389"]
      destination_addresses = ["172.20.12.160/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-gitex-prd-to-pep-cognitive"
      source_addresses      = ["172.20.15.160/28"]
      destination_ports     = ["443"]
      destination_addresses = ["172.20.12.128/27"]
      protocols             = ["TCP", "ICMP"]
    },
     {
      name                  = "comp-gitex-prd-to-spch-avatar"
      source_addresses      = ["172.20.15.160/28"]
      destination_ports     = ["*"]
      destination_addresses = ["20.202.56.65","65.52.250.96","20.202.170.45","20.202.170.77","20.202.170.69","20.43.132.0","20.44.242.232","4.240.55.88","104.89.173.222","13.89.178.27","40.81.94.65","10.240.151.67","20.44.241.152","20.44.242.81","20.44.242.198","10.240.101.180","20.202.170.22","20.202.41.36","10.240.159.25","20.202.170.44","20.44.241.224","20.202.170.33","20.202.41.17","10.240.182.64","20.202.41.3","20.202.41.18","20.202.41.34","10.240.204.243","10.240.159.253","20.202.41.1","20.202.170.66","10.240.123.205","20.202.41.37","20.202.170.0","20.202.41.33","20.202.41.16","10.240.123.214","13.107.246.68","20.202.170.9","10.240.195.167","20.44.242.103","23.54.82.170","20.202.41.19","20.202.56.110","20.189.173.25","52.168.117.168","104.91.33.167","13.71.55.58","23.54.80.64","20.202.41.2","20.202.170.11","8.8.4.4","20.202.41.38","10.240.18.106","20.202.170.12","20.202.170.16","216.239.34.181","8.8.8.8","13.107.21.239","20.202.56.30","20.202.56.124","20.202.56.31","20.202.41.0","13.107.246.48","20.202.170.17","20.202.170.32","13.69.239.79","20.189.173.16","23.54.83.98","104.97.76.209","23.54.82.200","*","23.54.82.185","20.202.41.32","20.202.170.67","20.202.41.39","20.202.41.35","20.202.170.58","20.202.170.60"]
      protocols             = ["UDP"]
    }
  ]

  ##CCAI Dev firewall rules
  application_rules_ccai_dev = [
    {
      name              = "comp-ccai-dev-to-pep-ccai-dev"
      source_addresses  = ["172.20.8.96/27"]
      destination_fqdns = ["dusaccaidevadlsingestion.blob.core.windows.net", "dusaccaidevadlsingestion.dfs.core.windows.net", "dusaccaidevblobpostcall.blob.core.windows.net"]
      protocols = [
        {
          port = "443"
          type = "Https"
        }
      ]
    },
    {
      name              = "comp-ccai-dev-to-pep-cognitive"
      source_addresses  = ["172.20.8.96/27"]
      destination_fqdns = ["dusaccaiblobmlw.blob.core.windows.net","dusaccaiblobmlw.file.core.windows.net","ict-platform-ccai-docintel.cognitiveservices.azure.com","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.api.azureml.ms","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.cert.api.azureml.ms","ml-ict-platform-c-uaenorth-a79dcc8c-5548-4d19-b751-7cafcd04b8a2.uaenorth.notebooks.azure.net","*.a79dcc8c-5548-4d19-b751-7cafcd04b8a2.inference.uaenorth.api.azureml.ms"]
      protocols = [
        {
          port = "443"
          type = "Https"
        }
      ]
    },
    {
      name              = "dsha01-ccai-dev-to-internet"
      source_addresses  = ["172.20.8.100"]
      destination_fqdns = ["*.microsoft.com","*.azureedge.net","*.powershellgallery.com","pypi.org","files.pythonhosted.org","aka.ms","management.core.windows.net","*.blob.core.windows.net","*.vsassets.io","*.aadcdn.msftauth.net","*.logincdn.msftauth.net","*.msauth.net","*.microsoftonline-p.com","*.azure.com","*.microsoftonline.com","*.visualstudio.com","*.sharepointonline.com","*.live.com","*.azure.net"]
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
      name              = "jbx01-ccai-dev-to-internet"
      source_addresses  = ["172.20.8.101"]
      destination_fqdns = ["*.microsoft.com","*.azureedge.net","*.powershellgallery.com","pypi.org","files.pythonhosted.org","aka.ms","management.core.windows.net","*.blob.core.windows.net","*.vsassets.io","*.aadcdn.msftauth.net","*.logincdn.msftauth.net","*.msauth.net","*.microsoftonline-p.com","*.azure.com","*.microsoftonline.com","*.visualstudio.com","*.sharepointonline.com","*.live.com","*.azure.net"]
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

  network_rules_ccai_dev = [
    {
      name                  = "comp-ccai-dev-to-comp-hr-hub"
      source_addresses      = ["172.20.8.96/27"]
      destination_ports     = ["3389"]
      destination_addresses = ["172.20.0.144/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-ccai-dev-to-comp-cognitive"
      source_addresses      = ["172.20.8.96/27"]
      destination_ports     = ["3389"]
      destination_addresses = ["172.20.12.160/27"]
      protocols             = ["TCP", "ICMP"]
    }
  ]

  ##Cognitive firewall rules
  application_rules_cognitive = [
    {
      name              = "comp-cognitive-to-pep-cognitive"
      source_addresses  = ["172.20.12.160/27"]
      destination_fqdns = ["dusaccaiblobmlw.blob.core.windows.net","dusaccaiblobmlw.file.core.windows.net","ict-platform-ccai-docintel.cognitiveservices.azure.com","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.api.azureml.ms","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.cert.api.azureml.ms","ml-ict-platform-c-uaenorth-a79dcc8c-5548-4d19-b751-7cafcd04b8a2.uaenorth.notebooks.azure.net","*.a79dcc8c-5548-4d19-b751-7cafcd04b8a2.inference.uaenorth.api.azureml.ms"]
      protocols = [
        {
          port = "443"
          type = "Https"
        }
      ]
    },
    {
      name              = "ml-cognitive-to-internet"
      source_addresses  = ["172.20.12.64/26"]
      destination_fqdns = ["login.microsoftonline.com", "management.azure.com", "ml.azure.com", "*.debian.org", "*.azureml.ms", "*.azureml.net", "*.notebooks.azure.net", "*.file.core.windows.net", "*.dfs.core.windows.net", "*.blob.core.windows.net", "graph.microsoft.com", "*.aznbcontent.net", "automlresources-prod.azureedge.net", "aka.ms", "graph.windows.net", "*.centralindia.batch.azure.com", "*.centralindia.service.batch.azure.com", "*.table.core.windows.net", "*.queue.core.windows.net", "*.file.core.windows.net", "*.vault.azure.net", "mcr.microsoft.com", "*.data.mcr.microsoft.com", "dc.applicationinsights.azure.com", "dc.applicationinsights.microsoft.com", "dc.services.visualstudio.com", "*.in.applicationinsights.azure.com", "*.vscode.dev", "*.vscode-unpkg.net", "*.vscode-cdn.net", "*.vscodeexperiments.azureedge.net", "default.exp-tas.com", "code.visualstudio.com", "update.code.visualstudio.com", "*.vo.msecnd.net", "marketplace.visualstudio.com", "*.gallerycdn.vsassets.io", "*.raw.githubusercontent.com", "anaconda.com", "*.anaconda.com", "*.anaconda.org", "pypi.org", "*pytorch.org", "*.tensorflow.org", "*.kusto.windows.net", "*.azurecr.io", "archive.ubuntu.com", "security.ubuntu.com", "ppa.launchpad.net"]
      protocols = [
        {
          port = "80"
          type = "Http"
        },
        {
          port = "443"
          type = "Https"
        },
        {
          port = "445"
          type = "Https"
        },
        {
          port = "8787"
          type = "Https"
        },
        {
          port = "18881"
          type = "Https"
        },
        {
          port = "5831"
          type = "Https"
        }
      ]
    },
    {
      name              = "ml-cognitive-to-pep-ccai-dev"
      source_addresses  = ["172.20.12.64/26"]
      destination_fqdns = ["dusaccaidevadlsingestion.blob.core.windows.net", "dusaccaidevadlsingestion.dfs.core.windows.net", "dusaccaidevblobpostcall.blob.core.windows.net"]
      protocols = [
        {
          port = "443"
          type = "Https"
        }
      ]
    },
    {
      name              = "ml-cognitive-to-pep-cognitive"
      source_addresses  = ["172.20.12.64/26"]
      destination_fqdns = ["dusaccaiblobmlw.blob.core.windows.net","dusaccaiblobmlw.file.core.windows.net","ict-platform-ccai-docintel.cognitiveservices.azure.com","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.api.azureml.ms","a79dcc8c-5548-4d19-b751-7cafcd04b8a2.workspace.uaenorth.cert.api.azureml.ms","ml-ict-platform-c-uaenorth-a79dcc8c-5548-4d19-b751-7cafcd04b8a2.uaenorth.notebooks.azure.net","*.a79dcc8c-5548-4d19-b751-7cafcd04b8a2.inference.uaenorth.api.azureml.ms"]
      protocols = [
        {
          port = "443"
          type = "Https"
        }
      ]
    },
    {
      name              = "dsha01-cognitive-to-internet"
      source_addresses  = ["172.20.12.164"]
      destination_fqdns = ["*.microsoft.com","*.azureedge.net","*.powershellgallery.com","pypi.org","files.pythonhosted.org","aka.ms","management.core.windows.net","*.blob.core.windows.net","*.vsassets.io","*.aadcdn.msftauth.net","*.logincdn.msftauth.net","*.msauth.net","*.microsoftonline-p.com","*.azure.com","*.microsoftonline.com","*.visualstudio.com","*.sharepointonline.com","*.live.com","*.azure.net"]
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
      name                  = "comp-cognitive-to-comp-hr-hub"
      source_addresses      = ["172.20.12.160/27"]
      destination_ports     = ["3389"]
      destination_addresses = ["172.20.0.144/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "comp-cognitive-to-comp-ccai-dev"
      source_addresses      = ["172.20.12.160/27"]
      destination_ports     = ["3389"]
      destination_addresses = ["172.20.8.96/27"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "ml-cognitive-to-azuread"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["80", "443"]
      destination_addresses = ["AzureActiveDirectory"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-azureml-01"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443", "8787", "18881", "44224"]
      destination_addresses = ["AzureMachineLearning"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-azureml-02"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["5831"]
      destination_addresses = ["AzureMachineLearning"]
      protocols             = ["UDP"]
    },
    {
      name                  = "ml-cognitive-to-batchnodemgmt"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["BatchNodeManagement.UAENorth"]
      protocols             = ["Any"]
    },
    {
      name                  = "ml-cognitive-to-azureresourcemgr"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["AzureResourceManager"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-storage"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443", "445"]
      destination_addresses = ["Storage.UAENorth"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-azurefrontdoor"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["AzureFrontDoor.FrontEnd"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-mcr"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["MicrosoftContainerRegistry.UAENorth"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-azurefirstparty"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["Frontdoor.FirstParty"]
      protocols             = ["TCP"]
    },
    {
      name                  = "ml-cognitive-to-azuremonitor"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["AzureMonitor"]
      protocols             = ["TCP"]
    },
    {
      name                  = "comp-cognitive-to-comp-gitex-prd"
      source_addresses      = ["172.20.12.160/27"]
      destination_ports     = ["3389"]
      destination_addresses = ["172.20.15.160/28"]
      protocols             = ["TCP", "ICMP"]
    },
    {
      name                  = "ml-cognitive-to-azurekeyvault"
      source_addresses      = ["172.20.12.64/26"]
      destination_ports     = ["443"]
      destination_addresses = ["Keyvault.UAENorth"]
      protocols             = ["TCP"]
    }
  ]
}
