param sqlServerName string
param location string

resource sqlServer 'Microsoft.Sql/servers@2023-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: 'saasdbadmin502'
    version: '12.0'
    minimalTlsVersion: 'None'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }

  resource allowAzureIp 'firewallRules' = {
    name: 'AllowAzureIP'
  }
  resource allowIp 'firewallRules' = {
    name: 'AllowIP'
  }
  resource serviceManaged 'keys' = {
    name: 'ServiceManaged'
    properties: {
      serverKeyType: 'ServiceManaged'
    }
  }

  resource ampSaasDb 'databases' = {
    name: 'AMPSaaSDB'
    location: location
    sku: {
      name: 'Basic'
      tier: 'Basic'
      capacity: 5
    }
    properties: {
      collation: 'SQL_Latin1_General_CP1_CI_AS'
      maxSizeBytes: 2147483648
      catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
      zoneRedundant: false
      readScale: 'Disabled'
      requestedBackupStorageRedundancy: 'Geo'
      isLedgerOn: false
      availabilityZone: 'NoPreference'
    }
  }
}