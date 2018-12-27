package com.xg.service;

import com.xg.pojo.TbItem;

public interface ItemService {
    /**
     * 根据商品的id查询商品信息
     * @param id
     * @return
     */
    TbItem getItemById(long itemId);
}
