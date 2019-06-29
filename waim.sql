#设置客户端连接服务器端的编码
SET NAMES UTF8;
#丢弃数据库waim，如果存在的话
DROP DATABSE IF EXISTS waim;
#创建数据库waim,设置存储的编码
CREATE DATABASE waim CHARSET=UTF8;
#进入数据库
USE waim;
#创建数据表
#用户列表
CREATE TABLE waim_user(
   uid     INT PRIMAY KEY AUTO_INCREMENT,
   uname   VARCHAR(32),
   upwd    VARCHAR(32),
   email   VARCHAR(64),
   phone   VARCHAR(16) NOT NULL UNIQUE,
   avatar  VARCHAR(128),
   user_name   VARCHAR(32),
   gender      INT
);
INSERT INTO waim_user VALUES
(NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '丁伟', '1'),
(NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '林当', '1'),
(NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '窦志强', '1'),
(NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '秦小雅', '0');
#用户地址表
CREATE TABLE waim_receiver_address( 
  aid     INT PRIMAY KEY AUTO_INCREMENT,
  user_id   INT,
  FOREIGN KEY (user_id) REFERENCES waim_user (uid),
  receiver   VARCHAR(16),
  province   VARCHAR(16),
  city       VARCHAR(16),
  county     VARCHAR(16),
  address    VARCHAR(128),
  cellphone   VARCHAR(16),
  fixedphone    VARCHAR(16),
  postcode      CHAR(6),
  tag            VARCHAR(16),
  is_default     BOOLEAN
);   

#商品种类表，记载所有的商品种类
CREATE TABLE  waim_laptop_family(
  fid   INT PRIMARY KEY AUTO_INCREMENT,
  name   VARCHAR(32)#类别名称
);
#商品表，记载所有商品的信息关联到种类表
CREATE TABLE waim_laptop(
  lid  INT PRIMARY KEY AUTO_INCREMENT,
  family_id  INT,#所属分类家族编号
  FOREIGN KEY (family_id) REFERENCES waim_laptop_family (fid),
  product_id  INT,#产品编号
  price         DECIMAL(10,2),#价格
  name          VARCHAR(32),#商品名称
  is_onsale     BOOLEAN #是否促销中
);
#用户购物车
CREATE TABLE waim_shopping_cart(
  cid     INT PRIMAY KEY AUTO_INCREMENT,
  user_id   INT,
  FOREIGN KEY (user_id) REFERENCES waim_user (uid),
  product_id   INT ,
  FOREIGN KEY (product_id) REFERENCES waim_laptop (lid),
  count    INT
);
#订单表，记载所有用户的订单
CREATE TABLE waim_order(
  oid   INT PRIMARY KEY AUTO_INCREMENT,
  user_id  INT,#用户编号
  FOREIGN KEY (user_id) REFERENCES waim_user (uid),
  address_id  INT,
  FOREIGN KEY (address_id) REFERENCES waim_receiver_address (aid),
  status      INT,#订单状态 1-等待付款 2-等待商家接单 3-等待骑手接单 4-骑手取餐 5-配送中 6-已送达 7-已取消
  order_time  BIGINT,#下单时间
  pay_time    BIGINT,#付款时间
  deliver_time  BIGINT,#配送时间
  received_time  BIGINT#签收时间
);
#商品详情页
CREATE TABLE xz_laptop_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  laptop_id INT,              #商品编号
  sm VARCHAR(128),            #小图片路径
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);
#首页轮播图标，商品展示列表，关联到商品表
CREATE TABLE waim_index_carousel(
  cid  INT PRIMARY KEY AUTO_INCREMENT,
  img  VARCHAR(128),#图片路径
  href  VARCHAR(128)#图片链接
);
INSERT INTO waim_index_carousel VALUES
(NULL, 'img/index/banner1.png','product_details.html?lid=28'),
(NULL, 'img/index/banner2.png','product_details.html?lid=19'),
(NULL, 'img/index/banner3.png','lookforward.html'),
(NULL, 'img/index/banner4.png','lookforward.html');
#首页展示产品表，关联到商品表
CREATE TABLE waim_index_product(
  pid   INT PRIMARY KEY AUTO_INCREMENT,
  title  VARCHAR(64),#商品标题
  pic      VARCHAR(128),#图片
  price    DECIMAL(10,2),#商品价格
);
