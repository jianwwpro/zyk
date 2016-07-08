/**
 * 
 */
package com.jee.site.modules.cms.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.cms.entity.Sensitivewords;

/**
 * 敏感词管理DAO接口
 * @author 王建武
 * @version 2016-03-24
 */
@MyBatisDao
public interface SensitivewordsDao extends CrudDao<Sensitivewords> {
	
}