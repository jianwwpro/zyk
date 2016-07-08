/**
 * 
 */
package com.jee.site.common.persistence;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jee.site.modules.act.entity.Act;

/**
 * Activiti Entity类
 * 
 * @version 2015-05-28
 */
public abstract class ActEntity<T> extends DataEntity<T> implements Serializable {

	private static final long serialVersionUID = 1L;
	public static String PROCESS_TASK_KEY_BJB1="bjb1";//编辑部1
	public static String PROCESS_TASK_KEY_BJB2="bjb2";//编辑部2
	public static String PROCESS_TASK_KEY_CLD="cld";//处领导
	public static String PROCESS_TASK_KEY_XMGY="xmgy";//项目官员
	protected Act act; 		// 流程任务对象
	private Integer[] statusq;		// 状态多个状态查询
	public Integer[] getStatusq() {
		return statusq;
	}



	public void setStatusq(Integer[] statusq) {
		this.statusq = statusq;
	}
	public ActEntity() {
		super();
	}
	
	public ActEntity(String id) {
		super(id);
	}
	
	@JsonIgnore
	public Act getAct() {
		if (act == null){
			act = new Act();
		}
		return act;
	}

	public void setAct(Act act) {
		this.act = act;
	}

	/**
	 * 获取流程实例ID
	 * @return
	 */
	public String getProcInsId() {
		return this.getAct().getProcInsId();
	}

	/**
	 * 设置流程实例ID
	 * @param procInsId
	 */
	public void setProcInsId(String procInsId) {
		this.getAct().setProcInsId(procInsId);
	}
}
