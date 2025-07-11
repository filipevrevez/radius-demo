# Radius Demo

## Operator Demo

* Recipes represent reusable resources for applications (e.g., SQL, Redis).
* They provide an abstraction layer to ensure consistency, security, and compliance.
* Recipes require only a minimal set of parameters, abstracting infrastructure details (e.g., size).
* Each recipe includes a context parameter and an output.
* The context parameter, populated by Radius, specifies where to deploy resources.
* The output contains essential information to be using in the application, such as connection strings.

### Convert bicep template to recipe

1. Add context parameter:

   ```bicep
   @description('Radius-provided object containing information about the resouce calling the Recipe')
   param context object
   ```

2. Modify cache name to make it unique:

   ```bicep
     name: 'cache-${uniqueString(context.resource.id)}'
   ```

3. Add output:

   ```bicep
   @description('Output of the recipe. These values will be used to configure connections.')
   output result object = {
     values: {
        host: azureCache.properties.hostName
        port: azureCache.properties.sslPort
        username: ''
        tls: true
     }
     secrets: {
        #disable-next-line outputs-should-not-contain-secrets
        password: azureCache.listKeys().primaryKey
     }
   }
   ```

### Publish recipe in container registry

```bicep
rad bicep publish --file redis-azure.bicep --target "br:radiusdemo.azurecr.io/azure/redis:1.0.0"
```

### Register recipe in environment setting the sku for the environment

```bicep
rad recipe register default -e prod -w default --resource-type Applications.Datastores/redisCaches --template-kind bicep --template-path radiusdemo.azurecr.io/azure/redis:1.0.0 --template-version "1.0.0" -p size="Large"
```

### List published recipe

```bicep
rad recipe list -e prod
```

### List default recipes

```bicep
rad recipe list -e default
```

### Register terraform recipe in environment

```bicep
rad recipe register myrecipe -e terraform --resource-type Applications.Datastores/redisCaches --template-kind terraform --template-path redis-azure.tf --template-version "1.0.0"
```

### List published terraform recipe

```bicep
rad recipe list -e terraform
```
