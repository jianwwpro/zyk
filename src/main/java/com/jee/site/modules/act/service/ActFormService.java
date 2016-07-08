/**
 * 
 */
package com.jee.site.modules.act.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jee.site.common.persistence.Page;
import com.jee.site.common.service.CrudService;
import com.jee.site.modules.act.entity.ActForm;
import com.jee.site.modules.act.dao.ActFormDao;

/**
 * 流程表单Service
 * @author 王建武
 * @version 2016-01-26
 */
@Service
@Transactional(readOnly = true)
public class ActFormService extends CrudService<ActFormDao, ActForm> {

	public ActForm get(String id) {
		return super.get(id);
	}
	
	public List<ActForm> findList(ActForm actForm) {
		return super.findList(actForm);
	}
	
	public Page<ActForm> findPage(Page<ActForm> page, ActForm actForm) {
		return super.findPage(page, actForm);
	}
	
	@Transactional(readOnly = false)
	public void save(ActForm actForm) {
		super.save(actForm);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActForm actForm) {
		super.delete(actForm);
	}
	
}