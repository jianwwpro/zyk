/**
 * 
 */
package com.jee.site.modules.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jee.site.common.persistence.Page;
import com.jee.site.common.service.CrudService;
import com.jee.site.modules.cms.entity.Keywords;
import com.jee.site.modules.cms.dao.KeywordsDao;

/**
 * 关键词管理Service
 * @author 王建武
 * @version 2016-03-24
 */
@Service
@Transactional(readOnly = true)
public class KeywordsService extends CrudService<KeywordsDao, Keywords> {

	public Keywords get(String id) {
		return super.get(id);
	}
	
	public List<Keywords> findList(Keywords keywords) {
		return super.findList(keywords);
	}
	
	public Page<Keywords> findPage(Page<Keywords> page, Keywords keywords) {
		return super.findPage(page, keywords);
	}
	
	@Transactional(readOnly = false)
	public void save(Keywords keywords) {
		super.save(keywords);
	}
	
	@Transactional(readOnly = false)
	public void delete(Keywords keywords) {
		super.delete(keywords);
	}
	
}