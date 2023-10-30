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
param qualifyProjectAffix bool = false
@description('Flag to determine whether or not we need to deploy keyvault, note deploying keyvault will delete access policies defined in other templates')
param doesKeyVaultExist bool = false

param location string = resourceGroup().location

var clientAffixTitleCase = '${toUpper(first(clientAffix))}${toLower(substring(clientAffix, 1, (length(clientAffix) - 1)))}'
var envIndexVar = ((envIndex > 0) ? envIndex : '')
var projectAffixTitleCase = '${toUpper(first(projectAffix))}${toLower(substring(projectAffix, 1, (length(projectAffix) - 1)))}'
var namingPrefix = '${env}${(qualifyProjectAffix ? '${clientAffixTitleCase}${toLower(projectAffixTitleCase)}' : clientAffixTitleCase)}${envIndexVar}'
var resourceNames = {
  storage: toLower('${namingPrefix}Sa')
  keyvault: '${namingPrefix}kv'
  sql: {
    server: toLower('${namingPrefix}Sql')
    database: toLower('${namingPrefix}Sdb')
    aidatabase: toLower('${env}RebelAi')
  }
  appInsights: '${namingPrefix}ai'
  logAnalytics: '${namingPrefix}la'
  resourcegroup: 'rg-${clientAffix}-${env}'
  appService: {
    plan: '${namingPrefix}Asp'
    portal: '${namingPrefix}Portal'
    admin: '${namingPrefix}Admin'
  }
  backendAppService: '${namingPrefix}BackendAs'
}