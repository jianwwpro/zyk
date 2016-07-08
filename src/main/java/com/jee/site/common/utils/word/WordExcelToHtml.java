package com.jee.site.common.utils.word;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.model.PicturesTable;
import org.apache.poi.hwpf.usermodel.CharacterRun;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Table;
import org.apache.poi.hwpf.usermodel.TableCell;
import org.apache.poi.hwpf.usermodel.TableIterator;
import org.apache.poi.hwpf.usermodel.TableRow;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.core.FileURIResolver;
import org.apache.poi.xwpf.converter.core.IURIResolver;
import org.apache.poi.xwpf.converter.xhtml.DefaultContentHandlerFactory;
import org.apache.poi.xwpf.converter.xhtml.IContentHandlerFactory;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;
import org.xml.sax.ContentHandler;

import com.jee.site.common.config.Global;

public class WordExcelToHtml {
	/** 
     * 回车符ASCII码 
     */  
    public static final short ENTER_ASCII = 13;  
  
    /** 
     * 空格符ASCII码 
     */  
    public static final short SPACE_ASCII = 32;  
  
    /** 
     * 水平制表符ASCII码 
     */  
    public static final short TABULATION_ASCII = 9; 
    
    
    /**
     * 图片存储位置
     */
    private static final String PIC_PATH="/ueditor/jsp/upload/image/";
    public  String htmlText = "";  
    public  String htmlTextTbl = "";  
    public  int counter=0;  
    public  int beginPosi=0;  
    public  int endPosi=0;  
    public  int beginArray[];  
    public  int endArray[];  
    public  String htmlTextArray[];  
    public  boolean tblExist=false;  
    public String imageUrl="";
    /** 
     * 读取每个文字样式 
     *  
     * @param fileName 
     * @throws Exception 
     */  
    public  String getWordAndStyle(String fileName) throws Exception {  
      return getWordAndStyle(new File(fileName));
    }
    public  String getWordAndStyle(File fileName) throws Exception {  
    	FileInputStream file = new FileInputStream(fileName);
    	String html = getWordAndStyle(file);
    	file.close();
    	return html;
    }
    
    public  String getWordAndStyle( FileInputStream in ) throws Exception {  
        POIFSFileSystem pfs = new POIFSFileSystem(in);
        HWPFDocument doc = new HWPFDocument(pfs); 
        return getWordAndStyle(doc);
    }
    
