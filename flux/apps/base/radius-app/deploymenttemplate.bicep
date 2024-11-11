extension radius

param namespace string
param replicas int
param labels array
param annotations array

var commonLabels = [
  {
    name: 'app.kubernetes.io/name'
    value: 'radius-app'
  }
  {
    name: 'app.kubernetes.io/instance'
    value: 'radius-app'
  }
  {
    name: 'app.kubernetes.io/managed-by'
    value: 'bicep'
  }
]

var commonAnnotations = [
  {
    name: 'app.kubernetes.io/version'
    value: '1.0'
  }
]

resource env 'Applications.Core/environments@2023-10-01-preview' = {
  name: 'dv'
  properties: {
    compute: {
      kind: 'kubernetes'
      namespace: namespace
    }
  }
}

var allLabels = concat(commonLabels, labels)
var allAnnotations = concat(commonAnnotations, annotations)

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'app'
  properties: {
    environment: env.id
    extensions: [
      {
        kind: 'kubernetesMetadata'
        labels: allLabels
        annotations: allAnnotations
      }
    ]
  }
}

resource ctnr 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'ctnr'
  properties: {
    application: app.id
    container: {
      image: 'ghcr.io/radius-project/samples/demo:latest'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    extensions: [
      {
        kind: 'manualScaling'
        replicas: replicas
      }
      {
        kind: 'kubernetesNamespace'
        namespace: namespace
      }
    ]
  }
}
