@description('A 3-4 letter customer affix')
param clientAffix string
@description('A 2 letter designator for the environment')
param env string = 'dv'
@description('The component of the project')
param componentAffix string = 'Platform'
@description('The environment index - 0 is the default for the initial environment')
@minValue(0)
@maxValue(9)
param envIndex int = 0
@description('A 3-9 letter project affix')
param projectAffix string
@description('Set to true when the project affix is generic ie Remote Monitoring (rmtmon), traXsmart (txs), etc ')
param qualifyComponentAffix bool = false
@description('Flag to determine whether or not we need to deploy keyvault, note deploying keyvault will delete access policies defined in other templates')
param doesKeyVaultExist bool = false
param sqlAdminLogin string
@secure()
param sqlAdminLoginPassword string


param location string = resourceGroup().location

var clientAffixTitleCase = '${toUpper(first(clientAffix))}${toLower(substring(clientAffix, 1, (length(clientAffix) - 1)))}'
var envIndexVar = ((envIndex > 0) ? envIndex : '')
var componentAffixTitleCase = '${toUpper(first(componentAffix))}${toLower(substring(componentAffix, 1, (length(componentAffix) - 1)))}'
var namingPrefix = '${env}${(qualifyComponentAffix ? '${clientAffixTitleCase}${componentAffixTitleCase}' : clientAffixTitleCase)}${envIndexVar}'
var resourceNames = {
  keyvault: '${namingPrefix}kv'
  sql: {
    server: toLower('${namingPrefix}Sql')
    database: 'AMPSaaSDB'
  }
  appService: {
    plan: '${namingPrefix}Asp'
    portal: '${namingPrefix}Portal'
    admin: '${namingPrefix}Admin'
  }
}

module config 'config/config.bicep' = {
  name: '${componentAffix}Configuration'
  params: {
    environment: toLower(env)
  }
}

// sql server and database + kv secret with connection string (secret 1/2)
module sql 'modules/sql.bicep' = {
  name: '${componentAffix}Sql'
  params: {
    sqlServerName: resourceNames.sql.server
    sqlDatabaseName: resourceNames.sql.database
    sqlAdminLogin: sqlAdminLogin
    sqlAdminLoginPassword: sqlAdminLoginPassword
    location: location
    sqlSkuName: config.outputs.settings.sql.sku.name
    sqlSkuTier: config.outputs.settings.sql.sku.family
    sqlSkuCapacity: config.outputs.settings.sql.sku.capacity
    kvName: keyvault.outputs.kvName
  }
}

// app service plan + app service + kv secret ADApplicationSecret (secret 2/2)
module appService 'modules/apps.bicep' = {
  name: '${componentAffix}AppService'
  params: {
    aspSku: config.outputs.settings.appServicePlan.sku
    aspProperties: config.outputs.settings.appServicePlan.properties
    location: location
    resourceNames: resourceNames
  }
}

// keyvault
module keyvault 'modules/key-vault.bicep' = {
  name: '${componentAffix}KeyVault'
  params: {
    name: resourceNames.keyvault
    location: location
    doDeploySharedKeyVault: !doesKeyVaultExist
    tags: config.outputs.settings.tags
    skuFamily: config.outputs.settings.keyVault.sku.family
    skuName: config.outputs.settings.keyVault.sku.name
    accessPolicies: config.outputs.settings.keyVault.accessPolicies
  }
}
