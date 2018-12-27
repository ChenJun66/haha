package com.xg.pojo;

import java.io.Serializable;
import java.util.Date;

public class TbContent implements Serializable{
    private static final long serialVersionUID = 7271640988990917372L;
    //一个建表语句可以衍生出很多细节来
    
//    CREATE TABLE `tb_content` (
//            `id` bigint(20) NOT NULL AUTO_INCREMENT,//自增长
//            `category_id` bigint(20) NOT NULL COMMENT '内容类目ID',
//            `title` varchar(200) DEFAULT NULL COMMENT '内容标题',
//            `sub_title` varchar(100) DEFAULT NULL COMMENT '子标题',
//            `title_desc` varchar(500) DEFAULT NULL COMMENT '标题描述',
//            `url` varchar(500) DEFAULT NULL COMMENT '链接',
//            `pic` varchar(300) DEFAULT NULL COMMENT '图片绝对路径',
//            `pic2` varchar(300) DEFAULT NULL COMMENT '图片2',
//            `content` text COMMENT '内容',//用的是text 不可以有默认值
//            `created` datetime DEFAULT NULL,
//            `updated` datetime DEFAULT NULL,
//            PRIMARY KEY (`id`),//主键是id   
//            KEY `category_id` (`category_id`),
//            KEY `updated` (`updated`)   这个为什么要做为主键  难道是不能重复
//     ) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;  AUTO_INCREMENT=36 目前的最大自增索引号；  ENGINE=InnoDB 选择数据表引擎；  DEFAULT CHARSET=utf8 选择合适的编码；
    
    
    
//    mysql中char，varchar与text类型的区别和选用
//    关于char，varchar与text平时没有太在意，一般来说，可能现在大家都是用varchar。但是当要存储的内容比较大时，究竟是选择varchar还是text呢？不知道。。。。。。
//
//    text 、 char、varchar  是数据在数据库中的存放策略问题，为了，合理
//    应用存储空间，是数据库服务器数据类型划分的方式。对于应用程序，把它们
//    和string对应就可以了。
//
//    于是去查阅了一些资料，顺便将这三种类型做个比较：
//
//    （1）char:  char不用多说了，它是定长格式的，但是长度范围是0~255. 当你想要储存一个长度不足255的字符时，MySQL会用空格来填充剩下的字符。因此在读取数据时，char类型的数据要进行处理，把后面的空格去除。
//
//    （2）varchar:  关于varchar，有的说最大长度是255，也有的说是65535，查阅很多资料后发现是这样的：varchar类型在5.0.3以下的版本中的最大长度限制为255，而在5.0.3及以上的版本中，varchar数据类型的长度支持到了65535，也就是说可以存放65532个字节（注意是字节而不是字符！！！）的数据（起始位和结束位占去了3个字节），也就是说，在5.0.3以下版本中需要使用固定的TEXT或BLOB格式存放的数据可以在高版本中使用可变长的varchar来存放，这样就能有效的减少数据库文件的大小。
//
//    （3）text:与char和varchar不同的是，text不可以有默认值，其最大长度是2的16次方-1
//
//    总结起来，有几点：
//    1.经常变化的字段用varchar
//    2.知道固定长度的用char
//    3.尽量用varchar
//    4.超过255字符的只能用varchar或者text
//    5.能用varchar的地方不用text 
    

    private Long id;//bigint

    private Long categoryId;

    private String title;

    private String subTitle;//varchar

    private String titleDesc;

    private String url;

    private String pic;

    private String pic2;

    private Date created;

    private Date updated;

    private String content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }
    
    
    

    public String getTitle() {
        return title;
    }
    
    //这个在这里就已经做了前后去掉空格的处理了  这种是比较好的 
    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getSubTitle() {
        return subTitle;
    }

    //这种思维比较好的 
    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle == null ? null : subTitle.trim();
    }

    public String getTitleDesc() {
        return titleDesc;
    }

    public void setTitleDesc(String titleDesc) {
        this.titleDesc = titleDesc == null ? null : titleDesc.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public String getPic2() {
        return pic2;
    }

    public void setPic2(String pic2) {
        this.pic2 = pic2 == null ? null : pic2.trim();
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}