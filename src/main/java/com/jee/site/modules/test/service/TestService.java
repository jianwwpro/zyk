/**
 * 
 */
package com.jee.site.modules.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jee.site.common.service.CrudService;
import com.jee.site.modules.test.entity.Test;
import com.jee.site.modules.test.dao.TestDao;

/**
 * 测试Service
 * 
 * @version 2015-10-17
 */
@Service
@Transactional(readOnly = true)
public class TestService extends CrudService<TestDao, Test> {

}