    /** 
     * 读取每个文字样式 
     *  
     * @param fileName 
     * @throws Exception 
     */  
    public  String getWordAndStyle(HWPFDocument doc) throws Exception {  
         Range rangetbl = doc.getRange();//得到文档的读取范围      
         TableIterator it = new TableIterator(rangetbl);   
         int num=100;          
          
           
         beginArray=new int[num];  
         endArray=new int[num];  
         htmlTextArray=new String[num];  
  
        // 取得文档中字符的总数   
        int length = doc.characterLength();  
        // 创建图片容器   
        PicturesTable pTable = doc.getPicturesTable();  
          
        htmlText = "";//"<html><head><title>" + doc.getSummaryInformation().getTitle() + "</title></head><body>";  
        // 创建临时字符串,好加以判断一串字符是否存在相同格式   
          
         if(it.hasNext())  
         {  
             readTable(it,rangetbl);  
         }  
           
         int cur=0;  
              
        String tempString = "";  
        for (int i = 0; i < length - 1; i++) {  
            // 整篇文章的字符通过一个个字符的来判断,range为得到文档的范围   
            Range range = new Range(i, i + 1, doc);  
              
              
              
            CharacterRun cr = range.getCharacterRun(0);   
            //beginArray=new int[num];   
             //endArray=new int[num];   
             //htmlTextArray=new String[num];   
            if(tblExist)  
            {  
                if(i==beginArray[cur])  
                {          
                    htmlText+=tempString+htmlTextArray[cur];  
                    tempString="";  
                    i=endArray[cur]-1;  
                    cur++;  
                    continue;  
                }  
            }  
            if (pTable.hasPicture(cr)) {  
                htmlText +=  tempString ;                 
                // 读写图片                
                readPicture(pTable, cr);  
                tempString = "";                  
            }   
            else {  
                          
                Range range2 = new Range(i + 1, i + 2, doc);  
                // 第二个字符   
                CharacterRun cr2 = range2.getCharacterRun(0);  
                char c = cr.text().charAt(0);  
                  
                //System.out.println(i+"::"+range.getEndOffset()+"::"+range.getStartOffset()+"::"+c);  
                  
                // 判断是否为回车符   
                if (c == ENTER_ASCII)  
                    {  
                    tempString += "<br/>";  
                      
                    }  
                // 判断是否为空格符   
                else if (c == SPACE_ASCII)  
                    tempString += " ";  
                // 判断是否为水平制表符   
                else if (c == TABULATION_ASCII)  
                    tempString += "    ";  
                // 比较前后2个字符是否具有相同的格式   
                boolean flag = compareCharStyle(cr, cr2);  
                if (flag)  
                    tempString += cr.text();  
                else {  
                    String fontStyle = "<span style='font-family:" + cr.getFontName() + ";font-size:" + cr.getFontSize() / 2 + "pt;'";  
                                      
                    if (cr.isBold())  
                        fontStyle += "font-weight:bold;";  
                    if (cr.isItalic())  
                        fontStyle += "font-style:italic;";  
                      
                    htmlText += fontStyle + ">" + tempString + cr.text() + "</span>";
                    tempString = "";  
                }  
            }  
        }  
  
        htmlText += tempString;//+"</body></html>"; 
        System.out.println(htmlText);
        return htmlText;
        //writeFile(htmlText);  
    }  
    
    /** 
     * word07转HTML 
     *  
     * @return 
     * @throws IOException 
     */  
    public String doGenerateHTMLFile(File f) throws IOException {
		return doGenerateHTMLFile(new FileInputStream(f));

	}
    /** 
     * word07转HTML 
     *  
     * @return 
     * @throws IOException 
     */  
    public String doGenerateHTMLFile(FileInputStream f) throws IOException {
		return doGenerateHTMLFile(new XWPFDocument(f));

	}
    /** 
     * word07转HTML 
     *  
     * @return 
     * @throws IOException 
     */  
    public String doGenerateHTMLFile(XWPFDocument document) throws IOException {  
    	Calendar now = Calendar.getInstance();  
    	String date_str = now.get(Calendar.YEAR)+ File.separator +(now.get(Calendar.MONTH) + 1)+ File.separator +now.get(Calendar.DAY_OF_MONTH);
        String path=Global.USERFILES_BASE_URL+File.separator+PIC_PATH +date_str;//显示存储路径
        
        String path_str=Global.getUserfilesBaseDir() +path + File.separator;//文件物理路径
        imageUrl=path+ File.separator;
        XHTMLOptions options = XHTMLOptions.create();// .indent( 4 );  
        IContentHandlerFactory f = new DefaultContentHandlerFactory();  
        // Extract image  
        options.setExtractor(new FileImageExtractor(new File(path_str)));//文件存储路径
        // URI resolver  
        options.URIResolver(new IURIResolver() {  
            @Override  
            public String resolve(String uri) {  
                return "/hbcms"+imageUrl + uri;//url路径
            }  
        });  
        ByteArrayOutputStream out = new ByteArrayOutputStream();  
        ContentHandler contentHandler = f.create(out, null, options);  
        XHTMLConverter.getInstance().convert(document, out, options);  
        out.close();  
        String html = out.toString();
        System.out.println(html);
        return html;
    } 
   
