/**
 * 
 */
package com.jee.site.modules.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jee.site.common.service.CrudService;
import com.jee.site.modules.cms.dao.ArticleDataDao;
import com.jee.site.modules.cms.entity.ArticleData;

/**
 * 站点Service
 * 
 * @version 2015-01-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleDataService extends CrudService<ArticleDataDao, ArticleData> {

}
