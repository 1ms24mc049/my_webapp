# ------------ Build Stage (uses Maven to compile) ------------
FROM maven:3.9.4-openjdk-21 AS build
WORKDIR /app

# copy pom and source code
COPY pom.xml .
COPY src ./src

# build the project
RUN mvn -B -DskipTests clean package


# ------------ Runtime Stage (lighter image) ------------
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# copy compiled classes from build container
COPY --from=build /app/target/classes ./classes

# expose the port your server runs on (change if needed)
EXPOSE 8080

# run your Java class (change Website to your main class name)
CMD ["java", "-cp", "classes", "Website"]
