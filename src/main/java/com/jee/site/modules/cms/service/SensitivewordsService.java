/**
 * 
 */
package com.jee.site.modules.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jee.site.common.persistence.Page;
import com.jee.site.common.service.CrudService;
import com.jee.site.modules.cms.entity.Sensitivewords;
import com.jee.site.modules.cms.dao.SensitivewordsDao;

/**
 * 敏感词管理Service
 * @author 王建武
 * @version 2016-03-24
 */
@Service
@Transactional(readOnly = true)
public class SensitivewordsService extends CrudService<SensitivewordsDao, Sensitivewords> {

	public Sensitivewords get(String id) {
		return super.get(id);
	}
	
	public List<Sensitivewords> findList(Sensitivewords sensitivewords) {
		return super.findList(sensitivewords);
	}
	
	public Page<Sensitivewords> findPage(Page<Sensitivewords> page, Sensitivewords sensitivewords) {
		return super.findPage(page, sensitivewords);
	}
	
	@Transactional(readOnly = false)
	public void save(Sensitivewords sensitivewords) {
		super.save(sensitivewords);
	}
	
	@Transactional(readOnly = false)
	public void delete(Sensitivewords sensitivewords) {
		super.delete(sensitivewords);
	}
	
}