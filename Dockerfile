# Build Stage
FROM ubuntu:latest AS build

# O'rnatish uchun JDK 17
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

# Loyihani nusxalash
COPY . .

FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y openjdk-17-jdk curl

# Install Gradle if not using wrapper
RUN curl -s https://get.sdkman.io | bash
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install gradle"

# Copy project files
COPY . /app
WORKDIR /app

# Run Gradle build
RUN ./gradlew build --no-daemon

# Final image
FROM openjdk:17-jdk-slim
COPY --from=build /app/build/libs /app/libs
CMD ["java", "-jar", "/app/libs/your-app.jar"]
