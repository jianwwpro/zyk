/**
 * 
 */
package com.jee.site.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.jee.site.common.persistence.DataEntity;

/**
 * 楼层Entity
 * @author 费春腾
 * @version 2016-04-18
 */
public class SysFloor extends DataEntity<SysFloor> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 楼层
	private String descs;		// 描述
	private String author;		// 责任者
	private String tel;		// 电话
	private String no;		// 编号，序号
	private String pic;		// 地图
	
	public SysFloor() {
		super();
	}

	public SysFloor(String id){
		super(id);
	}

	@Length(min=0, max=50, message="楼层长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=600, message="描述长度必须介于 0 和 600 之间")
	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}
	
	@Length(min=0, max=45, message="责任者长度必须介于 0 和 45 之间")
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	@Length(min=0, max=20, message="电话长度必须介于 0 和 20 之间")
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Length(min=0, max=9, message="编号，序号长度必须介于 0 和 9 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@Length(min=0, max=200, message="地图长度必须介于 0 和 200 之间")
	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}
	
}