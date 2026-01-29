#!/bin/bash

###############################################################################
# Project Setup Script
# This script automates the initial setup and verification of the project
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

print_header() {
    echo ""
    echo "======================================"
    echo "$1"
    echo "======================================"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Main setup process
main() {
    print_header "Project Setup - My Maven Web Application"
    
    # Check prerequisites
    print_header "Checking Prerequisites"
    
    # Check Git
    if command_exists git; then
        GIT_VERSION=$(git --version)
        print_success "Git installed: $GIT_VERSION"
    else
        print_error "Git is not installed. Please install Git first."
        exit 1
    fi
    
    # Check Java
    if command_exists java; then
        JAVA_VERSION=$(java -version 2>&1 | head -n 1)
        print_success "Java installed: $JAVA_VERSION"
    else
        print_error "Java is not installed. Please install Java JDK 8 or higher."
        exit 1
    fi
    
    # Check Maven
    if command_exists mvn; then
        MVN_VERSION=$(mvn -version | head -n 1)
        print_success "Maven installed: $MVN_VERSION"
    else
        print_error "Maven is not installed. Please install Apache Maven 3.6+."
        exit 1
    fi
    
    # Check Docker (optional)
    if command_exists docker; then
        DOCKER_VERSION=$(docker --version)
        print_success "Docker installed: $DOCKER_VERSION"
        DOCKER_AVAILABLE=true
    else
        print_info "Docker is not installed (optional). Install Docker for containerized deployment."
        DOCKER_AVAILABLE=false
    fi
    
    # Verify project files
    print_header "Verifying Project Files"
    
    if [ -f "pom.xml" ]; then
        print_success "pom.xml found"
    else
        print_error "pom.xml not found. Are you in the correct directory?"
        exit 1
    fi
    
    if [ -f "Dockerfile" ]; then
        print_success "Dockerfile found"
    else
        print_info "Dockerfile not found"
    fi
    
    if [ -f "index.html" ]; then
        print_success "index.html found"
    else
        print_info "index.html not found"
    fi
    
    # Build the project
    print_header "Building the Project"
    print_info "Running: mvn clean package"
    
    if mvn clean package; then
        print_success "Build completed successfully!"
        
        if [ -f "target/maven-web-app.war" ]; then
            print_success "WAR file generated: target/maven-web-app.war"
        fi
    else
        print_error "Build failed. Please check the error messages above."
        exit 1
    fi
    
    # Optional: Build Docker image
    if [ "$DOCKER_AVAILABLE" = true ]; then
        print_header "Docker Image Build (Optional)"
        read -p "Do you want to build the Docker image? (y/n): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Building Docker image..."
            if docker build -t my-project:latest .; then
                print_success "Docker image built successfully: my-project:latest"
                
                read -p "Do you want to run the container? (y/n): " -n 1 -r
                echo
                
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    print_info "Starting Docker container on port 8080..."
                    docker run -d -p 8080:8080 --name my-project-container my-project:latest
                    print_success "Container started! Access at: http://localhost:8080/maven-web-app"
                fi
            else
                print_error "Docker image build failed."
            fi
        fi
    fi
    
    # Summary
    print_header "Setup Complete!"
    print_success "Project is ready to use"
    echo ""
    echo "Next steps:"
    echo "  • The WAR file is located at: target/maven-web-app.war"
    echo "  • Deploy it to any Java application server (e.g., Tomcat)"
    if [ "$DOCKER_AVAILABLE" = true ]; then
        echo "  • Or run with Docker: docker run -p 8080:8080 my-project:latest"
    fi
    echo "  • For development: mvn clean package"
    echo ""
    print_info "For more information, see README.md"
}

# Run main function
main
