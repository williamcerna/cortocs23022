#usando la imagen openjdk PARA COMPILAR LA APLICACION 
FROM openjdk:17 AS build
WORKDIR /app

COPY . .
RUN ./mvnw clean package -DskipTests 

#USANDO IMAGEN PARA EJECUTAR LA APLICACION
 FROM openjdk:17
 WORKDIR /app
 COPY --from=build/app/target/*.jar app.jar
 EXPOSE 8080
 CMD [ "java", "-jar". "app.jar" ]


