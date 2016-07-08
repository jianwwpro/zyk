/**
 * 
 */
package com.jee.site.modules.act.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.act.entity.ActForm;

/**
 * 流程表单DAO接口
 * @author 王建武
 * @version 2016-01-26
 */
@MyBatisDao
public interface ActFormDao extends CrudDao<ActForm> {
	
}