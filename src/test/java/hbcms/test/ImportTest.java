package hbcms.test;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.junit.Test;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.TransactionConfiguration;

import com.alibaba.druid.support.json.JSONUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jee.site.common.utils.StringUtils;
import com.jee.site.common.utils.excel.ImportExcel;

@ContextConfiguration(locations = {"/spring-context-solr-data.xml"})
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback=false)
public class ImportTest extends AbstractTransactionalTests{

	public ImportTest() {
		// TODO Auto-generated constructor stub
	}
	
	
	@Test
	public void test() throws InvalidFormatException, IOException{
		
		ImportExcel importExcel = new ImportExcel(new File("D:/tmp/nationality副本.xlsx"), 0,0);
		
		int dataRowNum = importExcel.getDataRowNum();
		for(int i=0;i<dataRowNum;i++){
			Object cellValue = importExcel.getCellValue(importExcel.getRow(i), 1);
			System.out.println(cellValue);
		}
		
	}
	
	public static void main(String[] args) throws InvalidFormatException, IOException {
	ImportExcel importExcel = new ImportExcel(new File("D:/tmp/nationality副本.xlsx"), 2,0);
		List<Map<String,Object>> list=Lists.newArrayList();
		int dataRowNum = importExcel.getLastDataRowNum();
		for(int i=1;i<dataRowNum;i++){
			String cellValue = (String) importExcel.getCellValue(importExcel.getRow(i), 2);
			if(StringUtils.isNotEmpty(cellValue)){
				
				Map<String,Object> map=Maps.newHashMap();
				map.put("id", i);
				map.put("name",cellValue);
				list.add(map);
			}
		}
		String jsonString = JSONUtils.toJSONString(list);
		System.out.println(jsonString);
	}

}
