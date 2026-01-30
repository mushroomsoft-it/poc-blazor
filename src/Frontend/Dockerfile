# =======================
#   1. BUILD BLAZOR WASM
# =======================
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /build

# =======================
#   2. SERVIR CON NGINX
# =======================
FROM nginx:stable-alpine

# Copiar config de nginx
COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Copiar certificados (deshabilitado)
#COPY certs/blazor.crt /etc/nginx/certs/blazor.crt
#COPY certs/blazor.key /etc/nginx/certs/blazor.key

# Copiar el sitio Blazor
COPY --from=build /build/wwwroot /usr/share/nginx/html

# Solo HTTP
EXPOSE 80
#EXPOSE 443   