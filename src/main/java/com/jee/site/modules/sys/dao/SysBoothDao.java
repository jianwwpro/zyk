/**
 * 
 */
package com.jee.site.modules.sys.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.sys.entity.SysBooth;

/**
 * 展位DAO接口
 * @author 费春腾
 * @version 2016-04-18
 */
@MyBatisDao
public interface SysBoothDao extends CrudDao<SysBooth> {
	
}