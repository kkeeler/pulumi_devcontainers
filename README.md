# DevContainer Support :rocket:

DevContainers are the fastest and most consistent way to get started as we have prebuilt the container to be ready to start coding.

## Prerequisites

- [Docker-Desktop](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Using Devcontainers

This repository is configured to use Visual Studio Code Devcontainers for a consistent development environment. Follow the steps below to get started:

1. **Clone the repository:**

   ```sh
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Open the repository in Visual Studio Code:**

   ```sh
   code .
   ```

3. **Set up environment variables:**
   **This is optional as post-create will automatically setup your environment by logging into pulumi automatically. Although some containers are configured to still use it. But we should remove in favor of pulumi login browser support. But helpful for CI/CD systems**
   Copy the [.sample.env](.sample.env) file to .env and fill in the required values:

   ```sh
   cp .sample.env .env
   ```

4. **Open the repository in a devcontainer:**

   - Press `F1` to open the command palette.
   - Type `Remote-Containers: Reopen in Container` and select the container you want to use.

   Visual Studio Code will build the devcontainer using the configuration in [devcontainer.json](.devcontainer/aetn-pulumi/devcontainer.json) and [Dockerfile](.devcontainer/aetn-pulumi/Dockerfile).

5. **Post-create setup:**

   After the container is created, the [post-create.sh](.devcontainer/pulumi_full/post-create.sh) script will run automatically to perform any necessary post creation setup.

   This script is different for each container although I would centalize it to one script. But for now it is container specific.

## DevContainers

| devcontainer Name | Description                                                                              |
| ----------------- | ---------------------------------------------------------------------------------------- |
| MS Python         | Barebones Pulumi DevContainer that used Microsofts VS Containers                         |
| pulumi base       | Barebones Pulumi DevContainer that uses official pulumi image                            |
| pulumi full       | Full Pulumi DevContainer that uses official pulumi image with additional tools installed |
