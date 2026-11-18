# Ubuntu version is passed in by Jenkins to match the machine that compiled the C code
ARG UBUNTU_VERSION=24.04
FROM docker.io/library/ubuntu:${UBUNTU_VERSION}

ARG JAR_FILE=target/helloworld-0.0.1-SNAPSHOT.jar
ARG C_ARCHIVE=src/c_code/target/utilities.tar.gz
ARG APP_USER=appuser
ARG DEBIAN_FRONTEND=noninteractive

# Java 17 runtime
RUN apt-get update \
 && apt-get install -y --no-install-recommends openjdk-17-jre-headless ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Non-root user; its home is $HOME
RUN useradd --create-home --shell /bin/bash ${APP_USER}
ENV HOME=/home/${APP_USER}
ENV PATH="${HOME}/bin:${PATH}"

# Spring Boot reads SERVER_PORT, so no application.properties change is needed
ENV SERVER_PORT=8001

WORKDIR /app

# Java app (built by Jenkins)
COPY ${JAR_FILE} /app/app.jar

# C utilities (built by Jenkins) -> $HOME/bin
# If the archive has a single top-level folder, its contents are moved up into $HOME/bin
COPY ${C_ARCHIVE} /tmp/utilities.tar.gz
RUN mkdir -p "$HOME/bin" \
 && tar -xzf /tmp/utilities.tar.gz --no-same-owner -C "$HOME/bin" \
 && cd "$HOME/bin" \
 && if [ "$(ls -A | wc -l)" -eq 1 ] && [ -d "$(ls -A)" ]; then \
        top="$(ls -A)"; mv "$top"/* . ; rmdir "$top" 2>/dev/null || true; \
    fi \
 && rm -f /tmp/utilities.tar.gz \
 && chown -R ${APP_USER}:${APP_USER} "$HOME" /app

USER ${APP_USER}

EXPOSE 8001
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
