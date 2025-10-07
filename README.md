<!-- NAR - Many Seeds, One System -->

![Nar Logo](docs/assets/nar-transparent.png)

# Nar

Welcome to the **Nar** project! It is a modern, lightweight, and opinionated micro-starter for Spring Boot projects. Nar is designed to help developers quickly bootstrap small and modular Spring Boot applications while following best practices.

## Why "Nar"?

**Nar** means "pomegranate" in Turkish. This symbolic choice represents the idea of many small seeds (microservices) coming together to form a whole fruit (a complete application). Just as a pomegranate is made up of many individual seeds, Nar encourages the development of small, focused services that work together to create a robust and scalable system.

> **Note**: The project is still in its early stages, and we welcome contributions and feedback from the community to help shape its future direction.

---

## Table of Contents

- [Nar](#nar)
  - [Why "Nar"?](#why-nar)
  - [Table of Contents](#table-of-contents)
  - [Built With](#built-with)
  - [Key Features](#key-features)
  - [Development Guide](#development-guide)
    - [1. Prerequisites](#1-prerequisites)
    - [2. Installation](#2-installation)
    - [3. Project Setup](#3-project-setup)
  - [Architecture](#architecture)
  - [Release Notes](#release-notes)
  - [Roadmap](#roadmap)
  - [Development Workflow](#development-workflow)
  - [Contact](#contact)

## Built With

- [Spring Boot 3.5.6](https://projects.spring.io/spring-boot/) - Inversion of Control Framework
- [Spring Cloud](https://spring.io/projects/spring-cloud) - For building robust cloud-native applications
- [Spring Eureka](https://spring.io/projects/spring-cloud-netflix) - Service Discovery
- [Spring Zuul](https://spring.io/projects/spring-cloud-netflix) - API Gateway
- [Spring Config](https://spring.io/projects/spring-cloud-config) - Centralized Configuration Management
- [Spring Web](https://spring.io/projects/spring-framework) - Web Framework
- [Gradle](https://gradle.org/) - Dependency Management

## Key Features

- **Modular Architecture**: Each service is self-contained, promoting separation of concerns and easier maintenance.
- **API Gateway**: Centralized entry point for all client requests, handling routing, security, and rate limiting.
- **Service Discovery**: Automatic detection of services using Netflix Eureka.
- **Centralized Configuration**: Manage application settings across all services with Spring Cloud Config.
- **Security**: Integrated Spring Security for robust authentication and authorization mechanisms.
- **Database Integration**: Pre-configured with PostgreSQL and Hibernate for seamless data management.
- **Containerization**: Docker and Docker Compose support for easy deployment and scaling.

## Development Guide

### 1. Prerequisites

- [Java 21](https://www.oracle.com/java/technologies/javase-jdk21-downloads.html)
- [Gradle](https://gradle.org/install/)
- [Visual Studio Code (Recommended)](https://code.visualstudio.com/download)
- [IntelliJ IDEA (Optional)](https://www.jetbrains.com/idea/download/)
- [Postman](https://www.postman.com/downloads/)
- [Git](https://git-scm.com/downloads)

> **Note**: The project uses Java 21, so make sure to have the correct version installed. You can check the Java version using the following command:

```bash
java -version
```

> **Note**: The project uses IDEs like Visual Studio Code, IntelliJ IDEA, etc. for development. You can use any IDE of your choice. However, **VSCode** is recommended for this project.

### 2. Installation

- Clone the repository

```bash
git clone <repository-url>
```

- Open the project in your favorite IDE

```bash
# For Visual Studio Code
code .

# For IntelliJ IDEA
idea .
```

### 3. Project Setup

- Navigate to the project root directory

```bash
cd nar
```

- Run the project using the following command:

```bash
# For Windows
./start-all.bat

# For Unix-based systems (Linux, macOS)
chmod +x start-all.sh
./start-all.sh
```

> **Note**: The above scripts will start all the services in the correct order with necessary delays. It will also check for port availability and health status of each service before starting the next one.
> **Make sure to run the scripts in a terminal that supports bash (e.g., Git Bash, WSL, etc.) for Windows users.**

- If you want to start each service individually, you can use the following commands:

```bash
# 1. Start Discovery Server first
cd discovery-server && ./gradlew bootRun

# 2. Wait 30 seconds, then start Config Server
cd ../config-server && ./gradlew bootRun

# 3. Wait 20 seconds, then start API Gateway  
cd ../api-gateway && ./gradlew bootRun
```

- After starting all the services, you can access the following URLs to verify that the services are running:

```bash
curl http://localhost:5858/actuator/health
curl http://localhost:5859/actuator/health
curl http://localhost:5860/actuator/health
```

## Architecture

The project is structured in a layered architecture with the following layers:

```bash
.
├── api-gateway
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com
│   │   │   │       └── nar
│   │   │   │           ├── ApiGatewayApplication.java      # Main application class
│   │   │   ├── resources
│   │   │   │   ├── application.properties                  # Application properties
├── config-server
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com
│   │   │   │       └── nar
│   │   │   │           ├── ConfigServerApplication.java    # Main application class
│   │   │   ├── resources
│   │   │   │   ├── config
│   │   │   │   │   └── api-gateway.yml
│   │   │   │   ├── application.properties                  # Application properties
├── discovery-server
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com
│   │   │   │       └── nar
│   │   │   │           ├── DiscoveryServerApplication.java # Main application class
│   │   │   ├── resources
│   │   │   │   ├── application.properties                  # Application properties
├── docs                                                    # Holds project documentations. Markdown sections, etc.
│   └── assets
```

> **Note**: The above diagram is a simplified representation of the project structure. Each service (discovery-server, config-server, api-gateway) is a separate Spring Boot application with its own main class and resources. For more details, please refer to the [Architecture](docs/ARCHITECTURE.md) document.

---

## Release Notes

Please refer to the [Release Notes](docs/RELEASE_NOTES.md) for the release notes and changelog.

## Roadmap

Please refer to the [Roadmap](docs/ROADMAP.md) for the project roadmap and future plans.

## Development Workflow

In the **Nar** project, we follow a structured development workflow to ensure efficient collaboration and code management. This workflow includes the following key components: branching strategy, versioning, and commit message conventions. By following these guidelines, we aim to maintain a clean and organized codebase that is easy to manage and contribute to. For more information, please refer to the [Development Workflow](docs/DEVELOPMENT_WORKFLOW.md) document.

## Contact

Thanks to the following people who have contributed to this project:

- [Yunus Emre Alpu](https://www.linkedin.com/in/yunus-emre-alpu-5b1496151/) - Creator and Maintainer
