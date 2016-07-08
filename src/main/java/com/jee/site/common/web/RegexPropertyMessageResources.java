package com.jee.site.common.web;

import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.NoSuchMessageException;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.util.StringUtils;

public class RegexPropertyMessageResources implements MessageSource{
    private static Log logger = LogFactory.getLog(RegexPropertyMessageResources.class);

    public static String PROPERTY_POSTFIX = ".properties";
    // 加载属性资源文件
    // private ResourceBundleMessageSource resourceBundleMessageSource = new
    // ResourceBundleMessageSource();
    private ReloadableResourceBundleMessageSource resourceBundleMessageSource = new ReloadableResourceBundleMessageSource();
    // 支持通配符匹配　
    private PathMatchingResourcePatternResolver patternResolver = new PathMatchingResourcePatternResolver();

    public RegexPropertyMessageResources() {

    }

    public RegexPropertyMessageResources(String baseName) {
        setBaseNames(new String[] { baseName });
    }

    public RegexPropertyMessageResources(String[] baseNames) {
        setBaseNames(baseNames);
    }

    public void setBaseName(String baseName) {
        setBaseNames(new String[] { baseName });
    }
    
    public void setBasenames(String[] basenames){
    	this.setBaseNames(basenames);
    }

    public void setBaseNames(String[] baseNames) {
        Set<String> baseNameList = new HashSet<String>();
        try {
            for (String baseName : baseNames) {
                Resource[] resources = patternResolver.getResources(baseName); // 通过通配符取得到所有对应的source
                for (Resource resource : resources) {
                    // "classes/"和“jar!/”两种路径处理
                    String path = resource.getURI().toString();
                    String fileNameWithPackage = "";
                    if (path.indexOf("classes/") > -1) {
                        fileNameWithPackage = path.substring(path.indexOf("classes/") + 8,
                                path.length());

                    } else if (path.indexOf("jar!/") > -1) {
                        fileNameWithPackage = path.substring(path.indexOf("jar!/") + 5,
                                path.length());
                    }
                   
                    // 除掉后的zh_CN.properties后缀，因为直接用ResourceBundleMessageSource，是不用加后缀的
                    String fileNameBase = fileNameWithPackage.substring(0,
                            //fileNameWithPackage.indexOf("_"));
                    		 fileNameWithPackage.length()-17);
                    baseNameList.add(fileNameBase);

                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        String[] sovledBaseNames = baseNameList.toArray(new String[baseNameList.size()]);
        if (logger.isInfoEnabled()) {
            logger.info("Add Spring Message Resources properties file: "
                    + StringUtils.collectionToCommaDelimitedString(baseNameList));
        }
        this.resourceBundleMessageSource.setBasenames(sovledBaseNames);
    }

    public AbstractMessageSource getAbstractMessageSource() {
        return resourceBundleMessageSource;
    }

    // 取得属性对应的信息
    @Override
    public String getMessage(String key, Object[] params, String defaultMessage, Locale locale) {
    	try{
    		String message = this.resourceBundleMessageSource.getMessage(key, params, defaultMessage, locale);
    		if(StringUtils.isEmpty(message)) message=defaultMessage;
    		return message;
    	}catch(Exception e){
    		return key;
    	}
    }

    // 取得属性对应的信息
    @Override
    public String getMessage(String key, Object[] params, Locale locale) {
    	try{
    		String message = this.resourceBundleMessageSource.getMessage(key, params, locale);
    		if(StringUtils.isEmpty(message)) message=key;
    		return message;
    	}catch(Exception e){
    		return key;
    	}
    }

	@Override
	public String getMessage(MessageSourceResolvable messageSourceResolvable, Locale locale) throws NoSuchMessageException {

		String[] codes = messageSourceResolvable.getCodes();
		if (codes == null) {
			codes = new String[0];
		}
		for (String code : codes) {
			String msg = resourceBundleMessageSource.getMessage(code, messageSourceResolvable.getArguments(), locale);
			if (msg != null) {
				return msg;
			}
		}
		String defaultMessage = messageSourceResolvable.getDefaultMessage();
		if (defaultMessage != null) {
			return resourceBundleMessageSource.getMessage(defaultMessage, messageSourceResolvable.getArguments(), locale);
		}
		if (codes.length > 0) {
			String fallback = codes[0];
			if (fallback != null) {
				return fallback;
			}
		}
		throw new NoSuchMessageException(codes.length > 0 ? codes[codes.length - 1] : null, locale);
	}
	
	public static void main(String[] args) {
		String fileNameWithPackage="hb_data_en_US";
		System.out.println(fileNameWithPackage.substring(0, fileNameWithPackage.length()-6));
	}
}