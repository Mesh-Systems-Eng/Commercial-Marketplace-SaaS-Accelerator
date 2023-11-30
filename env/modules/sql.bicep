param sqlServerName string
param sqlDatabaseName string
param sqlAdminLogin string
@secure()
param sqlAdminLoginPassword string
param location string
param sqlSkuName string
param sqlSkuTier string
param sqlSkuCapacity int
param kvName string

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminLogin
    administratorLoginPassword: sqlAdminLoginPassword
    version: '12.0'
    minimalTlsVersion: 'None'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }

  resource ampSaasDb 'databases' = {
    name: sqlDatabaseName
    location: location
    sku: {
      name: sqlSkuName
      tier: sqlSkuTier
      capacity: sqlSkuCapacity
    }
    properties: {
      zoneRedundant: false
    }
  }
}

resource allowAzureIp 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  name: 'AllowAzureIP'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}
resource allowIp 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  name: 'AllowIP'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

module connectionKvSecret 'kv-secret.bicep' = {
  name: 'connectionKvSecret'
  params: {
    keyVaultName: kvName
    secretName: 'DefaultConnection'
    value: 'Data Source=tcp:${sqlServer.name}.database.windows.net,1433;Initial Catalog=${sqlDatabaseName};User Id=${sqlAdminLogin}@${sqlServerName}.database.windows.net;Password=${sqlAdminLoginPassword};'
  }
}
