FROM maven:3-openjdk-17 AS build
WORKDIR /app

COPY . .
RUN mvn clean package -DskipTests

# Run stage

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

COPY --from=build /app/target/food.war food.war

EXPOSE 8080

ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "food.war"]
