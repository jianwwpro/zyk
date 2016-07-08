/**
 * 
 */
package com.jee.site.modules.gen.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.gen.entity.GenScheme;

/**
 * 生成方案DAO接口
 * 
 * @version 2015-10-15
 */
@MyBatisDao
public interface GenSchemeDao extends CrudDao<GenScheme> {
	
}
