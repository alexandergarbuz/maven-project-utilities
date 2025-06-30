# Multi-Module Build - Web UI

This is the web user interface module of the multi-module Maven project. It's built with Spring Boot and provides a simple web interface with Thymeleaf templates.

## 🚀 Quick Start

### Prerequisites

- Java 11 or higher
- Maven 3.6+
- Tomcat 9+ (for WAR deployment)

### Running the Application

#### Option 1: Spring Boot Development Server
```bash
# Navigate to the web module directory
cd multi-module-build-web

# Run with Maven
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

#### Option 2: WAR Deployment
```bash
# Build the WAR file
mvn clean package

# Deploy the generated WAR file to your Tomcat server
# File location: target/multi-module-build-web.war
```

#### Option 3: Executable JAR
```bash
# Build the project
mvn clean package

# Run the JAR (if configured for embedded server)
java -jar target/multi-module-build-web.war
```

## 📋 What to Expect

### Available Endpoints

| URL | Description | Method |
|-----|-------------|--------|
| `/` | Home page with welcome message | GET |
| `/hello` | Greeting page with default message | GET |
| `/hello?name=YourName` | Personalized greeting page | GET |

### Page Features

**Home Page (`/`)**
- Welcome message in Russian
- Navigation links to other pages
- Clean, responsive design

**Hello Page (`/hello`)**
- Personalized greeting
- Accepts `name` parameter via query string
- Back navigation to home page

### Example URLs
- `http://localhost:8080/` - Home page
- `http://localhost:8080/hello` - Default greeting
- `http://localhost:8080/hello?name=John` - Personalized greeting for "John"

## 🏗️ Project Structure

```
src/main/java/com/garbuz/web/
├── WebApplication.java          # Main Spring Boot application class
└── controller/
    └── HomeController.java      # Web controller with endpoints

src/main/resources/
├── templates/
│   ├── index.html              # Home page template
│   └── hello.html              # Greeting page template
└── static/                     # Static resources (CSS, JS, images)
```

## 🔧 Configuration

### Application Properties
Create `src/main/resources/application.properties` for custom configuration:

```properties
# Server port (default: 8080)
server.port=8080

# Context path (default: /)
server.servlet.context-path=/

# Thymeleaf settings
spring.thymeleaf.cache=false
spring.thymeleaf.mode=HTML
```

### Profile-Specific Configuration
- `application-dev.properties` - Development environment
- `application.properties` - Production environment

Run with specific profile:
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

## 🧪 Testing

```bash
# Run unit tests
mvn test

# Run integration tests
mvn verify

# Generate test reports
mvn site
```

## 📦 Dependencies

This module depends on:
- `multi-module-build-core` - Core business logic
- Spring Boot Starter Web - Web framework
- Spring Boot Starter Thymeleaf - Template engine
- Spring Boot Starter Tomcat (provided) - Embedded server

## 🚨 Troubleshooting

### Common Issues

**Port 8080 already in use**
```bash
# Change port in application.properties
server.port=8081
```

**Templates not found**
- Ensure templates are in `src/main/resources/templates/`
- Check template names match controller return values

**Core module not found**
```bash
# Build the parent project first
cd ..
mvn clean install
cd multi-module-build-web
mvn spring-boot:run
```

### Logs
Application logs are printed to console. For file logging, add to `application.properties`:
```properties
logging.file.name=logs/application.log
logging.level.com.garbuz.web=DEBUG
```

## 🔄 Development Workflow

1. **Make changes** to Java classes or templates
2. **Hot reload** is enabled for templates (with `spring.thymeleaf.cache=false`)
3. **Restart** application for Java code changes
4. **Test** endpoints in browser or with curl

```bash
# Test endpoints with curl
curl http://localhost:8080/
curl "http://localhost:8080/hello?name=Developer"
```

## 📚 Next Steps

- Add more controllers and pages
- Implement REST API endpoints
- Add database integration
- Configure security with Spring Security
- Add front-end framework (React, Vue.js)
- Set up Docker containerization

## 📄 License

This project is part of the multi-module Maven demo and follows the same licensing terms.