FROM openjdk:11
WORKDIR /app
RUN apt-get update && apt-get -y install maven && apt-get clean
COPY . .
RUN mvn package
EXPOSE 1234
CMD [ "mvn", "exec:java", "-Dexec.mainClass=fr.ludovicm67.App" ]
