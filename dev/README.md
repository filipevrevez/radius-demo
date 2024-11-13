# Developer Experience

## Introduction

This document is intended to provide a high-level overview of the developer experience for the project. It is intended to be a living document that will be updated as the project evolves.

## Development Environment

### Getting Started

#### Initialize Radius

  ```bash
    cd dev/radius-app
    rad init
  ```

#### Check Radius Dashboard

Check radius dashboard for you application status and graph.

  ```bash
    kubectl port-forward svc/dashboard 7234:80 -n radius-system
  ```

Open your browser and go to `http://localhost:7234` and you can see the dashboard.

Or you can see the application graph in the cli.

  ```bash
    rad app graph
  ```

#### Run your application

  ```bash
    rad run app.bicep
  ```

  Visit the application in your browser at `http://localhost:3000`.
  When you're done press `Ctrl+C` to stop the application.

#### Add redis cache to the application

  ```bicep
    @description('The ID of your Radius Environment. Automatically injected by the rad CLI.')
    param environment string

    resource redis 'Applications.Datastores/redisCaches@2023-10-01-preview' = {
      name: 'redis'
      properties: {
        environment: environment
        application: application
      }
    }
  ```
  
#### View the changes
  
  ```bash
    rad run app.bicep
  ```

#### View the changes in the app graph

  You can view the changes in the app graph by running the following command.
  
  ```bash
    rad app graph
  ```

  Or by visiting the radius dashboard and application graph

#### Add your environment variables

  ```bicep
    ...
    container: {
      image: 'ghcr.io/radius-project/samples/demo:latest'
      env: {
          FOO: {
            value: 'bar'
          }
        }
      ...
    }
    ...
  ```

  Run `rad run app.bicep` to view the changes.

### Backend connection

#### Add a backend connection

  ```bicep
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
  ```

  And add the connection to your existing application.

  ```bicep
    ...
    resource demo 'Applications.Core/containers@2023-10-01-preview' = {
    name: 'demo'
    properties: {
      ...
      connections: {
        ...
        backend: {
          source: backend.id
        }
      }
      ....
    }
    ...
  ```

  Run `rad run app.bicep` to view the changes.