    public String convert2Html(File f) throws FileNotFoundException, TransformerException, IOException, ParserConfigurationException{
    	FileInputStream file = new FileInputStream(f);
    	String html = convert2Html(file);
    	file.close();
    	return html;
    }
    public String convert2Html(FileInputStream f) throws TransformerException, IOException, ParserConfigurationException{
    	POIFSFileSystem fp =new POIFSFileSystem(f); 
    	return convert2Html(fp);
    }
    
    private String convert2Html(POIFSFileSystem fss) throws TransformerException,  
	    IOException, ParserConfigurationException {  
	Calendar now = Calendar.getInstance();  
	String date_str = now.get(Calendar.YEAR)+ File.separator +(now.get(Calendar.MONTH) + 1)+ File.separator +now.get(Calendar.DAY_OF_MONTH);
    String path=Global.USERFILES_BASE_URL+File.separator+PIC_PATH +date_str;//显示存储路径
    
    String path_str=Global.getUserfilesBaseDir() +path + File.separator;//文件物理路径
    imageUrl=path+ File.separator;
	HWPFDocument wordDocument = new HWPFDocument(fss);  
	WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(  
	        DocumentBuilderFactory.newInstance().newDocumentBuilder()  
	                .newDocument());  
	wordToHtmlConverter.setPicturesManager(new PicturesManager() {  
	    public String savePicture(byte[] content, PictureType pictureType,  
	            String suggestedName, float widthInches, float heightInches) {  
	        return "/hbcms"+imageUrl + suggestedName;  
	    }  
	});  
	wordToHtmlConverter.processDocument(wordDocument);  
	// save pictures  
	List pics = wordDocument.getPicturesTable().getAllPictures();  
	if (pics != null) {  
	    for (int i = 0; i < pics.size(); i++) {  
	        Picture pic = (Picture) pics.get(i);  
	        try {  
	        	FileOutputStream fs = new FileOutputStream(path_str  
	                    + pic.suggestFullFileName());
	            pic.writeImageContent(fs); 
	            fs.close();
	        } catch (FileNotFoundException e) {  
	            e.printStackTrace();  
	        }  
	    }  
	}  
	Document htmlDocument = wordToHtmlConverter.getDocument();  
	ByteArrayOutputStream out = new ByteArrayOutputStream();  
	DOMSource domSource = new DOMSource(htmlDocument);  
	StreamResult streamResult = new StreamResult(out);  
	
	TransformerFactory tf = TransformerFactory.newInstance();  
	Transformer serializer = tf.newTransformer();  
	serializer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");  
	//serializer.setOutputProperty(OutputKeys.ENCODING, "GB2312");  
	serializer.setOutputProperty(OutputKeys.INDENT, "yes");  
	serializer.setOutputProperty(OutputKeys.METHOD, "html");  
	serializer.transform(domSource, streamResult);  
	out.close();  
	return out.toString();  
	
	}  
    /** 
     * 读写文档中的表格 
     *  
     * @param pTable 
     * @param cr 
     * @throws Exception 
     */  
    public  void readTable(TableIterator it, Range rangetbl) throws Exception {  
  
        htmlTextTbl="";  
        //迭代文档中的表格     
          
        counter=-1;  
        while (it.hasNext())   
        {   
            tblExist=true;  
             htmlTextTbl="";  
             Table tb = (Table) it.next();      
             beginPosi=tb.getStartOffset() ;  
             endPosi=tb.getEndOffset();  
               
            // System.out.println("............"+beginPosi+"...."+endPosi);  
             counter=counter+1;  
             //迭代行，默认从0开始   
             beginArray[counter]=beginPosi;  
             endArray[counter]=endPosi;  
               
             htmlTextTbl+="<table border>";  
             for (int i = 0; i < tb.numRows(); i++) {        
             TableRow tr = tb.getRow(i);     
               
             htmlTextTbl+="<tr>";  
             //迭代列，默认从0开始      
             for (int j = 0; j < tr.numCells(); j++) {        
                 TableCell td = tr.getCell(j);//取得单元格   
                 int cellWidth=td.getWidth();  
                   
                 //取得单元格的内容      
                 for(int k=0;k<td.numParagraphs();k++){        
                         Paragraph para =td.getParagraph(k);        
                         String s = para.text().toString().trim();     
                         if(s=="")  
                         {  
                             s=" ";  
                         }  
//                         System.out.println(s);     
                         htmlTextTbl += "<td width="+cellWidth+ ">"+s+"</td>";  
                         //System.out.println(i+":"+j+":"+cellWidth+":"+s);  
                    } //end for          
                 }   //end for      
              }   //end for      
            htmlTextTbl+="</table>" ;      
            htmlTextArray[counter]=htmlTextTbl;  
    
        } //end while    
    }     
      
