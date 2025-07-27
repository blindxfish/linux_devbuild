# Development Environment Setup Script

A comprehensive bash script that automatically installs and configures a complete development environment on Ubuntu/Debian-based Linux systems.

## 🚀 What This Script Does

This script automates the installation of essential development tools and programming languages, saving you hours of manual setup time. It installs and configures:

### Core Development Tools
- **Git** - Version control system
- **Java** - OpenJDK 17 (LTS) with proper JAVA_HOME configuration
- **Go** - Go programming language (version 1.21.5)
- **Node.js** - JavaScript runtime (version 20.x LTS)
- **npm** - Node.js package manager
- **Docker** - Containerization platform

### Additional Development Tools
- **curl** - Command line tool for transferring data
- **wget** - Command line tool for downloading files
- **build-essential** - Compilation tools and libraries
- **vim** - Text editor
- **htop** - Interactive process viewer
- **tree** - Directory listing utility
- **unzip/zip** - Archive utilities

## ✨ Features

- **🔄 Smart Installation**: Checks if tools are already installed before attempting installation
- **🎨 Colored Output**: Clear, color-coded status messages for better readability
- **🛡️ Error Handling**: Comprehensive error checking and graceful failure handling
- **✅ Verification**: Automatic verification of all installations
- **🔧 Auto-Configuration**: Sets up environment variables and PATH configurations
- **📋 Progress Tracking**: Shows detailed progress for each installation step

## 📋 Requirements

- **Operating System**: Ubuntu 18.04+ or Debian-based Linux distribution
- **User Permissions**: Non-root user with sudo privileges
- **Internet Connection**: Required for downloading packages and tools
- **Disk Space**: Approximately 2-3 GB of free space

## 🚀 Quick Start

1. **Clone or download the script**:
   ```bash
   # If you have git already installed
   git clone <repository-url>
   cd linux_setup
   
   # Or download the script directly
   wget https://raw.githubusercontent.com/your-repo/linux_setup/main/setup_dev_environment.sh
   ```

2. **Make the script executable**:
   ```bash
   chmod +x setup_dev_environment.sh
   ```

3. **Run the script**:
   ```bash
   ./setup_dev_environment.sh
   ```

4. **Follow the prompts** and wait for the installation to complete.

## 📖 Detailed Usage

### Running the Script

```bash
./setup_dev_environment.sh
```

The script will:
1. Check that you're not running as root
2. Update your package list
3. Install Git first (needed for other tools)
4. Install Java, Go, Node.js, and Docker
5. Install additional development tools
6. Verify all installations
7. Display a summary of what was installed

### What Happens After Installation

After the script completes:

1. **Environment Variables**: The script adds necessary environment variables to your `~/.bashrc` file
2. **Docker Permissions**: You'll be added to the docker group
3. **Session Requirements**: You may need to log out and back in for all changes to take effect

### Verification

The script automatically verifies all installations and displays:
- ✓ Success indicators for each tool
- Version information for installed tools
- Any warnings or notes about post-installation steps

## 🔧 Manual Verification

You can manually verify the installations:

```bash
# Check Git
git --version

# Check Java
java -version
echo $JAVA_HOME

# Check Go
go version
echo $GOPATH

# Check Node.js and npm
node --version
npm --version

# Check Docker
docker --version
docker run hello-world
```

## 🛠️ Customization

### Modifying Versions

You can edit the script to change versions:

- **Go**: Modify `GO_VERSION="1.21.5"` in the `install_go()` function
- **Node.js**: Change the NodeSource setup URL in `install_nodejs()` function
- **Java**: Modify the package name in `install_java()` function

### Adding More Tools

To add additional tools, you can:
1. Add installation logic to the `install_dev_tools()` function
2. Create a new function and call it in the `main()` function
3. Add verification in the `verify_installations()` function

## 🚨 Troubleshooting

### Common Issues

1. **Permission Denied**:
   ```bash
   chmod +x setup_dev_environment.sh
   ```

2. **Docker Permission Issues**:
   ```bash
   # Log out and back in, or run:
   newgrp docker
   ```

3. **Java Not Found**:
   ```bash
   # Source your bashrc
   source ~/.bashrc
   ```

4. **Go Not Found**:
   ```bash
   # Source your bashrc
   source ~/.bashrc
   ```

### Script Fails

If the script fails:
1. Check your internet connection
2. Ensure you have sudo privileges
3. Check available disk space
4. Review the error messages for specific issues

## 📝 Logs and Output

The script provides detailed output with:
- **Blue [INFO]**: General information and progress
- **Green [SUCCESS]**: Successful operations
- **Yellow [WARNING]**: Warnings and notes
- **Red [ERROR]**: Error messages

## 🔒 Security Notes

- The script downloads and executes installation scripts from official sources
- Docker installation uses the official Docker installation script
- Node.js installation uses the official NodeSource repository
- All downloads are from verified, official sources

## 🤝 Contributing

Feel free to contribute improvements:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This script is provided as-is for educational and development purposes.

## 🙏 Acknowledgments

- Official installation scripts from Docker, Node.js, and Go teams
- Ubuntu/Debian package maintainers
- Open source community

---

**Happy Coding! 🎉** 