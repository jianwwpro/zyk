package com.jee.site.common.web;

import java.util.Locale;

import org.springframework.context.i18n.LocaleContextHolder;

public enum LanguageEnum {

	CHINESE("中文", 0,""),
	FRENCH("法文", 1,"中法对照版"), 
	ARABIC("阿拉伯文",2, "中阿对照版"), 
	THAI("泰文", 3,"中泰对照版"), 
	RUSSIAN("俄文", 4,"中俄对照版"),
	ENGLISH("英文", 5,"中英对照版"), 
	SPANISH("西班牙文", 6,"中西对照版"), 
	JAPANESE("日文", 7,"中日对照版"), 
	ITALIAN("意大利文", 8,"中意对照版"), 
	GERMAN("德文", 9,"中德对照版"), 
	POTUGUESE("葡萄牙文", 10,"中葡对照版"), 
	KOREAN("韩文", 11,"中韩对照版");

	private String name;
	private int value;
	private String journalName;

	private LanguageEnum(String name, int value) {
		this.name = name;
		this.value = value;

	}
	
	private LanguageEnum(String name, int value, String journalName) {
		this.name = name;
		this.value = value;
		this.journalName=journalName;

	}
	/**
	 * 获取网站对应语种的信息
	 * @return
	 */
	public static LanguageEnum localeLanguage(){
//		获取网站语言
		Locale locale = LocaleContextHolder.getLocale();
		String languageTag = locale.toLanguageTag();
		if("zh-CN".equals(languageTag)){
			return LanguageEnum.CHINESE;
		}else{
			return LanguageEnum.ENGLISH;
		}
	}
	
	
	public static LanguageEnum getFromtValue(int value){
		LanguageEnum[] values = LanguageEnum.values();
		for (LanguageEnum languageEnum : values) {
			if(languageEnum.getValue()==value){
				return languageEnum;
			}
		}
		return null;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getJournalName() {
		return journalName;
	}

	public void setJournalName(String journalName) {
		this.journalName = journalName;
	}

	
	
}
