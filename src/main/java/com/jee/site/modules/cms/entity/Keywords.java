/**
 * 
 */
package com.jee.site.modules.cms.entity;

import org.hibernate.validator.constraints.Length;

import com.jee.site.common.persistence.DataEntity;
import com.jee.site.common.utils.excel.annotation.ExcelField;

/**
 * 关键词管理Entity
 * @author 王建武
 * @version 2016-03-24
 */
public class Keywords extends DataEntity<Keywords> {
	
	private static final long serialVersionUID = 1L;
	@ExcelField(title="关键词", type=0, align=2, sort=1)
	private String name;		// 关键词
	private String firstRelationKey;		// 一级关联词
	private String secondRelationKey;		// 二级关联词
	
	
	private Integer count;
	
	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Keywords() {
		super();
	}

	public Keywords(String id){
		super(id);
	}

	@Length(min=1, max=255, message="关键词长度必须介于 1 和 255 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=1000, message="一级关联词长度必须介于 0 和 1000 之间")
	public String getFirstRelationKey() {
		return firstRelationKey;
	}

	public void setFirstRelationKey(String firstRelationKey) {
		this.firstRelationKey = firstRelationKey;
	}
	
	@Length(min=0, max=1000, message="二级关联词长度必须介于 0 和 1000 之间")
	public String getSecondRelationKey() {
		return secondRelationKey;
	}

	public void setSecondRelationKey(String secondRelationKey) {
		this.secondRelationKey = secondRelationKey;
	}
	
}