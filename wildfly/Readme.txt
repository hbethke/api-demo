docker build -t adesso/api-demo-wildfly .
docker run --name api-demo-wildfly -it -p 8080:8080 -p 9990:9990 adesso/api-demo-wildfly
docker exec -it api-demo-wildfly bash
docker rm api-demo-wildfly
docker rmi adesso/api-demo-wildfly

# How to set log level?
Login on container and run
jboss-cli.sh
>connect
/subsystem=logging/root-logger=ROOT:write-attribute(name="level", value="DEBUG")
