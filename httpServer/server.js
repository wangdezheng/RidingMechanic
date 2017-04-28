var http= require("http");
var settings=require("settings");
var table=require("table");
var httpMsg=require("httpMsg")

http.createServer(function(req, resp){
    switch(req.method){
        case "GET":
            if(req.url==="/"){
                httpMsg.showHome(req,resp);
             }else if(req.url==="/userInfo"){
                table.getUserList(req,resp);
            }else{
                console.log(req.url);
                var pattern=new RegExp("/userSettings/");
                if(pattern.test(req.url)){
                    var exp=pattern.exec(req.url);
                    var username=req.url.replace(exp,"");
                    table.getUserSettings(req,resp,username)
                }else{
                    httpMsg.show404(req,resp);
                }                
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
}).listen(9000,function(){
   var host = '138.49.101.87';
   var port = '9000';
    console.log("Start listening at:http://%s:%s", host,port);
});