param appService object
param location string

resource adminSite 'Microsoft.Web/sites@2022-09-01' = {
  name: appService.admin
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: 'pdmeshacceleratorwa-admin.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: 'pdmeshacceleratorwa-admin.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: asp.id
    customDomainVerificationId: '8A4D62EF2B4DBA749EC787BFBD15AAA3C3E6296481BA1C3D17FD28AC6D069025'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource portalSite 'Microsoft.Web/sites@2022-09-01' = {
  name: appService.portal
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: 'pdmeshacceleratorwa-portal.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: 'pdmeshacceleratorwa-portal.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: asp.id
    customDomainVerificationId: '8A4D62EF2B4DBA749EC787BFBD15AAA3C3E6296481BA1C3D17FD28AC6D069025'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource asp 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appService.plan
  location: location
  sku: {
    name: 'D1'
    tier: 'Shared'
    size: 'D1'
    family: 'D'
    capacity: 0
  }
  kind: 'app'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}