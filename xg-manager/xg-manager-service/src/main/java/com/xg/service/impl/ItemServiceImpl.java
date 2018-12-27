package com.xg.service.impl;

import com.xg.mapper.TbItemMapper;
import com.xg.pojo.TbItem;
import com.xg.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("itemServiceImpl")
public class ItemServiceImpl implements ItemService {
    @Autowired
    private TbItemMapper itemMapper;

    @Override
    public TbItem getItemById(long itemId) {
        TbItem tbItem = itemMapper.selectByPrimaryKey(itemId);
        return tbItem;
    }
}
