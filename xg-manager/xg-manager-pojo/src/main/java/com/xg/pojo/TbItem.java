package com.xg.pojo;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TbItem implements Serializable {
    private static final long serialVersionUID = 2591442191338984388L;

    private Long id;

    private String title;

    private String sellPoint;

    private Long price;
    
    private String priceStr;//价格 eg:10元

    private Integer num;

    private String barcode;

    private String image;

    private Long cid;
    
    private String cidName;//cid中文名称

    private Byte status;
    
    private String statusStr;
    
    private Date created;
    
    private String createdStr;

    private Date updated;
    
    private String updatedStr;
    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getSellPoint() {
        return sellPoint;
    }

    public void setSellPoint(String sellPoint) {
        this.sellPoint = sellPoint == null ? null : sellPoint.trim();
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode == null ? null : barcode.trim();
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image == null ? null : image.trim();
    }

    public Long getCid() {
        return cid;
    }

    public void setCid(Long cid) {
        this.cid = cid;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
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

    public String getCidName() {
        return cidName;
    }

    public void setCidName(String cidName) {
        this.cidName = cidName;
    }

    public String getPriceStr() {
        return priceStr;
    }

    public void setPriceStr(String priceStr) {
        this.priceStr = priceStr;
    }

    public String getStatusStr() {
        return statusStr;
    }

    public void setStatusStr(String statusStr) {
        this.statusStr = statusStr;
    }

    public String getCreatedStr() {
        return createdStr;
    }

    public void setCreatedStr(String createdStr) {
        this.createdStr = createdStr;
    }

    public String getUpdatedStr() {
        return updatedStr;
    }

    public void setUpdatedStr(String updatedStr) {
        this.updatedStr = updatedStr;
    }
    
    
    
    /***************************************标准的日期这样处理***************************************/
    
//    Mysql中的DATE和DATETIME有什么区别？ 
//
//    DATETIME
//    类型可用于需要同时包含日期和时间信息的值。MySQL 以 'YYYY-MM-DD HH:MM:SS'
//    格式检索与显示 DATETIME 类型。支持的范围是
//    '1000-01-01
//    00:00:00' 到 '9999-12-31
//    23:59:59'。(“支持”的含义是，尽管更早的值可能工作，但不能保证他们均可以。)
//
//    DATE
//    类型可用于需要一个日期值而不需要时间部分时,MySQL 以 'YYYY-MM-DD' 格式检索与显示
//    DATE
//    值。支持的范围是 '1000-01-01' 到
//    '9999-12-31'。
//
//    但是在java中只有Date类型，这样数据存储会出现问题，前台提交的数据，比如2016-10-10 14:30:59,后台用Date接受的时候，由于Date之精确到天，所以，默认接收时间为2016-10-10 00:00:00,保存到mysql数据库之后，重新取出数据的时候又会发现，数据为2016-10-10 00:00:00.0，无缘无故在后面多了一个.0，这样页面渲染的时候就会报错，

//    解决方法：
    // 前台提交到java后端时：
    private Date date;
    private String dateStr;
    

    public Date getDate() {
        return date;
    }

    public void setDate(String date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        try {
            this.date = sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    // 从数据库查询出的数据：
    public String getDateStr() {
        if (this.date!=null) {
            return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(this.date);
        }else {
            return "";
        }
    }
    // 在页面渲染的时候获取属性dateStr即可！
    

    public void setDateStr(String dateStr) {
        this.dateStr = dateStr;
    }
    
    
    
}