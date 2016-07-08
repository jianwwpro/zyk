/**
 * 
 */
package com.jee.site.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jee.site.common.web.BaseController;

/**
 * 忘记密码Controller
 * 
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "/u/sys")
public class ForgetController extends BaseController {

	/**
	 * 忘记密码
	 */
	@RequestMapping(value = "forget")
	public String forget(HttpServletRequest request, HttpServletResponse response, Model model) {

		return "modules/sys/forget";
	}

}
