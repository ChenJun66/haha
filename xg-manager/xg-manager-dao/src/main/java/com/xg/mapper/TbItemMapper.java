package com.xg.mapper;

import com.xg.pojo.TbItem;
import com.xg.pojo.TbItemExample;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface TbItemMapper {
    int countByExample(TbItemExample example);

    int deleteByExample(TbItemExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TbItem record);

    int insertSelective(TbItem record);

    List<TbItem> selectByExample(TbItemExample example);

    TbItem selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TbItem record, @Param("example") TbItemExample example);

    int updateByExample(@Param("record") TbItem record, @Param("example") TbItemExample example);

    int updateByPrimaryKeySelective(TbItem record);

    int updateByPrimaryKey(TbItem record);
    
    List<Map<String, String>> getIdsByTop(@Param("id") String id);
    
    
    long getTotal();
    
    /**
     * 获取每一页的数据
     */
    List<TbItem> getItemListByPage(long startIndex, long pageSize);
    
    List<TbItem> getItemListNotPage(@Param("id") String id, @Param("cids") String[] cids,
                                    @Param("status") String status, @Param("created_start") String created_start, @Param("created_end") String created_end);
    
    Date getCreatedSince();
}