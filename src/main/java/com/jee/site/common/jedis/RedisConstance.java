package com.jee.site.common.jedis;

import org.springframework.stereotype.Component;

@Component
public class RedisConstance {

	/**
	 * 期刊---版本  journal_list-版本
	 */
	public static final String JOURNAL_LSIT="journal_list-";
	/**
	 * 目录---期刊
	 */
	public static final String JOURNALLIST_JOURNAL="journallist_journal-";

	
	/**
	 * 文章--语种  article_list-语种
	 */
	public static final String ARTICLE_LANGUAGE="article_language-";
	
	/**
	 * 文章--语种  article_list-语种
	 */
	public static final String ARTICLE_LANG="article_lang-";
	
	/**

	 * 文章---期刊--推荐
	 */
	public static final String ARTICLE_TJ_JOURNAL="article_tj_journal-";
	
	/**

	 * 文章---目录--推荐
	 */
	public static final String ARTICLE_TJ_MENU="article_tj_menu-";
	/**

	 * 文章---推荐---语种
	 */
	public static final String ARTICLE_TJ="article_tj-";
	/**
	 * 文章---目录
	 */
	public static final String ARTICLE_MENU="article_menu-";
	
	
	/**
	 * 博文---语种
	 */
	public static final String BLOG_LANGUAGE="blog_language-";
	
	/**
	 * 热门博主
	 */
	public static final String BLOGER_LIST="bloger_list";
	
	/**
	 * 预告---推荐
	 */
	public static final String ACTIVITY_TJ="activity_tj";
	
	/**
	 * 积分记录
	 */
	public static final String REWARDS_LIST="rewards_list-";
	/**
	 * 相关文章
	 */
	public static final String ARTICLE_RELATION="article_relation-";
	/**
	 * 打分
	 */
	public static final String SCORE="score-";
	/**
	 * 收藏
	 */
	public static final String COLLECT="collect-";
	/**
	 * 收藏-期刊
	 */
	public static final String COLLECT_JOURNAL="collect-journal-";
	/**
	 * 收藏-文章
	 */
	public static final String COLLECT_ARTICLE="collect-article-";
	/**
	 * 收藏-活动
	 */
	public static final String COLLECT_ACTIVITY="collect-activity-";
	/**
	 * 收藏-博客
	 */
	public static final String COLLECT_BLOG="collect-blog-";
	/**
	 * 浏览次数
	 */
	public static final String BROW_COUNT="brow-count";
	
	
	
	/**
	 * 活动、公告、信息类
	 */
	public static final String ACTIVITY_LIST="activity-";
	
}

