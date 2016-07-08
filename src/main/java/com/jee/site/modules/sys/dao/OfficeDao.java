/**
 * 
 */
package com.jee.site.modules.sys.dao;

import com.jee.site.common.persistence.TreeDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	
}
