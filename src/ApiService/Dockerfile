# =======================
#   1. BUILD DEL API
# =======================
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar solución completa
COPY . .

# Restaurar dependencias
RUN dotnet restore

# Publicar en modo Release
RUN dotnet publish -c Release -o /app/publish

# =======================
#   2. RUNTIME
# =======================
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Copiar artefactos publicados
COPY --from=build /app/publish .

# Aplicación escucha en el puerto 8080 internamente
ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

ENTRYPOINT ["dotnet", "ApiService.dll"]