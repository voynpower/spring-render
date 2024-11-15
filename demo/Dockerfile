# Build Stage
FROM ubuntu:latest AS build

# O'rnatish uchun JDK 17
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

# Loyihani nusxalash
COPY . .

# Gradle Wrapper orqali ilovani yaratish
RUN ./gradlew bootJar --no-daemon

# Production Stage
FROM openjdk:17-jdk-slim

# 8080 portini ochish
EXPOSE 8080

# Build Stage'dan yaratilgan JAR faylini nusxalash
COPY --from=build /spring-render/build/libs/spring-render-0.0.1-SNAPSHOT.jar app.jar

# Ilovani ishga tushirish
ENTRYPOINT ["java", "-jar", "/app.jar"]
