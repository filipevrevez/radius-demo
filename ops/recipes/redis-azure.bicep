// Parameters

@description('The geo-location where the resource lives.')
param location string = resourceGroup().location

@description('The size of the Azure Cache for Redis. Can be Small or Large. Defaults to Small.')
@allowed([
  'Small'
  'Large'
])
param size string = 'Small'
var skuName = size == 'Small' ? 'Standard' : 'Premium'
var skuFamily = size == 'Small' ? 'C' : 'P'



// Resources

resource azureCache 'Microsoft.Cache/redis@2022-06-01' = {
  name: 'cache'
  location: location
  properties: {
    sku: {
      capacity: 3
      family: skuFamily
      name: skuName
    }
    enableNonSslPort: false
    minimumTlsVersion: '1.2'
  }
}

// Outputs

