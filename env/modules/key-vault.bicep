// version: 1.0.0
// Copyright © 2023 Mesh Systems LLC.  All rights reserved.

@minLength(3)
@maxLength(24)
param name string
@allowed([
  true
  false
])
param doDeploySharedKeyVault bool = true
param location string
param accessPolicies array = []
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'
param skuFamily string = 'A'
param tenantId string = subscription().tenantId
param tags object

resource sharedKeyVault 'Microsoft.KeyVault/vaults@2023-02-01' = if (doDeploySharedKeyVault) {
  name: name
  location: location
  tags: tags
  properties: {
    accessPolicies: accessPolicies
    sku: {
      family: skuFamily
      name: skuName
    }
    tenantId: tenantId
  }
}
output kvName string = sharedKeyVault.name
