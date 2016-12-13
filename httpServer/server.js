var http= require("http");
var settings=require("settings");
var table=require("table");
var httpMsg=require("httpMsg")

http.createServer(function(req, resp){
    switch(req.method){
        case "GET":
            if(req.url==="/"){
                httpMsg.showHome(req,resp);
            }else if(req.url==="/carmodels"){
                table.getCarList(req,resp);
             }else if(req.url==="/userInfo"){
                table.getUserList(req,resp);
            }else{
                httpMsg.showHome(req,resp);
            }
            break;
        case "POST":
            if(req.url==="/userInfo"){
                var reqBody='';
                req.on("data",function(data){
                    reqBody+=data;
                    if(reqBody.length>1e7)//10mb
                    {
                        httpMsg.show413(req,resp);
                    }
                });
                req.on("end",function(){
                    table.addUser(req,resp,reqBody);
                });

            }else{
                httpMsg.show404(req,resp);
            }
            break;
        case "PUT":
            if(req.url==="/userInfo"){
                var reqBody='';
                req.on("data",function(data){
                    reqBody+=data;
                    if(reqBody.length>1e7)//10mb
                    {
                        httpMsg.show413(req,resp);
                    }
                });
                req.on("end",function(){
                    table.updateUser(req,resp,reqBody);
                });

            }else{
                httpMsg.show404(req,resp);
            }
            break;
        case "DELETE":
            break;  
        default :
            httpMsg.show405(req,resp);
            break;                                
    }
}).listen(settings.webPort,function(){
    console.log("Start listening at:"+ settings.webPort);
});