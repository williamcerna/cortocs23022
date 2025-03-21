# Etapa de compilación
FROM openjdk:17 AS build
WORKDIR /app
COPY . . 
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# Etapa de ejecución
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar  
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]
