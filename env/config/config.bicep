param environment string
param baseTime string = utcNow('u')
var settings = loadYamlContent('../../pipelines/variables.yml')

var environmentSettings = {
  dv: {
    name: 'Develop'
    storage: {
      sku: 'Standard_LRS'
    }
    ioth: {
      sku: 'S1'
      capacity: 1
    }
    dps: {
      sku: 'S1'
      capacity: 1
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 1
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
    tags: {
      Owner: 'Matt Ruiz'
      Project: 'Wavelogix Platform'
      Tier: 'Dv'
      Client: settings.variables.clientAffix
      Repository: 'WLGX.Platform.Env'
      'Service Connection': 'Dv_Wvlgx_Deploy'
      'Date Last Deployed': baseTime
    }
  }
  sg: {
    name: 'Staging'
    storage: {
      sku: 'Standard_LRS'
    }
    ioth: {
      sku: 'S1'
      capacity: 1
    }
    dps: {
      sku: 'S1'
      capacity: 1
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 1
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
    tags: {
      Owner: 'Matt Ruiz'
      Project: 'Wavelogix Platform'
      Tier: 'Sg'
      Client: settings.variables.clientAffix
      Repository: 'WLGX.Platform.Env'
      'Service Connection': 'Dv_Wvlgx_Deploy'
      'Date Last Deployed': baseTime
    }
  }
  pd: {
    name: 'Production'
    storage: {
      sku: 'Standard_LRS'
    }
    ioth: {
      sku: 'S1'
      capacity: 1
    }
    dps: {
      sku: 'S1'
      capacity: 1
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 3
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
    tags: {
      Owner: 'Matt Ruiz'
      Project: 'Wavelogix Platform'
      Tier: 'Pd'
      Client: settings.variables.clientAffix
      Repository: 'WLGX.Platform.Env'
      'Service Connection': 'Dv_Wvlgx_Deploy'
      'Date Last Deployed': baseTime
    }
  }
}

output settings object = environmentSettings[environment]