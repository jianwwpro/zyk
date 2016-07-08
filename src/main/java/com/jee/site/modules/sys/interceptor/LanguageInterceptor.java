/**
 * 
 */
package com.jee.site.modules.sys.interceptor;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.jee.site.common.config.Global;
import com.jee.site.common.service.BaseService;
import com.jee.site.common.utils.Constance;

/**
 * 手机端视图拦截器
 * 
 * @version 2014-9-1
 */
public class LanguageInterceptor extends BaseService implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		String langType = request.getParameter("langType");
		Locale locale =null;
		if(("zh").equals(langType)){
            locale = new Locale("zh", "CN");   
        }
        else if("en".equals(langType)){
            locale = new Locale("en", "US");   
        }
        else {
        	locale = LocaleContextHolder.getLocale();
        }
		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME,locale);
        request.getSession().setAttribute(Constance.LANGUAGE_SESSION_NAME,locale.getLanguage());
		
		
		if(request.getRequestURL().toString().contains(request.getServletContext().getContextPath()+Global.getFrontPath())){
			request.getSession().setAttribute("visted", "front");
		}
		if(request.getRequestURL().toString().contains(request.getServletContext().getContextPath()+Global.getAdminPath())){
			request.getSession().setAttribute("visted", "admin");
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			ModelAndView modelAndView) throws Exception {
//		if (modelAndView != null){
//			// 如果是手机或平板访问的话，则跳转到手机视图页面。
//			if(UserAgentUtils.isMobileOrTablet(request) && !StringUtils.startsWithIgnoreCase(modelAndView.getViewName(), "redirect:")){
//				modelAndView.setViewName("mobile/" + modelAndView.getViewName());
//			}
//		}
		Locale locale = LocaleContextHolder.getLocale();
		String languageTag = locale.toLanguageTag();
		request.setAttribute("lang", languageTag);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
		
	}

}
