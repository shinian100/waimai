//引入express模块
const express=require("express");
//引入中间件
const bodyParser=require("body-parser");
//引入路由器
// const indexRouter=require("./routes/index.js");
//创建服务器
var server=express();
//服务器监听
server.listen(3000);
//接收请求
//静态资源
server.use(express.static("public"));
//使用中间件
server.use(bodyParser.urlencoded({extended:false}));
//挂载路由
//server.use("/index",indexRouter);