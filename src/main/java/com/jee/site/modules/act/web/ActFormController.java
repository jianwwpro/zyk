/**
 * 
 */
package com.jee.site.modules.act.web;

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
import com.jee.site.modules.act.entity.ActForm;
import com.jee.site.modules.act.service.ActFormService;

/**
 * 流程表单Controller
 * @author 王建武
 * @version 2016-01-26
 */
@Controller
@RequestMapping(value = "${adminPath}/act/actForm")
public class ActFormController extends BaseController {

	@Autowired
	private ActFormService actFormService;
	
	@ModelAttribute
	public ActForm get(@RequestParam(required=false) String id) {
		ActForm entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = actFormService.get(id);
		}
		if (entity == null){
			entity = new ActForm();
		}
		return entity;
	}
	
	@RequiresPermissions("act:actForm:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActForm actForm, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActForm> page = actFormService.findPage(new Page<ActForm>(request, response), actForm); 
		model.addAttribute("page", page);
		return "modules/act/actFormList";
	}

	@RequiresPermissions("act:actForm:view")
	@RequestMapping(value = "form")
	public String form(ActForm actForm, Model model) {
		model.addAttribute("actForm", actForm);
		return "modules/act/actFormForm";
	}

	@RequiresPermissions("act:actForm:edit")
	@RequestMapping(value = "save")
	public String save(ActForm actForm, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, actForm)){
			return form(actForm, model);
		}
		actFormService.save(actForm);
		addMessage(redirectAttributes, "保存流程表单成功");
		return "redirect:"+Global.getAdminPath()+"/act/actForm/?repage";
	}
	
	@RequiresPermissions("act:actForm:edit")
	@RequestMapping(value = "delete")
	public String delete(ActForm actForm, RedirectAttributes redirectAttributes) {
		actFormService.delete(actForm);
		addMessage(redirectAttributes, "删除流程表单成功");
		return "redirect:"+Global.getAdminPath()+"/act/actForm/?repage";
	}
	
	
	/**
	 * 流程节点表单
	 */
	@RequiresPermissions("act:actForm:edit")
	@RequestMapping(value = "formEdit")
	public String processTaskTree(String category, HttpServletRequest request, HttpServletResponse response, Model model) {
	
	    		return "modules/act/actFormEdit";
	}

}