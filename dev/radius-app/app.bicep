extension radius

@description('The Radius Application ID. Injected automatically by the rad CLI.')
param application string



resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'ghcr.io/radius-project/samples/demo:latest'
      // image: 'demo:v0.0.1'
      env: {
        FOO: {
          value: 'bar'
        }
      }
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      redis: {
        source: redis.id
      }
      backend: {
        source: 'http://backend:80'
      }
    }
  }
}

@description('The ID of your Radius Environment. Automatically injected by the rad CLI.')
param environment string

resource redis 'Applications.Datastores/redisCaches@2023-10-01-preview' = {
  name: 'redis'
  properties: {
    environment: environment
    application: application
  }
}


resource backend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'backend'
  properties: {
    application: application
    container: {
      image: 'nginx:latest'
      ports: {
        api: {
          containerPort: 80
        }
      }
    }
  }
}
