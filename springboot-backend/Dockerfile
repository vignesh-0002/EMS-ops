# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17

# Set the working directory in the container
WORKDIR /springboot-backend/

# Copy the compiled JAR file from the build stage
COPY target/springboot-backend-0.0.1-SNAPSHOT.jar springboot-backend.jar

# Expose the port on which the Spring Boot application will run
EXPOSE 8080

# Command to run
ENTRYPOINT ["java", "-jar", "springboot-backend.jar"]
