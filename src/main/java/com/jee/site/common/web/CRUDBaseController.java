/**
 * 
 */
package com.jee.site.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jee.site.common.persistence.DataEntity;
import com.jee.site.common.persistence.Page;
import com.jee.site.common.service.CrudService;
import com.jee.site.common.utils.StringUtils;

public class CRUDBaseController<S extends CrudService,T extends DataEntity> extends BaseController {

	@Autowired
	private S baseService;
	
	private String modelName=null;
	private String objectName = null;
	
	public CRUDBaseController(){
		String[] words = getWords(this.getClass().getSimpleName());
		modelName = words[0];
		objectName= words[1];
	}
	
	
	/**
	 * 以字符串中的大写字母为标示拆分字符串,如果字符串为null或空则返回null
	 * @param str
	 * @return String[] 拆分后的字符串，已转换为全小写
	 */
	private String[] getWords(String str) {
		if (StringUtils.isEmpty(str)) return null;
		String[] words = str.split("(?<!^)(?=[A-Z])");
		for (int i = 0; i < words.length; i++) {
			words[i] = StringUtils.lowerCase(words[i]);
		}
		return words;
	}	
	
	@ModelAttribute
	public T get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return (T) baseService.get(id);
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(T t, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<T> page = baseService.findPage(new Page<T>(request, response), t); 
        model.addAttribute("page", page);
		return "modules/"+modelName+"/"+modelName+"List";
	}

	@RequestMapping(value = "form")
	public String form(T t, Model model) {
		model.addAttribute("dict", t);
		return "modules/"+modelName+"/"+modelName+"Form";
	}

	@RequestMapping(value = "save")
	public String save(T t, Model model, RedirectAttributes redirectAttributes) {
		
		if (!beanValidator(model, t)){
			return form(t, model);
		}
		baseService.save(t);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/"+modelName+"/"+objectName+"/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(T t, RedirectAttributes redirectAttributes) {
		
		baseService.delete(t);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/sys/dict/?repage";
	}
}
