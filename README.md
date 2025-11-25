# Proyecto FullStack --- Blazor + .NET API + PostgreSQL (Docker)

Este proyecto contiene una arquitectura full-stack con un **Frontend en
Blazor**, un **ApiService en ASP.NET Core**, y una base de datos
**PostgreSQL corriendo en Docker**.\
Toda la infraestructura está preparada para desarrollo local y
despliegue en entornos productivos.

## 📂 **Estructura del Proyecto**

    /project-root
     ├── src/
     │   ├── Frontend/        # Blazor WebApp
     │   └── ApiService/      # ASP.NET Core API
     │
     ├── docker/
     │   ├── init.sql         # Script inicial para BD (migraciones base)
     │   └── Dockerfile(s)
     │
     ├── docker-compose.yml
     ├── .gitignore
     └── README.md

## 🚀 **Requisitos Previos**

-   .NET 9 SDK\
-   Docker & Docker Compose\
-   Node.js

## 🐳 Ejecutar con Docker

``` bash
docker-compose up --build
```

### Detener

``` bash
docker-compose down
```

### Resetear base de datos

``` bash
docker-compose down -v
```

## 🧩 Migraciones EF Core

``` bash
cd src/ApiService
dotnet ef migrations add NombreMigracion
dotnet ef database update
```

## 🔐 Configuración

Usa variables de entorno o archivos `.env` (ignorados en git).

## ✨ Características

-   Frontend + Backend aislados en `src/`
-   AWS Cognito listo para configuración
-   PostgreSQL con `init.sql`
-   Pipeline listo para CI/CD
-   GitIgnore optimizado

## 🤝 Contribuciones

``` bash
git checkout -b feature/nueva-funcionalidad
git commit -m "Agregado X"
git push origin feature/nueva-funcionalidad
```

## 📄 Licencia

MIT
