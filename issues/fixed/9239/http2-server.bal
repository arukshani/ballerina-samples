// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.package http2;

import ballerina/http;
import ballerina/log;
import ballerina/io;

endpoint http:Listener helloWorldEP {
    port: 9095,
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/hello"
}
service helloWorld bind helloWorldEP {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/get"
    }
    sayHelloGet(endpoint caller, http:Request req) {
        http:Response res = new;
        res.setPayload("*** Hello GET Response !");
        caller->respond(res) but {
            error e => log:printError("Failed to respond", err = e)
        };
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/post"
    }
    sayHelloPost(endpoint caller, http:Request req) {
        string payload = check req.getTextPayload();
        http:Response res = new;
        res.setPayload("*** Hello POST Response !");
        caller->respond(res) but {
            error e => log:printError("Failed to respond", err = e)
        };
    }
}