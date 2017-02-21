package org.api.demo;

import javax.json.Json;
import javax.json.JsonObject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("hello")
public class HelloResource {

    @GET
    @Produces("application/json")
    // URL: http://localhost:8080/macroservice/resources/hello
    public JsonObject hello() {
        return Json.createObjectBuilder().
                add("hello", "world").
                build();
    }
}
