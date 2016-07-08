/**
 * 
 */
package com.jee.site.common.tags;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

import com.jee.site.common.web.LanguageEnum;

public class LocalUtils {

	private static final long serialVersionUID = 1L;
	private static Logger logger = LoggerFactory.getLogger(LocalUtils.class);

	public static String getMessage(String key) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		// 获取网站语言

		RequestContext requestContext = new RequestContext(request);

		String message = requestContext.getMessage(key);
		if(StringUtils.isBlank(message)){
			return key;
		}
		return message;

	}

	public static String getMessage(String key, Object args) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		// 获取网站语言

		RequestContext requestContext = new RequestContext(request);

		// String message = requestContext.getMessage(key);
		String[] as = null;
		if (args instanceof String) {
			as = new String[1];
			as[0] = (String) args;
		} else if (args instanceof String[]) {
			as = (String[]) args;
		} else if (args instanceof List) {
			List list = (List) args;
			as = new String[list.size()];
			for (int i = 0; i < list.size(); i++) {
				as[i] = (String) list.get(i);
			}
		}
		else if (args instanceof Integer) {
			as = new String[1];
			as[0] = (Integer) args +"";
		}else if(args instanceof Long){
			as = new String[1];
			as[0] = (Long) args +"";
		}
		String message2 = requestContext.getMessage(key, as);
		if(StringUtils.isBlank(message2)){
			return key;
		}
		return message2;

	}

	/**
	 * 获取期刊版本
	 * 
	 * @param key
	 * @return
	 */
	public static String getJournalV(String key) {

		if (StringUtils.isBlank(key)) {
			return "";
		}
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		// 获取网站语言

		RequestContext requestContext = new RequestContext(request);

		LanguageEnum languageEnum = LanguageEnum.getFromtValue(Integer.valueOf(key));

		if (languageEnum != null) {
			return languageEnum.getJournalName();
		}

		return "";

	}

}
