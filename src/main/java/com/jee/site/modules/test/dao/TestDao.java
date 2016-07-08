/**
 * 
 */
package com.jee.site.modules.test.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.test.entity.Test;

/**
 * 测试DAO接口
 * 
 * @version 2015-10-17
 */
@MyBatisDao
public interface TestDao extends CrudDao<Test> {
	
}
