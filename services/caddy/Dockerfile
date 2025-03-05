# syntax=docker/dockerfile:1
# escape=\

# Service version to use.
ARG CADDY_VERSION=2.9.1

# Use the official Caddy image as the base image.
# https://hub.docker.com/_/caddy
FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

# Set the Caddy version as an environment variable.
ENV CADDY_VERSION=${CADDY_VERSION}

# Install dependencies.
RUN apk --no-cache add gettext nss wget curl

RUN xcaddy build \
    --with github.com/caddyserver/replace-response

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Install additional dependencies.
RUN apk add --no-cache wget gettext nss nss-tools bash openjdk11-jre ca-certificates jq curl

# Set the JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# Copy Caddyfile.
COPY ./Caddyfile /etc/caddy/Caddyfile

# Create Caddy's fileserver directory root.
RUN mkdir -p /opt/caddy/fileserver && echo "Hello World!" > /opt/caddy/fileserver/hello.txt

# Runs Caddy and blocks indefinitely; i.e. "daemon" mode.
# https://caddyserver.com/docs/command-line#caddy-run
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
