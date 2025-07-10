# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17 AS build

# mysql-client
#RUN apt-get update && apt-get install -y mysql-client

# Set the working directory
WORKDIR /app

# mysql-client
#RUN apt-get update && apt-get install -y mysql-client

# Copy source code and build the application
COPY . .


# Install MySQL client
#RUN apt-get update && apk add --no-cache mysql-client
#RUN apt-get update && apt-get install -y mysql-client


# Optional: skip tests during build
RUN mvn clean package -DskipTests

# -----------------------------
# Create a new clean image just for running
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the compiled JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Optional: Set environment variables (these can be overridden at runtime)
ENV SPRING_DATASOURCE_URL=""
ENV SPRING_DATASOURCE_USERNAME=""
ENV SPRING_DATASOURCE_PASSWORD=""
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=""

# Expose port
EXPOSE 8080

# Run the jar with env variables
ENTRYPOINT ["java", "-jar", "app.jar"]
