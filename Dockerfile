FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

COPY . .

RUN apk update && apk add --no-cache maven

RUN mvn package -DskipTests

FROM eclipse-temurin:17-jre-alpine AS runtime

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
