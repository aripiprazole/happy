# Happy! backend app

Hello, welcome to the Happy! backend app.

---

## Observations

- The main framework used was [ktor](https://ktor.io/) and
  [exposed](https://github.com/JetBrains/Exposed)
- The contact button hasn't been implemented
- You can configure the application in [config](resources/application.conf)

## Build instructions

1. You just need to setup a PostgreSQL connection in
   config(The project already has a docker-compose file with simple
   PostgreSQL server, you just need to have docker and docker-compose and type:
   `docker-compose up -d`)
2. Then need to run: `./gradlew shadowJar`

## Run instructions

If you just want to run the project, just run: `./gradlew run` and the app will be
serving in port 3000