    /** 
     * 读写文档中的图片 
     *  
     * @param pTable 
     * @param cr 
     * @throws Exception 
     */  
    public  void readPicture(PicturesTable pTable, CharacterRun cr) throws Exception {  
        // 提取图片   
        Picture pic = pTable.extractPicture(cr, false);  
        // 返回POI建议的图片文件名   
        String afileName = pic.suggestFullFileName();  
        Calendar now = Calendar.getInstance();  
    	String date_str = now.get(Calendar.YEAR)+ File.separator +(now.get(Calendar.MONTH) + 1)+ File.separator +now.get(Calendar.DAY_OF_MONTH);
        String path=Global.USERFILES_BASE_URL+File.separator+PIC_PATH +date_str;//显示存储路径
        
        String path_str=Global.getUserfilesBaseDir() +path;//文件物理路径
        
        String img = path_str+ File.separator + afileName;//文件
        
        File f = new File(path_str);
        
        if(!f.exists())f.mkdirs();
        
        OutputStream out = new FileOutputStream(new File(img));  
        
        pic.writeImageContent(out);  
        
        htmlText += "<img src='/hbcms" +path+File.separator + afileName + "' mce_src='/hbcms" +path+File.separator + afileName  + "'/>";   
    }  
  
    public  boolean compareCharStyle(CharacterRun cr1, CharacterRun cr2)   
    {  
        boolean flag = false;  
        if (cr1.isBold() == cr2.isBold() && cr1.isItalic() == cr2.isItalic() && cr1.getFontName().equals(cr2.getFontName()) && cr1.getFontSize() == cr2.getFontSize())   
        {  
            flag = true;  
        }  
        return flag;  
    }  
      
    
    /**
     * word转html
     * @param f
     * @return
     * @throws IOException
     * @throws TransformerException
     * @throws ParserConfigurationException
     */
  public static String wordTOHtml(File f) throws IOException, TransformerException, ParserConfigurationException{
	  String type = f.getName().substring(f.getName().indexOf("."));//
	  String html="";
		WordExcelToHtml wh = new WordExcelToHtml();

      if(type.endsWith(".doc")){
    	  try {
				html = wh.convert2Html(f);
			} catch (Exception e) {
					html=wh.doGenerateHTMLFile(f);
			}
      }else if(type.endsWith(".docx")){
      	try {
				html=wh.doGenerateHTMLFile(f);
			} catch (IOException e) {
					html=wh.convert2Html(f);
			}
      }
      return html;
  }
    
    
    

    /** 
     * 写文件 
     *  
     * @param s 
     */  
    public  void writeFile(String s) {  
        FileOutputStream fos = null;  
        BufferedWriter bw = null;  
        try {  
            File file = new File("/Users/fct/Desktop/abc.html");  
            fos = new FileOutputStream(file);  
            bw = new BufferedWriter(new OutputStreamWriter(fos));  
            bw.write(s);  
        } catch (FileNotFoundException fnfe) {  
            fnfe.printStackTrace();  
        } catch (IOException ioe) {  
            ioe.printStackTrace();  
        } finally {  
            try {  
                if (bw != null)  
                    bw.close();  
                if (fos != null)  
                    fos.close();  
            } catch (IOException ie) {  
            }  
        }  
    }
}
