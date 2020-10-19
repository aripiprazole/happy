FROM gradle:jdk11-openj9 AS build
COPY --chown=gradle:gradle . /app
WORKDIR /app
RUN gradle shadowJar --no-daemon

FROM openjdk:11-jre-slim
WORKDIR /app
COPY . /app
COPY --from=build /app/build/libs/*.jar /app/app.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
