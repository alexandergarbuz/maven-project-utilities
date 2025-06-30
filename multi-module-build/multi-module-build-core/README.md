# Multi-Module Build - Core

This is the core business logic module of the multi-module Maven project. It contains shared services, utilities, and domain models that can be used by other modules in the project.

## 🎯 Purpose

The core module serves as the foundation for the multi-module application, providing:
- Business logic and services
- Domain models and entities
- Utility classes and helpers
- Configuration classes
- Data access layer interfaces

## 🏗️ Module Structure

```
src/main/java/com/garbuz/core/
├── model/                      # Domain models and entities
│   ├── User.java
│   └── BaseEntity.java
├── service/                    # Business logic services
│   ├── UserService.java
│   └── impl/
│       └── UserServiceImpl.java
├── repository/                 # Data access interfaces
│   └── UserRepository.java
├── util/                      # Utility classes
│   ├── DateUtils.java
│   └── ValidationUtils.java
├── config/                    # Configuration classes
│   └── CoreConfig.java
└── exception/                 # Custom exceptions
    ├── BusinessException.java
    └── ValidationException.java

src/main/resources/
├── application-core.properties # Core module configuration
└── META-INF/
    └── spring.factories        # Auto-configuration (if needed)

src/test/java/com/garbuz/core/
├── service/                   # Service unit tests
└── util/                     # Utility tests
```

## 📦 Dependencies

This module typically includes:
- **Spring Core** - Dependency injection and IoC
- **Spring Context** - Application context and configuration
- **Spring Data** - Data access abstraction (if using databases)
- **Validation API** - Bean validation
- **Logging** - SLF4J with Logback or Log4j2
- **Testing** - JUnit 5, Mockito, Spring Test

### Example Dependencies (add to POM)
```xml
<dependencies>
    <!-- Spring Framework -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
    </dependency>
    
    <!-- Validation -->
    <dependency>
        <groupId>javax.validation</groupId>
        <artifactId>validation-api</artifactId>
    </dependency>
    
    <!-- Logging -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-api</artifactId>
    </dependency>
    
    <!-- Testing -->
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <scope>test</scope>
    </dependency>
    
    <dependency>
        <groupId>org.mockito</groupId>
        <artifactId>mockito-core</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

## 🔧 Building the Module

```bash
# Navigate to core module directory
cd multi-module-build-core

# Compile the module
mvn compile

# Run tests
mvn test

# Install to local repository (for other modules to use)
mvn install

# Build from parent directory (builds all modules)
cd ..
mvn clean install
```

## 🧪 Testing

```bash
# Run unit tests only
mvn test

# Run tests with coverage report
mvn test jacoco:report

# Run integration tests (if configured)
mvn verify

# Generate site with all reports
mvn site
```

## 📋 Usage in Other Modules

Other modules can use this core module by adding it as a dependency:

```xml
<dependency>
    <groupId>com.garbuz</groupId>
    <artifactId>multi-module-build-core</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

### Example Usage in Web Module
```java
package com.garbuz.web.controller;

import com.garbuz.core.service.UserService;
import com.garbuz.core.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/users")
    public String getUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "users";
    }
}
```

## 🎨 Design Patterns

This core module typically implements common design patterns:

### Service Layer Pattern
- **Services** - Business logic encapsulation
- **Service Interfaces** - Contract definition
- **Service Implementation** - Concrete business logic

### Repository Pattern
- **Repository Interfaces** - Data access contracts
- **Implementation** - In other modules (web, data, etc.)

### Dependency Injection
- **@Service** - Service layer components
- **@Component** - Utility and helper classes
- **@Configuration** - Configuration classes

## 🔄 Development Guidelines

### Adding New Services
1. Create interface in `service/` package
2. Create implementation in `service/impl/` package
3. Add `@Service` annotation to implementation
4. Write unit tests in `src/test/java/`

### Adding Domain Models
1. Create model class in `model/` package
2. Add validation annotations if needed
3. Implement `equals()`, `hashCode()`, `toString()`
4. Consider extending `BaseEntity` if common fields needed

### Adding Utilities
1. Create utility class in `util/` package
2. Make methods static
3. Add comprehensive unit tests
4. Document usage with JavaDoc

## 📚 Best Practices

### Code Organization
- Keep packages focused and cohesive
- Use clear naming conventions
- Separate interfaces from implementations
- Group related functionality together

### Testing
- Write unit tests for all services
- Mock external