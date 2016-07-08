/**
 * 
 */
package com.jee.site.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jee.site.common.service.CrudService;
import com.jee.site.common.utils.CacheUtils;
import com.jee.site.modules.sys.dao.DictDao;
import com.jee.site.modules.sys.entity.Dict;
import com.jee.site.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * 
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	/**
	 * 查询并更新微信的自增长id
	 * @param wxType	微信的类型
	 * @return	微信的id值
	 */
	@Transactional(readOnly = false)
	public String findValueByWxType(String wxType){
		String value=dao.findValueByWxType(wxType);
		dao.updateValueByWxType(wxType);
		return value;
	}
}
