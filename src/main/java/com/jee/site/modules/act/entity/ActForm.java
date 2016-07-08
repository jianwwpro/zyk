/**
 * 
 */
package com.jee.site.modules.act.entity;

import org.hibernate.validator.constraints.Length;

import com.jee.site.common.persistence.DataEntity;

/**
 * 流程表单Entity
 * @author 王建武
 * @version 2016-01-26
 */
public class ActForm extends DataEntity<ActForm> {
	
	private static final long serialVersionUID = 1L;
	private String formContent;		// 表单编辑器文本
	private String formParse;		// form_parse
	private String proDefId;		// pro_def_id
	private String taskDefId;		// task_def_id
	
	public ActForm() {
		super();
	}

	public ActForm(String id){
		super(id);
	}

	public String getFormContent() {
		return formContent;
	}

	public void setFormContent(String formContent) {
		this.formContent = formContent;
	}
	
	public String getFormParse() {
		return formParse;
	}

	public void setFormParse(String formParse) {
		this.formParse = formParse;
	}
	
	@Length(min=0, max=64, message="pro_def_id长度必须介于 0 和 64 之间")
	public String getProDefId() {
		return proDefId;
	}

	public void setProDefId(String proDefId) {
		this.proDefId = proDefId;
	}
	
	@Length(min=0, max=64, message="task_def_id长度必须介于 0 和 64 之间")
	public String getTaskDefId() {
		return taskDefId;
	}

	public void setTaskDefId(String taskDefId) {
		this.taskDefId = taskDefId;
	}
	
}