/**
 * 
 */
package com.jee.site.modules.cms.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jee.site.common.mapper.JsonMapper;
import com.jee.site.common.persistence.Page;
import com.jee.site.common.utils.StringUtils;
import com.jee.site.common.web.BaseController;
import com.jee.site.modules.cms.entity.Article;
import com.jee.site.modules.cms.entity.Category;
import com.jee.site.modules.cms.entity.Keywords;
import com.jee.site.modules.cms.entity.Site;
import com.jee.site.modules.cms.service.ArticleDataService;
import com.jee.site.modules.cms.service.ArticleService;
import com.jee.site.modules.cms.service.CategoryService;
import com.jee.site.modules.cms.service.FileTplService;
import com.jee.site.modules.cms.service.KeywordsService;
import com.jee.site.modules.cms.service.SiteService;
import com.jee.site.modules.cms.utils.CmsUtils;
import com.jee.site.modules.cms.utils.TplUtils;
import com.jee.site.modules.sys.utils.UserUtils;

/**
 * 文章Controller
 * 
 * @version 2015-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/article")
public class ArticleController extends BaseController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private FileTplService fileTplService;
	@Autowired
	private SiteService siteService;

	@ModelAttribute
	public Article get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return articleService.get(id);
		} else {
			return new Article();
		}
	}

	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = { "list", "" })
	public String list(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
		// for (int i=0; i<10000000; i++){
		// Article a = new Article();
		// a.setCategory(new Category(article.getCategory().getId()));
		// a.setTitle("测试测试测试测试测试测试测试测试"+a.getCategory().getId());
		// a.setArticleData(new ArticleData());
		// a.getArticleData().setContent(a.getTitle());
		// articleService.save(a);
		// }
		Page<Article> page = articleService.findPage(new Page<Article>(request, response), article, true);
		model.addAttribute("page", page);
		return "modules/cms/articleList";
	}

	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "form")
	public String form(Article article, Model model, HttpServletRequest request) {
		// 如果当前传参有子节点，则选择取消传参选择
		// RequestContext requestContext = new RequestContext(request);
		// model.addAttribute("cms.news.title",
		// requestContext.getMessage("cms.news.title"));
		//

		if (article.getCategory() != null && StringUtils.isNotBlank(article.getCategory().getId())) {
			List<Category> list = categoryService.findByParentId(article.getCategory().getId(), Site.getCurrentSiteId());
			if (list.size() > 0) {
				article.setCategory(null);
			} else {
				article.setCategory(categoryService.get(article.getCategory().getId()));
			}
		}
		article.setArticleData(articleDataService.get(article.getId()));
		// if (article.getCategory()=null &&
		// StringUtils.isNotBlank(article.getCategory().getId())){
		// Category category =
		// categoryService.get(article.getCategory().getId());
		// }
		model.addAttribute("contentViewList", getTplContent());
		model.addAttribute("article_DEFAULT_TEMPLATE", Article.DEFAULT_TEMPLATE);
		model.addAttribute("article", article);
		CmsUtils.addViewConfigAttribute(model, article.getCategory());
		return "modules/cms/articleForm";
	}

	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "save")
	public String save(Article article, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, article)) {
			return form(article, model, request);
		}
		articleService.save(article);
		addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(), 50) + "'成功");
		String categoryId = article.getCategory() != null ? article.getCategory().getId() : null;
		return "redirect:" + adminPath + "/cms/article/?repage&category.id=" + (categoryId != null ? categoryId : "");
	}

	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "delete")
	public String delete(Article article, String categoryId, @RequestParam(required = false) Boolean isRe, RedirectAttributes redirectAttributes) {
		// 如果没有审核权限，则不允许删除或发布。
		if (!UserUtils.getSubject().isPermitted("cms:article:audit")) {
			addMessage(redirectAttributes, "你没有删除或发布权限");
		}
		articleService.delete(article, isRe);
		addMessage(redirectAttributes, (isRe != null && isRe ? "发布" : "删除") + "文章成功");
		return "redirect:" + adminPath + "/cms/article/?repage&category.id=" + (categoryId != null ? categoryId : "");
	}

	/**
	 * 文章选择列表
	 */
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "selectList")
	public String selectList(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(article, request, response, model);
		return "modules/cms/articleSelectList";
	}

	/**
	 * 通过编号获取文章标题
	 */
	@RequiresPermissions("cms:article:view")
	@ResponseBody
	@RequestMapping(value = "findByIds")
	public String findByIds(String ids) {
		List<Object[]> list = articleService.findByIds(ids);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}

	@Autowired
	KeywordsService keywordsService;

	

	private List<String> getTplContent() {
		List<String> tplList = fileTplService.getNameListByPrefix(siteService.get(Site.getCurrentSiteId()).getSolutionPath());
		tplList = TplUtils.tplTrim(tplList, Article.DEFAULT_TEMPLATE, "");
		return tplList;
	}
}