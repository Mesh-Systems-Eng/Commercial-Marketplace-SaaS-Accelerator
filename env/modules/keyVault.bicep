param keyVaultName string
param location string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'd49110b2-6f26-4c66-b723-1729cdb9a3cf'
    accessPolicies: [
      {
        tenantId: 'd49110b2-6f26-4c66-b723-1729cdb9a3cf'
        objectId: 'a5280b34-0b66-4a5c-8bbf-bc4c14694b1f'
        permissions: {
          keys: [
            'Get'
            'List'
            'Update'
            'Create'
            'Import'
            'Delete'
            'Recover'
            'Backup'
            'Restore'
            'Decrypt'
            'Encrypt'
            'UnwrapKey'
            'WrapKey'
            'Verify'
            'Sign'
            'Release'
            'Rotate'
            'GetRotationPolicy'
            'SetRotationPolicy'
          ]
          secrets: [
            'Get'
            'List'
            'Set'
            'Delete'
            'Recover'
            'Backup'
            'Restore'
          ]
          certificates: [
            'Get'
            'List'
            'Update'
            'Create'
            'Import'
            'Delete'
            'Recover'
            'Backup'
            'Restore'
            'ManageContacts'
            'ManageIssuers'
            'GetIssuers'
            'ListIssuers'
            'SetIssuers'
            'DeleteIssuers'
          ]
          storage: [
            'all'
          ]
        }
      }
      {
        tenantId: 'd49110b2-6f26-4c66-b723-1729cdb9a3cf'
        objectId: '13193794-13b5-4071-80fd-1869cd0998ed'
        permissions: {
          certificates: []
          keys: []
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
    enableSoftDelete: false
    softDeleteRetentionInDays: 7
    publicNetworkAccess: 'Enabled'
  }
}
resource adApplicationSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'ADApplicationSecret'
  tags: {
    'file-encoding': 'utf-8'
  }
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource defaultConnection 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'DefaultConnection'
  properties: {
    attributes: {
      enabled: true
    }
  }
}