package com.jee.site.common.utils.word;


import java.awt.Color;  
import java.awt.Dimension;  
import java.awt.Graphics2D;  
import java.awt.RenderingHints;  
import java.awt.image.BufferedImage;  
import java.io.BufferedWriter;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.FileWriter;  
import java.io.IOException;  
import java.io.OutputStreamWriter;  
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;  
  



import javax.xml.parsers.DocumentBuilder;  
import javax.xml.parsers.DocumentBuilderFactory;  
import javax.xml.parsers.ParserConfigurationException;  
import javax.xml.transform.OutputKeys;  
import javax.xml.transform.Transformer;  
import javax.xml.transform.TransformerException;  
import javax.xml.transform.TransformerFactory;  
import javax.xml.transform.dom.DOMSource;  
import javax.xml.transform.stream.StreamResult;  
  



import org.apache.commons.io.output.ByteArrayOutputStream;  
import org.apache.commons.lang3.StringUtils;  
import org.apache.poi.hslf.model.TextRun;  
import org.apache.poi.hslf.usermodel.RichTextRun;  
import org.apache.poi.hslf.usermodel.SlideShow;  
import org.apache.poi.hwpf.HWPFDocument;  
import org.apache.poi.hwpf.converter.HtmlDocumentFacade;  
import org.apache.poi.hwpf.converter.PicturesManager;  
import org.apache.poi.hwpf.converter.WordToHtmlConverter;  
import org.apache.poi.hwpf.usermodel.Picture;  
import org.apache.poi.hwpf.usermodel.PictureType;  
import org.apache.poi.poifs.filesystem.POIFSFileSystem;  
import org.apache.poi.xwpf.converter.core.FileImageExtractor;  
import org.apache.poi.xwpf.converter.core.IURIResolver;  
import org.apache.poi.xwpf.converter.xhtml.DefaultContentHandlerFactory;  
import org.apache.poi.xwpf.converter.xhtml.IContentHandlerFactory;  
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;  
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;  
import org.apache.poi.xwpf.usermodel.XWPFDocument;  
import org.w3c.dom.Document;  
import org.w3c.dom.Element;  
import org.xml.sax.ContentHandler;  
  
public class OfficeTool {  
    private String path;        //文件路径  
    private String imageSavePath;   //图片保存保存路径  
    private String imageUrl;    //图片 src属性  
    private String output;  
    private HtmlDocumentFacade htmlDocumentFacade;  
    private Element window;  
    private Element topbar;  
    private Element info;  
    private Element outline;  
    private Element page;  
    private Element ul;  
  
    public OfficeTool(File file) {  
        this.path = file.getAbsolutePath();  
        String filename = this.getFileName(path, false);  
        this.imageSavePath = file.getParentFile().getAbsolutePath() + "/"  
                + filename + "_img/";  
        this.imageUrl = this.imageSavePath.replaceAll("([D][:])*[/|\\\\]+", "/");  
        System.out.println(imageUrl);  
        this.output = file.getParentFile().getAbsolutePath() + "/" + filename + ".html";  
        new File(this.imageSavePath).mkdirs();  
    }  
  
    public OfficeTool(String path, String imageSavePath, String imageUrl) {  
        this.path = path;  
        this.imageSavePath = imageSavePath;  
        this.imageUrl = imageUrl;  
        File imFile = new File(imageSavePath);  
        imFile.mkdirs();  
    }  
  
    public OfficeTool(String path, String imageSavePath, String imageUrl,  
            String output) {  
        this.path = path;  
        this.imageSavePath = imageSavePath;  
        this.imageUrl = imageUrl;  
        this.output = output;  
        File imFile = new File(imageSavePath);  
        imFile.mkdirs();  
    }  
  
