# EM
mvn clean compile -Djetty.port=8080 jetty:run

-XX:MaxPermSize=512M


mvn clean compile package -Dmaven.test.skip=true -P deploy-k-local