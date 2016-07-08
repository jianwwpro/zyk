/**
 * 
 */
package com.jee.site.modules.sys.dao;

import com.jee.site.common.persistence.TreeDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
