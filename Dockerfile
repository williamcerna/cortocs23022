# Usar una imagen base de OpenJDK
FROM openjdk:17-jdk AS build

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar archivos de Maven y el proyecto
COPY .mvn .mvn
COPY mvnw pom.xml ./
COPY src src

# Dar permisos de ejecución 
RUN chmod +x mvnw

# Construir la aplicación
RUN ./mvnw clean package -DskipTests

# Ejecutar la aplicación
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copiar el JAR 
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto de la aplicación
EXPOSE 8080

# Ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
