# 🔐 Keycloak Docker Development Setup

Modern Keycloak development environment with custom CyberShield theme and PostgreSQL database.

## 📋 Features

- **Keycloak 26.2.5** with development mode
- **PostgreSQL 17** database with persistent storage
- **Custom CyberShield Theme** with glassmorphism design
- **pgAdmin** for database management (optional)
- **MailHog** for email testing (optional)
- **Hot reload** for theme development
- **Health checks** for all services

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Git

### Setup & Start

```bash
# Clone and navigate to project
git clone <your-repo-url>
cd ml-keycloak-docker-dev

# Start core services
docker-compose up -d

# Start with optional tools (pgAdmin, MailHog)
docker-compose --profile tools up -d
```

### Access Applications

| Service | URL | Credentials |
|---------|-----|-------------|
| **Keycloak Admin** | http://localhost:8080 | `admin` / `admin` |
| **pgAdmin** | http://localhost:5050 | `admin@ml.de` / `admin` |
| **MailHog UI** | http://localhost:8025 | - |
| **PostgreSQL** | localhost:5432 | `keycloak` / `keycloak` |

## 🎨 Theme Development

### Custom Theme Location
```
keycloak/themes/future-2025-theme/
├── login/
│   ├── theme.properties
│   ├── login.ftl
│   └── resources/
│       ├── css/login.css
│       └── img/cyber-shield.svg
```

### Activate Custom Theme
1. Login to Keycloak Admin Console
2. **Realm Settings** → **Themes** tab
3. Set **Login Theme** to `future-2025-theme`
4. **Save**

### Development Workflow
- Edit CSS/FTL files directly
- **No container restart needed** (cache disabled in dev mode)
- Refresh browser to see changes

## 🔧 Configuration

### Environment Variables
Create `.env` file to customize:

```bash
# Keycloak Settings
KEYCLOAK_ADMIN_USER=admin
KEYCLOAK_ADMIN_PASSWORD=admin
KEYCLOAK_PORT=8080
KC_LOG_LEVEL=INFO

# Database Settings
POSTGRES_DB=keycloak
POSTGRES_USER=keycloak
POSTGRES_PASSWORD=keycloak
POSTGRES_PORT=5432

# Optional Tools
PGADMIN_EMAIL=admin@ml.de
PGADMIN_PASSWORD=admin
PGADMIN_PORT=5050
MAILHOG_WEB_PORT=8025
MAILHOG_SMTP_PORT=1025
```

### Profiles
- **Default**: Keycloak + PostgreSQL only
- **Tools**: Include pgAdmin + MailHog

```bash
# Start with all tools
docker-compose --profile tools up -d
```

## 📁 Project Structure

```
ml-keycloak-docker-dev/
├── docker-compose.yaml          # Main Docker Compose configuration
├── .env.example                 # Environment variables template
├── .gitignore                   # Git ignore rules
├── README.md                    # This file
├── keycloak/
│   ├── import/                  # Realm import files (gitignored except master-realm.json)
│   │   └── master-realm.json    # Master realm configuration
│   └── themes/
│       └── future-2025-theme/   # Custom CyberShield theme
│           └── login/
│               ├── theme.properties
│               ├── login.ftl
│               └── resources/
└── scripts/
    └── cleanup-docker.sh        # Docker cleanup utility
```

## 🛠️ Development Commands

### Container Management
```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f keycloak
docker-compose logs -f postgres

# Stop services
docker-compose down

# Reset everything (⚠️ Deletes data!)
docker-compose down -v
```

### Theme Development
```bash
# Watch theme files for changes (if needed)
docker-compose logs -f keycloak | grep -i theme

# Restart Keycloak only
docker-compose restart keycloak
```

### Database Operations
```bash
# Connect to PostgreSQL
docker exec -it ml-keycloak-postgres psql -U keycloak -d keycloak

# Backup database
docker exec ml-keycloak-postgres pg_dump -U keycloak keycloak > backup.sql

# Restore database
cat backup.sql | docker exec -i ml-keycloak-postgres psql -U keycloak -d keycloak
```

## 🎯 Production Considerations

### Security
- Change default passwords
- Use production database settings
- Enable HTTPS
- Set proper hostname configuration

### Performance
- Remove development flags
- Enable theme caching
- Use production-grade database
- Configure proper resource limits

### Example Production Changes
```yaml
# Remove from command:
# - --spi-theme-cache-themes=false
# - --spi-theme-cache-templates=false

# Add production settings:
environment:
  KC_HOSTNAME: your-domain.com
  KC_PROXY: edge
  KC_HOSTNAME_STRICT_HTTPS: true
```

## 🔍 Troubleshooting

### Common Issues

**Theme not loading:**
```bash
# Check theme files exist
ls -la keycloak/themes/future-2025-theme/login/

# Check container logs
docker-compose logs keycloak | grep -i theme
```

**Database connection issues:**
```bash
# Check PostgreSQL health
docker-compose ps postgres
docker-compose logs postgres
```

**Port conflicts:**
```bash
# Check if ports are already in use
lsof -i :8080
lsof -i :5432
```

### Reset Everything
```bash
# Nuclear option - start fresh
docker-compose down -v
docker system prune -f
docker-compose up -d
```

## 📚 Resources

- [Keycloak Documentation](https://www.keycloak.org/documentation)
- [Theme Development Guide](https://www.keycloak.org/docs/latest/server_development/#_themes)
- [Docker Compose Reference](https://docs.docker.com/compose/)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**🚀 Happy coding with Keycloak!** 🔐