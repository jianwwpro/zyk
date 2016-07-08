/**
 * 
 */
package com.jee.site.modules.gen.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.gen.entity.GenTable;

/**
 * 业务表DAO接口
 * 
 * @version 2015-10-15
 */
@MyBatisDao
public interface GenTableDao extends CrudDao<GenTable> {
	
}
