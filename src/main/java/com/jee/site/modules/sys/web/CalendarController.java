/**
 * 
 */
package com.jee.site.modules.sys.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jee.site.common.web.BaseController;

/**
 * 区域Controller
 * 
 * @version 2015-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/calendar")
public class CalendarController extends BaseController {

	@RequiresPermissions("user")
	@RequestMapping
	public String list(Model model) {

		return "modules/sys/calendar";
	}

}
