# Radius Demo

## Introduction

This repository contains a set of applications and recipes that will work with [Radius](https://radapp.io/) control plane designed to streamline and automate application deployment workflows, providing both operations and development teams with a unified, GitOps-driven approach to manage cloud-native applications. This README will guide you through the purpose, benefits, and usage of Radius for both operations users and developers, with a focus on leveraging GitOps principles using Flux.

## Purpose

Modern software development often requires agile, automated, and reliable ways to deploy applications. Radius provides a cloud-native platform for deploying, managing, and scaling applications with ease. Using GitOps practices, we ensure that infrastructure and application code are stored in Git repositories, enabling continuous delivery and version control. This Radius app integrates Flux, an open-source GitOps operator, to enable automated application deployment and configuration management by watching the Git repository and applying changes automatically.

## Why Radius and GitOps with Flux?

Radius, in combination with GitOps principles, addresses some key needs in application deployment and management:

- Consistency and Reliability: By using Git as the single source of truth, changes are versioned, auditable, and traceable, reducing the chance of manual errors.
- Automation: GitOps with Flux allows for automatic synchronization between your Git repository and your Kubernetes cluster, ensuring real-time deployments and updates.
- Collaboration: Both developers and operations users can contribute to and manage the application’s deployment pipeline in a single Git repository, streamlining communication and collaboration.

## Use Cases

### Ops User Use Case

Operations teams play a crucial role in managing and scaling infrastructure. With Radius, they can leverage the following benefits:

- Automated Infrastructure Changes: Changes in the Git repository are automatically deployed to the cluster, reducing the need for manual intervention.
- Environments as Code: Infrastructure configurations are stored in Git, enabling version control, code reviews, and automated deployments.
- Scalability and Reliability: Radius simplifies scaling applications and ensures that the deployed state matches the desired state defined in Git.

### Dev User Use Case

Developers can focus on code while Radius handles deployment logistics. Here’s how Radius benefits the development process:

- Environment Consistency: With GitOps, development, staging, and production environments are defined in code, enabling developers to work in environments that mirror production closely.
- Continuous Delivery: Developers can push code changes to the repository, triggering automated deployments to the Kubernetes cluster.

## GitOps with Flux

Flux, as a GitOps operator, is a core component of our Radius ecosystem. It watches the Git repository for changes and synchronizes the state to the Kubernetes cluster, automating deployments and ensuring that the system state aligns with what is described in Git.

### How it Works

1. Commit: When a change is made in the Git repository, it is committed and pushed.
2. Flux Detection: Flux detects the commit and fetches the updated configurations.
3. Apply Changes: Flux applies the changes to the Kubernetes cluster, ensuring that the deployed application state matches the defined configuration in Git.
4. Sync and Monitoring: Flux continuously monitors the repository for new changes and repeats the process, maintaining real-time consistency.

### GitOps Benefits

- Auditable History: Every change is recorded in Git, providing a complete history of who changed what and when.
- Continuous Reconciliation: Flux continuously reconciles the desired state from the Git repository with the cluster state, identifying and rectifying any drift.
- Security and Compliance: Flux’s pull-based deployment model reduces the need for direct access to the cluster, minimizing security risks.

## Getting Started

To deploy and use the Radius app with Flux, follow these steps:

### Prerequisites

- Git Repository: A Git repository configured to hold your deployment and application configurations.
- Kind Installation: Install Kind to create a Kubernetes cluster for local development.
- GitHub Token: Generate a GitHub token to authenticate Flux with your repository.
- Flux CLI: Install the Flux CLI to interact with Flux and bootstrap the repository.
- Radius CLI: Install the Radius CLI to manage your Radius resources.

### Installation

1. Fork this repository:

2. Clone the repository:

  ```bash
    git clone https://github.com/filipevrevez/radius-demo.git
    cd radius-demo
  ```

3. Create a kind cluster if you're using kind:

  ```bash
    kind create cluster --config dev/kind-config.yaml
  ```

4. Configure Flux: Set up Flux in your Kubernetes cluster and link it to this repository.

  ```bash
    export GITHUB_TOKEN=<your-github-token>
    export GITHUB_USER=<your-github-username>
    
    flux check --pre

    flux bootstrap github \
      --token-auth \
      --owner=${GITHUB_USER} \
      --repository=radius-demo \
      --branch=main \
      --path=flux/clusters/kind \
      --personal

  ```

5. Monitor Deployment: Verify that Radius and your applications are running as expected using kubectl get pods -n your-namespace.

## Contributing

We welcome contributions to improve this Radius demo. Please open a pull request or issue to discuss proposed changes or report issues.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

With Radius and GitOps practices using Flux, this project aims to bring simplicity, consistency, and security to cloud-native application deployments. Whether you’re part of an ops team or a developer, we hope this setup enhances your workflow!
