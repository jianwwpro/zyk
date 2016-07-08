/**
 * 
 */
package com.jee.site.modules.gen.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * 
 * @version 2015-10-15
 */
@MyBatisDao
public interface GenTableColumnDao extends CrudDao<GenTableColumn> {
	
	public void deleteByGenTableId(String genTableId);
}
