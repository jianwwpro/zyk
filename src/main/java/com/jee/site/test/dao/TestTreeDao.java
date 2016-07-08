/**
 * 
 */
package com.jee.site.test.dao;

import com.jee.site.common.persistence.TreeDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.test.entity.TestTree;

/**
 * 树结构生成DAO接口
 * 
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}