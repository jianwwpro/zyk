package com.jee.site.common.jedis.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

/**
 *
 * 
 * @author
 *
 */
@Component
public class RedisInit implements ApplicationListener<ContextRefreshedEvent> {
	//
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if (event.getApplicationContext().getParent() == null) {
		
				
		}

	}

}
