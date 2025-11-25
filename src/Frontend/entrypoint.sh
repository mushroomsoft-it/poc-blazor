#!/bin/sh
set -e

echo "🔧 Generando configuración dinámica..."

envsubst < /usr/share/nginx/html/config/appsettings.json.template \
    > /usr/share/nginx/html/config/appsettings.json

echo "📄 Resultado final del appsettings:"
cat /usr/share/nginx/html/config/appsettings.json

nginx -g "daemon off;"
