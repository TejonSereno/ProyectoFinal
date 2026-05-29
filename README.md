# ProyectoFinal
Aplicación de gestión de comunidades de vecinos desarrollada con arquitectura full stack mediante Spring Boot y Flutter.

# Tecnologías

## Backend
- Java 17
- Spring Boot 3
- Spring Security
- JWT
- Maven
- PostgreSQL

## Frontend
- Flutter
- Dart

## DevOps
- Docker
- GitHub


# Arquitectura

## Back
Controller → Service → Repository → Database

## Front
Controller → Service → Repository → Database

## Produccion
Futter App → Spring Boot API (Render) → PostgreSQL(Supabase)
# Documentacion
- Swagger
  https://proyectofinal-ujbs.onrender.com/swagger-ui.html
- OpenAPI
  https://proyectofinal-ujbs.onrender.com/v3/api-docs

# Autentication
1. El usuario inicia sesión.
2. El servidor genera un token JWT.
3. El cliente envía el token en cada petición.
4. Spring Security valida el token.

## Header de autorizacion
Authorization: Bearer <token>

# Despiege
- Backend desplegado en Render.
- Base de datos PostgreSQL alojada en Supabase.
- Frontend móvil desarrollado en Flutter.


## Backend en render
El backend Spring Boot se encuentra desplegado mediante Render utilizando Docker.

Características:
- Build automático desde GitHub.
- Despliegue continuo.
- Variables de entorno configuradas desde Render.
    SPRING_DATASOURCE_URL=<SUPABASE_DB_URL>
    SPRING_DATASOURCE_USERNAME=<SUPABASE_USER>
    SPRING_DATASOURCE_PASSWORD=<SUPABASE_PASSWORD>

### Limitaciones 
El backend utiliza el plan gratuito de Render.

Esto implica que:

- La instancia puede suspenderse por inactividad.
- El primer request tras varios minutos sin uso puede experimentar un retraso de hasta 2 min.
- Una vez activa, la API responde con normalidad.
  
## Repositorio
https://github.com/TejonSereno/ProyectoFinal
