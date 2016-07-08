/**
 * 
 */
package com.jee.site.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.jee.site.common.persistence.DataEntity;

/**
 * 展位Entity
 * @author 费春腾
 * @version 2016-04-18
 */
public class SysBooth extends DataEntity<SysBooth> {
	
	private static final long serialVersionUID = 1L;
	private String floorId;		// 楼层id
	private String floorName;		// 楼层名称
	private String floorNo;		// 楼层
	private String name;		// 展厅名称
	private String no;		// 展厅编号
	private String descs;		// 展厅描述
	private String tel;		// 电话
	private String author;		// 责任人
	private Double pointX;		// 矩形点x
	private Double pointY;		// 矩形点y
	private Double rectW;		// 矩形宽
	private Double rectH;		// 矩形高
	private String floorPic;		// 楼层图纸
	private String colour;		// 矩形颜色
	private String area;		// 面积
	
	public SysBooth() {
		super();
	}

	public SysBooth(String id){
		super(id);
	}

	@Length(min=0, max=64, message="楼层id长度必须介于 0 和 64 之间")
	public String getFloorId() {
		return floorId;
	}

	public void setFloorId(String floorId) {
		this.floorId = floorId;
	}
	
	@Length(min=0, max=45, message="楼层名称长度必须介于 0 和 45 之间")
	public String getFloorName() {
		return floorName;
	}

	public void setFloorName(String floorName) {
		this.floorName = floorName;
	}
	
	@Length(min=0, max=45, message="楼层长度必须介于 0 和 45 之间")
	public String getFloorNo() {
		return floorNo;
	}

	public void setFloorNo(String floorNo) {
		this.floorNo = floorNo;
	}
	
	@Length(min=0, max=45, message="展厅名称长度必须介于 0 和 45 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=9, message="展厅编号长度必须介于 0 和 9 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@Length(min=0, max=600, message="展厅描述长度必须介于 0 和 600 之间")
	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}
	
	@Length(min=0, max=20, message="电话长度必须介于 0 和 20 之间")
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Length(min=0, max=50, message="责任人长度必须介于 0 和 50 之间")
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	public Double getPointX() {
		return pointX;
	}

	public void setPointX(Double pointX) {
		this.pointX = pointX;
	}
	
	public Double getPointY() {
		return pointY;
	}

	public void setPointY(Double pointY) {
		this.pointY = pointY;
	}
	
	public Double getRectW() {
		return rectW;
	}

	public void setRectW(Double rectW) {
		this.rectW = rectW;
	}
	
	public Double getRectH() {
		return rectH;
	}

	public void setRectH(Double rectH) {
		this.rectH = rectH;
	}
	
	@Length(min=0, max=100, message="楼层图纸长度必须介于 0 和 100 之间")
	public String getFloorPic() {
		return floorPic;
	}

	public void setFloorPic(String floorPic) {
		this.floorPic = floorPic;
	}
	
	@Length(min=0, max=7, message="矩形颜色长度必须介于 0 和 7 之间")
	public String getColour() {
		return colour;
	}

	public void setColour(String colour) {
		this.colour = colour;
	}
	
	@Length(min=0, max=45, message="面积长度必须介于 0 和 45 之间")
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
}