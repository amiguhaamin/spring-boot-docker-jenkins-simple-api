FROM maven:3.8.5-openjdk-17 as builder
WORKDIR /app
COPY pom.xml .
# COPY . /app
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests=true

# Build stage
FROM openjdk:17-jdk-slim AS prod
RUN mkdir /app
COPY --from=builder /app/target/*.jar /app/app.jar
WORKDIR app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
