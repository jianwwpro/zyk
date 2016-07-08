package com.jee.site.common.utils.pdf;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

public class PdfUtils {

	
	
	public static void createPdfWithImage(List<File> files) throws IOException{
		PDDocument document = new PDDocument();  
		try {  
        PDPage page = new PDPage();  
        document.addPage(page);  
          
//      PDFont font = PDTrueTypeFont.loadTTF(document, new File("SIMSUN.TTC"));  
        PDFont font = PDType1Font.HELVETICA_BOLD;  
          
        PDPageContentStream contentStream = new PDPageContentStream(document, page);  
//        contentStream.append
//          
//        contentStream.close();  
          
            document.save("E:/test.pdf");  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        document.close();  
	}
}
