/**
 * 
 */
package com.jee.site.modules.cms.dao;

import com.jee.site.common.persistence.CrudDao;
import com.jee.site.common.persistence.annotation.MyBatisDao;
import com.jee.site.modules.cms.entity.Site;

/**
 * 站点DAO接口
 * 
 * @version 2015-8-23
 */
@MyBatisDao
public interface SiteDao extends CrudDao<Site> {

}
