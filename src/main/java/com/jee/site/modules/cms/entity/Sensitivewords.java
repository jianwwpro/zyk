/**
 * 
 */
package com.jee.site.modules.cms.entity;

import org.hibernate.validator.constraints.Length;

import com.jee.site.common.persistence.DataEntity;

/**
 * 敏感词管理Entity
 * @author 王建武
 * @version 2016-03-24
 */
public class Sensitivewords extends DataEntity<Sensitivewords> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 词语
	
	public Sensitivewords() {
		super();
	}

	public Sensitivewords(String id){
		super(id);
	}

	@Length(min=1, max=255, message="词语长度必须介于 1 和 255 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}