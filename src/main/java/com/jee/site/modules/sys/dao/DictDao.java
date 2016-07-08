/**
 * 
 */
package com.jee.site.modules.sys.dao;

import java.util.List;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.sys.entity.Dict;

/**
 * 字典DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
	public String findValueByWxType(String label);
	
	public void updateValueByWxType(String label);
}
