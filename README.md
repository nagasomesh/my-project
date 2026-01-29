# My Project - Maven Web Application

This is a Maven-based web application with a responsive HTML/CSS frontend. The project includes Docker containerization and Jenkins CI/CD pipeline configuration.

## Table of Contents
- [Prerequisites](#prerequisites)
- [How to Pull the Project](#how-to-pull-the-project)
- [Project Setup](#project-setup)
- [Building the Application](#building-the-application)
- [Running with Docker](#running-with-docker)
- [CI/CD Pipeline](#cicd-pipeline)
- [Project Structure](#project-structure)

## Prerequisites

Before pulling and running this project, ensure you have the following installed:

- **Git** - Version control system
- **Java JDK 8 or higher** - For Maven builds
- **Apache Maven 3.6+** - Build automation tool
- **Docker** (optional) - For containerized deployment
- **Jenkins** (optional) - For CI/CD pipeline

## How to Pull the Project

### Clone the Repository

To pull/clone this project to your local machine:

```bash
# Using HTTPS
git clone https://github.com/nagasomesh/my-project.git

# OR using SSH
git clone git@github.com:nagasomesh/my-project.git

# Navigate into the project directory
cd my-project
```

### Pull Latest Changes

If you already have the project cloned and want to pull the latest changes:

```bash
# Navigate to the project directory
cd my-project

# Pull the latest changes from the main/master branch
git pull origin main

# Or pull from a specific branch
git pull origin <branch-name>
```

### Check Repository Status

```bash
# Check current branch and status
git status

# View available branches
git branch -a

# View commit history
git log --oneline -10
```

## Project Setup

After pulling the project, follow these steps to set it up:

### Quick Setup (Automated)

Run the setup script to automatically check prerequisites and build the project:

```bash
# Make the script executable (if not already)
chmod +x setup.sh

# Run the setup script
./setup.sh

# Or run with bash directly
bash setup.sh
```

The setup script will:
- Verify all prerequisites are installed
- Build the Maven project
- Optionally build and run the Docker container

### Manual Setup

### 1. Verify Java and Maven Installation

```bash
# Check Java version
java -version

# Check Maven version
mvn -version
```

### 2. Install Dependencies

```bash
# Maven will automatically download dependencies
mvn clean install
```

## Building the Application

### Build WAR File

```bash
# Clean and build the project
mvn clean package

# The WAR file will be generated in the target/ directory
# Output: target/maven-web-app.war
```

### Build Docker Image

```bash
# Build the Docker image
docker build -t my-project:latest .

# The image includes Tomcat 9 with the deployed application
```

## Running with Docker

### Run the Application Container

```bash
# Run the container
docker run -d -p 8080:8080 --name my-project-container my-project:latest

# Access the application at: http://localhost:8080/maven-web-app
```

### Manage the Container

```bash
# Stop the container
docker stop my-project-container

# Start the container
docker start my-project-container

# View logs
docker logs my-project-container

# Remove the container
docker rm my-project-container
```

## CI/CD Pipeline

This project includes a Jenkins pipeline configuration (`Jenkinsfile`) that automates:

1. **Checkout Code** - Pulls the latest code from the repository
2. **Build WAR** - Compiles and packages the application using Maven
3. **Build Docker Image** - Creates a Docker image with the application
4. **Login to Docker Hub** - Authenticates with Docker Hub
5. **Push Image** - Publishes the image to Docker Hub

### Jenkins Setup

1. Create a new Pipeline job in Jenkins
2. Point it to this repository
3. Configure Docker Hub credentials with ID: `dockerhub-creds`
4. Run the pipeline

## Project Structure

```
my-project/
├── .gitignore                          # Git ignore file
├── Dockerfile                          # Docker configuration for Tomcat deployment
├── Jenkinsfile                         # Jenkins CI/CD pipeline definition
├── README.md                           # This file
├── pom.xml                             # Maven project configuration
├── readme.txt                          # Template attribution and license (root)
├── setup.sh                            # Automated setup script
├── webhook-test                        # Webhook configuration file
├── index.html                          # Original HTML (kept for reference)
├── style.css                           # Original CSS (kept for reference)
└── src/
    └── main/
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml             # Web application deployment descriptor
            ├── index.html              # Main HTML page
            └── style.css               # Stylesheet for the frontend
```

## Features

- **Maven Build System** - Automated dependency management and build process
- **Responsive Web Design** - HTML/CSS frontend with modern design
- **Docker Support** - Containerized deployment with Tomcat 9
- **CI/CD Ready** - Jenkins pipeline for automated builds and deployments
- **War Packaging** - Deployable WAR file for Java application servers

## Technology Stack

- **Java 8** - Programming language
- **Maven** - Build automation
- **Tomcat 9** - Application server
- **Docker** - Containerization
- **Jenkins** - CI/CD automation
- **HTML/CSS** - Frontend

## License

This template includes content from TemplatesJungle.com. Please see `readme.txt` for full attribution and usage rights.

## Support

For issues or questions about this project:
1. Check existing documentation in `readme.txt`
2. Review the Jenkins pipeline logs for CI/CD issues
3. Ensure all prerequisites are properly installed
4. Verify Docker and Maven configurations

---

**Note**: Make sure to configure your Docker Hub credentials in Jenkins before running the CI/CD pipeline.