    public static void main(String[] args) throws UnsupportedEncodingException, IOException {
    	File file = new File("/Users/fct/Desktop/版权管理----升级-V0.2.docx");
    	File file1 = new File("/Users/fct/Downloads/Activiti_5.14_中文用户手册.doc");
    	OfficeTool off=new OfficeTool(file);
		OfficeTool off1=new OfficeTool(file1);
		//System.out.println(off.doGenerateHTMLFile());
		System.out.println(off1.get03Html());
	}
    public String get03Html() {  
        String html = "";  
        try {  
            html = convert2Html(path);  
        } catch (TransformerException | IOException  
                | ParserConfigurationException e) {  
            e.printStackTrace();  
        }  
        return html;  
    }  
  
    public String get07Html() {  
        String html = "";  
        try {  
            html = this.doGenerateHTMLFile();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return html;  
    }  
      
    public String getPPTHtml(){  
        String html = "";  
        try {  
            this.convert(this.path, this.output);  
//            html = MyFileUtils.fileToString(output,"UTF-8");  
//            html = MyFileUtils.fileToString(output,"GB2312");  
        } catch (IOException | TransformerException e) {  
            e.printStackTrace();  
        }  
        return html;  
    }  
  
    public String save03AsHtml(String content) {  
        this.writeFile(content, output);  
        return output;  
    }  
  
    public String save07AsHtml(String content) {  
        this.writeFile(content, output);  
        return output;  
    }  
  
    private void writeFile(String content, String path) {  
        try (FileOutputStream fos = new FileOutputStream(new File(path));  
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos, "UTF-8"))){  
    //      bw = new BufferedWriter(new OutputStreamWriter(fos, "UTF-8"));  
            bw.write(content);  
        } catch (IOException ioe) {  
            ioe.printStackTrace();  
        }   
    }  
    private String convert2Html(String f) throws FileNotFoundException, TransformerException, IOException, ParserConfigurationException{
    	return convert2Html(new File(f));
    }
    private String convert2Html(File f) throws FileNotFoundException, TransformerException, IOException, ParserConfigurationException{
    	return convert2Html(new FileInputStream(f));
    }
    private String convert2Html(FileInputStream f) throws TransformerException, IOException, ParserConfigurationException{
    	return convert2Html(new POIFSFileSystem(f));
    }
    private String convert2Html(POIFSFileSystem fss) throws TransformerException,  
            IOException, ParserConfigurationException {  
        HWPFDocument wordDocument = new HWPFDocument(fss);  
        WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(  
                DocumentBuilderFactory.newInstance().newDocumentBuilder()  
                        .newDocument());  
        wordToHtmlConverter.setPicturesManager(new PicturesManager() {  
            public String savePicture(byte[] content, PictureType pictureType,  
                    String suggestedName, float widthInches, float heightInches) {  
                return imageUrl + suggestedName;  
            }  
        });  
        wordToHtmlConverter.processDocument(wordDocument);  
        // save pictures  
        List pics = wordDocument.getPicturesTable().getAllPictures();  
        if (pics != null) {  
            for (int i = 0; i < pics.size(); i++) {  
                Picture pic = (Picture) pics.get(i);  
                try {  
                    pic.writeImageContent(new FileOutputStream(imageSavePath  
                            + pic.suggestFullFileName()));  
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
//        serializer.setOutputProperty(OutputKeys.ENCODING, "GB2312");  
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");  
        serializer.setOutputProperty(OutputKeys.METHOD, "html");  
        serializer.transform(domSource, streamResult);  
        out.close();  
        return out.toString();  
  
    }  
  
    /** 
     * word07转HTML 
     *  
     * @return 
     * @throws IOException 
     */  
    private String doGenerateHTMLFile() throws IOException {  
  
        XWPFDocument document = new XWPFDocument(new FileInputStream(new File(  
                path)));  
  
        XHTMLOptions options = XHTMLOptions.create();// .indent( 4 );  
        IContentHandlerFactory f = new DefaultContentHandlerFactory();  
        // Extract image  
        options.setExtractor(new FileImageExtractor(new File(imageSavePath)));  
        // URI resolver  
        options.URIResolver(new IURIResolver() {  
            @Override  
            public String resolve(String uri) {  
                return imageUrl + uri;  
            }  
        });  
        ByteArrayOutputStream out = new ByteArrayOutputStream();  
        ContentHandler contentHandler = f.create(out, null, options);  
        XHTMLConverter.getInstance().convert(document, out, options);  
        out.close();
        String gbkStr = new String(out.toString().getBytes("ISO8859-1"), "UTF-8"); 
        return gbkStr;  
    }  
      
      
    /** 
     * PPT to HTML 
     * @param filePath   PPT file path 
     * @param output    html file path 
     * @throws IOException 
     * @throws TransformerException 
     */  
    public void convert(String filePath, String output) throws IOException,  
            TransformerException {  
        this.init();  
        File pptFile = new File(filePath);  
        if (!isPPt(pptFile)) {  
            return;  
        }  
        try {  
            process(pptFile, output);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
  
        saveAsHtml(output, htmlDocumentFacade.getDocument());  
    }  
  
    /** 
     * convert ppt to '.png' file and generate '.html' code. 
     *  
     * @param pptFile 
     * @param output 
     *            , html save path; 
     * @throws Exception 
     */  
    private void process(File pptFile, String output) throws Exception {  
        FileInputStream is = new FileInputStream(pptFile);  
        SlideShow ppt = new SlideShow(is);  
        is.close();  
        Dimension pgsize = ppt.getPageSize();  
        org.apache.poi.hslf.model.Slide[] slide = ppt.getSlides();  
        this.info.appendChild(this.htmlDocumentFacade.createText(this  
                .getFileName(pptFile.getPath(), true)));  
        for (int i = 0; i < slide.length; i++) {  
  
            addSlideTitle(slide[i]);  
  
            TextRun[] truns = slide[i].getTextRuns();  
            for (int k = 0; k < truns.length; k++) {  
  
                RichTextRun[] richTexts = truns[k].getRichTextRuns();  
                for (int l = 0; l < richTexts.length; l++) {  
  
                    String fontName = richTexts[l].getFontName();  
                    // rtruns[l].setFontIndex(1);  
                    // System.out.println(fontName);  
                    // POI bug？？？  
                    if (isTrueType(fontName))  
                        richTexts[l].setFontName("宋体");  
                    else  
                        richTexts[l].setFontName(fontName);  
                }  
            }  
            BufferedImage img = new BufferedImage(pgsize.width, pgsize.height,  
                    BufferedImage.TYPE_INT_RGB);  
            Graphics2D graphics = img.createGraphics();  
  
            graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING,  
                    RenderingHints.VALUE_ANTIALIAS_ON);  
            graphics.setRenderingHint(RenderingHints.KEY_RENDERING,  
                    RenderingHints.VALUE_RENDER_QUALITY);  
            graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION,  
                    RenderingHints.VALUE_INTERPOLATION_BICUBIC);  
            graphics.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS,  
                    RenderingHints.VALUE_FRACTIONALMETRICS_ON);  
  
            graphics.setColor(Color.white);  
            graphics.clearRect(0, 0, pgsize.width, pgsize.height);  
  
            slide[i].draw(graphics);  
            // String imgName = StringUtil.getFileName(pptFile.getPath(),false)  
            // + "_" + (i + 1) + ".png";  
            String imgName = getFileName(pptFile.getPath(), false) + "_"  
                    + (i + 1) + ".png";  
            // String imgPath = StringUtil.getFilePath(output) + "/images/";  
            String imgPath = this.imageSavePath;  
            if (i == 0) {  
                new File(imgPath).mkdir();  
            }  
            FileOutputStream out = new FileOutputStream(imgPath + imgName);  
            javax.imageio.ImageIO.write(img, "png", out);  
            out.close();  
  
            addSlide(imageUrl + imgName, slide[i].getSlideNumber());  
  
        }  
    }  
  
    /** 
     * generate outline; 
     *  
     * @param slide 
     */  
    private void addSlideTitle(org.apache.poi.hslf.model.Slide slide) {  
  
        String title = StringUtils.isBlank(slide.getTitle()) ? slide  
                .getSlideNumber() + ": Untitled" : slide.getSlideNumber()  
                + ": " + slide.getTitle();  
  
        Element list = htmlDocumentFacade.createListItem();  
  
        Element a = htmlDocumentFacade.createHyperlink("#link"  
                + slide.getSlideNumber());  
        // a.setTextContent(title);  
        a.appendChild(htmlDocumentFacade.createText(title));  
        // a.setNodeValue(title);  
        list.appendChild(a);  
        this.ul.appendChild(list);  
    }  
  
    /** 
     * generate slide, block style 
     *  
     * @param imagePath 
     * @param index 
     */  
    private void addSlide(String imagePath, int index) {  
        Element slideBlock = htmlDocumentFacade.createBlock();  
        slideBlock.setAttribute("class", "slide");  
        // anchor　pointer  
        Element link = htmlDocumentFacade.createBookmark("link" + index);  
  
        Element img = htmlDocumentFacade.createImage(imagePath);  
        // img.setAttribute("style", "position:relative;top:15%;");  
  
        slideBlock.appendChild(link);  
        slideBlock.appendChild(img);  
  
        this.page.appendChild(slideBlock);  
  
    }  
  
    private void init() {  
        try {  
  
            // build document  
            DocumentBuilder builder = DocumentBuilderFactory.newInstance()  
                    .newDocumentBuilder();  
            // DOMImplementation domImpl = builder.getDOMImplementation();  
            // DocumentType doctype = domImpl.createDocumentType("",  
            // "-//W3C//DTD HTML 4.01 Transitional//EN",  
            // "http://www.w3.org/TR/html4/strict.dtd");  
            // Document document = domImpl.createDocument(null, null, doctype);  
            Document document = builder.newDocument();  
  
            htmlDocumentFacade = new HtmlDocumentFacade(document);  
  
            // glob layout  
            window = htmlDocumentFacade.createBlock();  
            window.setAttribute("id", "window");  
            info = htmlDocumentFacade.createBlock();  
            info.setAttribute("id", "info");  
            outline = htmlDocumentFacade.createBlock();  
            outline.setAttribute("id", "outline");  
            page = htmlDocumentFacade.createBlock();  
            page.setAttribute("id", "page");  
  
            // outline layout  
            ul = htmlDocumentFacade.createUnorderedList();  
            outline.appendChild(ul);  
  
            window.appendChild(info);  
            window.appendChild(outline);  
            window.appendChild(page);  
  
            htmlDocumentFacade.getBody().appendChild(window);  
  
            /* 
             * DocumentType docType = 
             * htmlDocumentFacade.getDocument().getDoctype(); 
             *  
             * System.out.println("docType :    -------  " + docType); 
             */  
  
            setCommonStyle(htmlDocumentFacade.getDocument());  
  
        } catch (ParserConfigurationException e) {  
            e.printStackTrace();  
        }  
    }  
  
    private void saveAsHtml(String output, org.w3c.dom.Document document)  
            throws IOException, TransformerException {  
        FileWriter out = new FileWriter(output);  
        DOMSource domSource = new DOMSource(document);  
        StreamResult streamResult = new StreamResult(out);  
  
        TransformerFactory tf = TransformerFactory.newInstance();  
        Transformer serializer = tf.newTransformer();  
        // TODO set encoding from a command argument  
        serializer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");  
        //serializer.setOutputProperty(OutputKeys.ENCODING, "GB2312");  
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");  
        serializer.setOutputProperty(OutputKeys.METHOD, "html");  
        serializer.setOutputProperty(OutputKeys.STANDALONE, "yes");  
        serializer.setOutputProperty(OutputKeys.DOCTYPE_PUBLIC,  
                "-//W3C//DTD HTML 4.01 Transitional//EN"); //  
        serializer.setOutputProperty(OutputKeys.DOCTYPE_SYSTEM,  
                "http://www.w3.org/TR/html4/strict.dtd");  
  
        serializer.transform(domSource, streamResult);  
        out.close();  
    }  
  
    private static boolean isPPt(File file) {  
        if (!file.canRead())  
            return false;  
        int sep = file.getPath().lastIndexOf(".");  
        if ("ppt".equals(file.getPath().substring(sep + 1,  
                file.getPath().length())))  
            return true;  
  
        return false;  
    }  
  
    public static boolean isTrueType(String fontName) {  
        String[] trueType = new String[] { "Tahoma", "Times New Roman",  
                "Calibri", "Arial" };  
        for (String type : trueType) {  
            if (type.equals(fontName))  
                return true;  
        }  
        return false;  
    }  
  
    private void setCommonStyle(Document document) {  
        Element styleSheet = (Element) document.getElementsByTagName("style")  
                .item(0);  
        if (styleSheet == null)  
            return;  
  
        String sep = "\n";  
  
        StringBuffer sb = new StringBuffer();  
        sb.append(sep);  
        sb.append("html{height: 100%;overflow-y:hidden;}");  
        sb.append(sep);  
        sb.append("body{height:100%;overflow-y: hidden;margin:0; background:#bdc2cd}");  
        sb.append(sep);  
        sb.append("#window{min-width: 800px;height:100%;}");  
        sb.append(sep);  
        // sb.append("#topbar{min-height:24px;}");  
        // sb.append(sep);  
        sb.append("#info{font-size: 24px;font-weight: 800;border-bottom:2px solid gray;height:5%; background:#eee;padding-left:5px;}");  
        sb.append(sep);  
        sb.append("#outline{float:left;height:95%;width:20%;overflow-y: auto; overflow-x:hidden;background:#fff; "  
                + "margin-right:3%; -moz-box-shadow: 4px 4px 12px #2b2b2b;-webkit-box-shadow: 4px 4px 12px #2b2b2b;"  
                + "box-shadow: 4px 4px 12px #2b2b2b;}");  
        sb.append(sep);  
        sb.append("#outline ul li {list-style:none;line-height: 25px;}");  
        sb.append(sep);  
        sb.append("#outline ul li a{text-decoration:none;white-space:nowrap;text-overflow:ellipsis;}");  
        sb.append(sep);  
        sb.append("#page{float:left;overflow-y: auto;overflow-x:hidden;height:95%;width:77%;margin-right:-20%;background:#bdc2cd; text-align:center;}");  
        sb.append(sep);  
        sb.append("#page div{width:100%;height:100%;}");  
        sb.append(sep);  
        // styleSheet.setNodeValue(sb.toString());  
        // styleSheet.setTextContent(sb.toString());  
        styleSheet.appendChild(document.createTextNode(sb.toString()));  
  
    }  
  
    private String getFileName(String path, boolean issuffix) {  
        String name = "";  
        int index = path.lastIndexOf("/") == -1 ? path.lastIndexOf("\\") : path  
                .lastIndexOf("/");  
        if (StringUtils.isNotBlank(path)) {  
            if (issuffix) {  
                name = path.substring(index + 1);  
            } else {  
                name = path.substring(index + 1, path.lastIndexOf("."));  
            }  
        }  
        return name;  
    }  
  
    private String getFilePath(String path) {  
        String p = "";  
        int index = path.lastIndexOf("/") == -1 ? path.lastIndexOf("\\") : path  
                .lastIndexOf("/");  
        if (StringUtils.isNotBlank(path)) {  
            p = path.substring(0, index);  
        }  
        return p;  
    }  
  
}  