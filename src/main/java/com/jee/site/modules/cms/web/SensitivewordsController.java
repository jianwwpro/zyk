/**
 * 
 */
package com.jee.site.modules.cms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jee.site.common.config.Global;
import com.jee.site.common.persistence.Page;
import com.jee.site.common.web.BaseController;
import com.jee.site.common.utils.StringUtils;
import com.jee.site.modules.cms.entity.Sensitivewords;
import com.jee.site.modules.cms.service.SensitivewordsService;

/**
 * 敏感词管理Controller
 * @author 王建武
 * @version 2016-03-24
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/sensitivewords")
public class SensitivewordsController extends BaseController {

	@Autowired
	private SensitivewordsService sensitivewordsService;
	
	@ModelAttribute
	public Sensitivewords get(@RequestParam(required=false) String id) {
		Sensitivewords entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sensitivewordsService.get(id);
		}
		if (entity == null){
			entity = new Sensitivewords();
		}
		return entity;
	}
	
	@RequiresPermissions("cms:sensitivewords:view")
	@RequestMapping(value = {"list", ""})
	public String list(Sensitivewords sensitivewords, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Sensitivewords> page = sensitivewordsService.findPage(new Page<Sensitivewords>(request, response), sensitivewords); 
		model.addAttribute("page", page);
		return "modules/cms/sensitivewordsList";
	}

	@RequiresPermissions("cms:sensitivewords:view")
	@RequestMapping(value = "form")
	public String form(Sensitivewords sensitivewords, Model model) {
		model.addAttribute("sensitivewords", sensitivewords);
		return "modules/cms/sensitivewordsForm";
	}

	@RequiresPermissions("cms:sensitivewords:edit")
	@RequestMapping(value = "save")
	public String save(Sensitivewords sensitivewords, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sensitivewords)){
			return form(sensitivewords, model);
		}
		sensitivewordsService.save(sensitivewords);
		addMessage(redirectAttributes, "保存敏感词管理成功");
		return "redirect:"+Global.getAdminPath()+"/cms/sensitivewords/?repage";
	}
	
	@RequiresPermissions("cms:sensitivewords:edit")
	@RequestMapping(value = "delete")
	public String delete(Sensitivewords sensitivewords, RedirectAttributes redirectAttributes) {
		sensitivewordsService.delete(sensitivewords);
		addMessage(redirectAttributes, "删除敏感词管理成功");
		return "redirect:"+Global.getAdminPath()+"/cms/sensitivewords/?repage";
	}

}