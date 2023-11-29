// version: 1.0.1
// Copyright © 2023 Mesh Systems LLC.  All rights reserved.

param keyVaultName string
param secretName string
@secure()
param value string

resource testApiAddress 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: secretName
  properties: {
    value: value
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
}
