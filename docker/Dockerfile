FROM eclipse-temurin:17-jre-jammy

# Installation de dépendances système
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Création de l'utilisateur non-root
RUN groupadd -r monitor && useradd -r -g monitor monitor

# Répertoire de l'application
WORKDIR /app

# Copie du JAR depuis la racine du projet
COPY ../target/machine-monitor-1.0.0.jar app.jar

# Répertoires de logs et données
RUN mkdir -p /app/logs /app/reports /app/config \
    && chown -R monitor:monitor /app

USER monitor

# Exposition des ports
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/monitoring/health || exit 1

# Point d'entrée avec optimisation JVM
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dspring.profiles.active=prod", \
    "-XX:+UseG1GC", \
    "-XX:MaxRAMPercentage=75.0", \
    "-XX:+HeapDumpOnOutOfMemoryError", \
    "-XX:HeapDumpPath=/app/logs/heapdump.hprof", \
    "-jar", "app.jar"]