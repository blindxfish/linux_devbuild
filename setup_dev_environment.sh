#!/bin/bash

# Development Environment Setup Script
# This script installs Java, Go, Node.js, and Docker for development

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Function to update package list
update_packages() {
    print_status "Updating package list..."
    sudo apt update
    print_success "Package list updated"
}

# Function to install Git
install_git() {
    print_status "Installing Git..."
    
    if command_exists git; then
        print_warning "Git is already installed:"
        git --version
        return
    fi
    
    sudo apt install -y git
    
    print_success "Git installed successfully"
    print_status "Git version:"
    git --version
}

# Function to install Java
install_java() {
    print_status "Installing Java Development Kit (JDK)..."
    
    if command_exists java; then
        print_warning "Java is already installed:"
        java -version
        return
    fi
    
    # Install OpenJDK 17 (LTS)
    sudo apt install -y openjdk-17-jdk
    
    # Set JAVA_HOME
    echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
    
    print_success "Java installed successfully"
    print_status "Java version:"
    java -version
}

# Function to install Go
install_go() {
    print_status "Installing Go..."
    
    if command_exists go; then
        print_warning "Go is already installed:"
        go version
        return
    fi
    
    # Download and install Go
    GO_VERSION="1.21.5"
    GO_ARCH="linux-amd64"
    GO_TAR="go${GO_VERSION}.${GO_ARCH}.tar.gz"
    GO_URL="https://go.dev/dl/${GO_TAR}"
    
    cd /tmp
    wget -q "$GO_URL"
    sudo tar -C /usr/local -xzf "$GO_TAR"
    rm "$GO_TAR"
    
    # Add Go to PATH
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    
    # Source bashrc to make go available in current session
    source ~/.bashrc
    
    print_success "Go installed successfully"
    print_status "Go version:"
    go version
}

# Function to install Node.js and npm
install_nodejs() {
    print_status "Installing Node.js and npm..."
    
    if command_exists node && command_exists npm; then
        print_warning "Node.js and npm are already installed:"
        node --version
        npm --version
        return
    fi
    
    # Install Node.js using NodeSource repository
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
    
    print_success "Node.js and npm installed successfully"
    print_status "Node.js version:"
    node --version
    print_status "npm version:"
    npm --version
}

# Function to install Docker
install_docker() {
    print_status "Installing Docker..."
    
    if command_exists docker; then
        print_warning "Docker is already installed:"
        docker --version
        return
    fi
    
    # Install Docker using official installation script
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    
    # Add user to docker group
    sudo usermod -aG docker $USER
    
    print_success "Docker installed successfully"
    print_status "Docker version:"
    docker --version
    print_warning "You need to log out and back in for docker group changes to take effect"
}

# Function to install additional development tools
install_dev_tools() {
    print_status "Installing additional development tools..."
    
    # Install common development packages
    sudo apt install -y \
        curl \
        wget \
        build-essential \
        htop \
        tree \
        unzip \
        zip
    
    # Install vim (try different package names)
    if ! command_exists vim; then
        print_status "Installing vim..."
        if sudo apt install -y vim 2>/dev/null; then
            print_success "vim installed successfully"
        elif sudo apt install -y vim-tiny 2>/dev/null; then
            print_success "vim-tiny installed successfully"
        elif sudo apt install -y vim-nox 2>/dev/null; then
            print_success "vim-nox installed successfully"
        else
            print_warning "Could not install vim. You may need to install it manually."
        fi
    else
        print_warning "vim is already installed:"
        vim --version | head -1
    fi
    
    print_success "Additional development tools installed"
}

# Function to verify installations
verify_installations() {
    print_status "Verifying installations..."
    
    echo ""
    print_status "=== Installation Verification ==="
    
    if command_exists git; then
        print_success "✓ Git is installed"
        git --version
    else
        print_error "✗ Git is not installed"
    fi
    
    echo ""
    if command_exists java; then
        print_success "✓ Java is installed"
        java -version
    else
        print_error "✗ Java is not installed"
    fi
    
    echo ""
    if command_exists go; then
        print_success "✓ Go is installed"
        go version
    else
        print_error "✗ Go is not installed"
    fi
    
    echo ""
    if command_exists node; then
        print_success "✓ Node.js is installed"
        node --version
    else
        print_error "✗ Node.js is not installed"
    fi
    
    echo ""
    if command_exists npm; then
        print_success "✓ npm is installed"
        npm --version
    else
        print_error "✗ npm is not installed"
    fi
    
    echo ""
    if command_exists docker; then
        print_success "✓ Docker is installed"
        docker --version
    else
        print_error "✗ Docker is not installed"
    fi
    
    echo ""
    print_status "=== Additional Development Tools ==="
    
    # Check additional tools
    local tools=("curl" "wget" "vim" "htop" "tree" "unzip" "zip")
    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then
            print_success "✓ $tool is installed"
        else
            print_warning "⚠ $tool is not installed"
        fi
    done
    
    echo ""
    print_status "=== Setup Complete ==="
    print_warning "Note: You may need to log out and back in for all changes to take effect"
    print_warning "Note: For Docker, you need to log out and back in for group permissions"
}

# Main execution
main() {
    echo "=========================================="
    echo "  Development Environment Setup Script"
    echo "=========================================="
    echo ""
    
    # Check if not running as root
    check_root
    
    # Update packages first
    update_packages
    
    # Install Git first (needed for other tools)
    install_git
    
    # Install all tools
    install_java
    install_go
    install_nodejs
    install_docker
    install_dev_tools
    
    # Verify installations
    verify_installations
    
    echo ""
    print_success "Setup completed successfully!"
    print_status "You can now start developing with Java, Go, Node.js, and Docker"
}

# Run main function
main "$@" 