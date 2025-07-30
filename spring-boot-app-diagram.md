# Spring Boot Project Structure

```
📁 app-name/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/
│   │   │   └── 📁 com/
│   │   │       └── 📁 package/
│   │   │           └── 📁 app-name/
│   │   │               ├── 📄 YourApplication.java        # 🎯 Application entry point
│   │   │               ├── 📁 controller/                 # 🚦 REST API controllers
│   │   │               ├── 📁 service/                    # 🧠 Business logic
│   │   │               ├── 📁 repository/                 # 💾 JPA repository layer
│   │   │               ├── 📁 model/                      # 📦 Entity classes
│   │   │               ├── 📁 config/                     # ⚙️ Configuration (Security, CORS, etc.)
│   │   │               ├── 📁 dto/                        # 📨 Data Transfer Objects
│   │   │               ├── 📁 exception/                  # 🔥 Custom exception handling
│   │   │               └── 📁 util/                       # 🛠️ Utilities and helpers
│   │   │
│   │   └── 📁 resources/
│   │       ├── 📁 static/                                 # 🎨 CSS, JS, images
│   │       ├── 📁 templates/                              # 📄 HTML / Thymeleaf templates
│   │       ├── 📄 application.properties                  # 📝 App settings
│   │       └── 📄 messages.properties                     # 🌍 Localization
│   │
│   └── 📁 test/
│       └── 📁 java/
│           └── 📁 com/
│               └── 📁 package/
│                   └── 📁 app-name/
│                       ├── 📄 YourApplicationTests.java   # 🧪 Main tests
│                       ├── 📁 controller/                 # ✔️ Controller tests
│                       └── 📁 service/                    # ✅ Service layer tests
│
├── 📄 .gitignore                                          # 🚫 Ignored files and folders
├── 📄 pom.xml                                             # ⚙️ Maven config and dependencies
├── 📄 README.md                                           # 📘 Project overview and setup guide
├── 📄 CHANGELOG.md                                        # 📅 Change history
└── 📄 HELP.md                                             # 🆘 Help and support instructions
```