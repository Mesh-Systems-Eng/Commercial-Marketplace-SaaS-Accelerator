param environment string
param baseTime string = utcNow('u')
var settings = loadYamlContent('../../pipelines/variables.yml')

var environmentSettings = {
  sd: {
    name: 'Sandbox'
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
      accessPolicies: [
        {
          tenantId: 'd49110b2-6f26-4c66-b723-1729cdb9a3cf'
          objectId: 'a5280b34-0b66-4a5c-8bbf-bc4c14694b1f'
          permissions: {
            secrets: [
              'Get'
              'List'
              'Set'
              'Delete'
              'Recover'
              'Backup'
              'Restore'
            ]
          }
        }
        {
          tenantId: 'd49110b2-6f26-4c66-b723-1729cdb9a3cf'
          objectId: 'd376f57d-8279-47f2-8e92-5d769f5db8d4'
          permissions: {
            certificates: []
            keys: []
            secrets: [
              'Get'
              'List'
              'Set'
              'Delete'
              'Recover'
              'Backup'
              'Restore'
            ]
          }
        }
      ]
    }
    sql: {
      sku: {
        family: 'Basic'
        name: 'Basic'
        capacity: 5
      }
    }
    tags: {
      Owner: settings.variables.owner
      Project: settings.variables.project
      Tier: 'Sd'
      Client: settings.variables.clientAffix
      Repository: settings.variables.repository
      'Date Last Deployed': baseTime
    }
  }
  dv: {
    name: 'Develop'
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
    sql: {
      sku: {
        family: 'Basic'
        name: 'Basic'
        capacity: 5
      }
    }
    tags: {
      Owner: settings.variables.owner
      Project: settings.variables.project
      Tier: 'Dv'
      Client: settings.variables.clientAffix
      Repository: settings.variables.repository
      'Date Last Deployed': baseTime
    }
  }
  sg: {
    name: 'Staging'
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
    sql: {
      sku: {
        family: 'Basic'
        name: 'Basic'
        capacity: 5
      }
    }
    tags: {
      Owner: settings.variables.owner
      Project: settings.variables.project
      Tier: 'Sg'
      Client: settings.variables.clientAffix
      Repository: settings.variables.repository
      'Date Last Deployed': baseTime
    }
  }
  pd: {
    name: 'Production'
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
    sql: {
      sku: {
        family: 'Basic'
        name: 'Basic'
        capacity: 5
      }
    }
    tags: {
      Owner: settings.variables.owner
      Project: settings.variables.project
      Tier: 'Pd'
      Client: settings.variables.clientAffix
      Repository: settings.variables.repository
      'Date Last Deployed': baseTime
    }
  }
}

output settings object = environmentSettings[environment]
