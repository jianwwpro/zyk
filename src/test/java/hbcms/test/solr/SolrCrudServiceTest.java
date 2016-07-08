package hbcms.test.solr;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.junit.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Field;
import org.springframework.data.solr.core.query.HighlightOptions;
import org.springframework.data.solr.core.query.SimpleHighlightQuery;
import org.springframework.data.solr.core.query.SimpleStringCriteria;
import org.springframework.data.solr.core.query.SolrPageRequest;
import org.springframework.data.solr.core.query.result.FacetFieldEntry;
import org.springframework.data.solr.core.query.result.FacetPage;
import org.springframework.data.solr.core.query.result.FacetQueryEntry;
import org.springframework.data.solr.core.query.result.HighlightEntry;
import org.springframework.data.solr.core.query.result.HighlightEntry.Highlight;
import org.springframework.data.solr.core.query.result.HighlightPage;
import org.springframework.data.solr.core.query.result.SolrResultPage;
import org.springframework.data.solr.server.SolrServerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.TransactionConfiguration;

import com.jee.site.modules.hb.entity.HbArticle;
import com.jee.site.modules.hb.entity.HbData;
import com.jee.site.modules.hb.entity.HbJournal;
import com.jee.site.modules.hb.solr.ArticleRepository;
import com.jee.site.modules.hb.solr.cores.ArticleCore;

import hbcms.test.AbstractTransactionalTests;

@ContextConfiguration(locations = {"/spring-context-solr-data.xml"})
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback=false)
public class SolrCrudServiceTest extends AbstractTransactionalTests{


	
	@Autowired
	ArticleRepository articleRepository;

	
	
	
	
	@Test
	public void testRes(){
		HbArticle entity=new HbArticle();
			HbData data=new HbData();
			HbJournal journal=new HbJournal();
			journal.setId("sdfa");
			entity.setJournal(journal);
			entity.setKeyword("sdfas");
			entity.setSubtitle("sdfa");
			entity.setIntroduction("sdfas");
			data.setContent("ajfsdjflsajldfjlasdfjalsjfdlajsfldj");
			entity.setId("51542");
			entity.setTitle("sdcc");
			entity.setCreateUser("sdfasdf");
			entity.setUpdateDate(new Date());
			entity.setArticleData(data);
			entity.setTitle("123");
			entity.setId("sdfasdf");
			ArticleCore article=new ArticleCore();
			BeanUtils.copyProperties(entity, article);
			articleRepository.save(article);
		Iterable<ArticleCore> findAll = articleRepository.findById("sdfasdf");
		for(ArticleCore item:findAll){
			System.out.println(item.getId());
		}
		//articleRepository.deleteAll();
		System.out.println(21);
	}
	
	@Test
	public void testClearAll(){
		articleRepository.deleteAll();
	}
	
	
	@Test
	public void testInsert(){
		ArticleCore article=new ArticleCore();
		article.setTitle("水电费");
		article.setKeyword("电视 空体贴 空调");
		articleRepository.save(article);
	}
	
	@Test
	public void testFind(){
	/*	List<ArticleCore> findByKeyword = articleRepository.findByKeywordQueryAnnotation("电视");
		for(ArticleCore item:findByKeyword){
			System.out.println(item.getId()+":"+item.getKeyword()+":"+item.getTitle());
		}*/
	}
	
	@Resource(name="solrClientFactory")
	private SolrServerFactory solrServerFactory;
	@Test
	public void testHight(){
		SimpleHighlightQuery query=new SimpleHighlightQuery(new SimpleStringCriteria("title:keyword"));
		query.setHighlightOptions(new HighlightOptions());
		SolrTemplate solrTemplate = new SolrTemplate(solrServerFactory.getSolrServer("article"));
		HighlightPage<ArticleCore> queryForHighlightPage = solrTemplate.queryForHighlightPage(query, ArticleCore.class);
		for(ArticleCore item:queryForHighlightPage){
			System.out.println(item.getId()+":"+item.getKeyword()+":"+item.getTitle());
		}
	}
	
	@Test
	public void testFindList(){
		List<ArticleCore> findByKeyword = articleRepository.findByKeywordQueryAnnotation(new String[]{"中华","历史"});
		for(ArticleCore item:findByKeyword){
			System.out.println(item.getId()+":"+item.getKeyword()+":"+item.getTitle());
		}
	}
	
	@Test
	public void testFindNoBy(){
		SolrPageRequest page=new SolrPageRequest(1, 20);
		FacetPage<ArticleCore> findKeyword = articleRepository.findKeywordFacetOnKeyword("*",page);
		List<ArticleCore> contentList = findKeyword.getContent();
		for(ArticleCore item:contentList){
			System.out.println(item.getTitle());
		}
		System.out.println(findKeyword.getTotalElements());
		Collection<Page<FacetFieldEntry>> facetResultPages = findKeyword.getFacetResultPages();
		
		for(Page<FacetFieldEntry> item:facetResultPages){
			List<FacetFieldEntry> content = item.getContent();
			for(FacetFieldEntry item2:content){
				Field key = item2.getKey();
				System.out.println(item2.getValue());
			}
		}
	}
	
	
	@Test
	public void testSolrImpl(){
		HighlightPage<ArticleCore> search = articleRepository.search("中华 历史",new SolrPageRequest(0, 10));
	
		for(ArticleCore item:search.getContent()){
			List<Highlight> highlights = search.getHighlights(item);
			for(Highlight item2:highlights){
				System.out.println(item2.getField().getName()+"====="+item2.getSnipplets());
			}
			
			System.out.println("");
			System.out.println("");
			System.out.println("");
			System.out.println("");
			System.out.println("");
		}
		
	}

}
