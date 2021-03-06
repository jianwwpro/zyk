/**
 * 
 */
package com.jee.site.test.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.test.entity.TestDataChild;

/**
 * 主子表生成DAO接口
 * 
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestDataChildDao extends CrudDao<TestDataChild> {
	
}