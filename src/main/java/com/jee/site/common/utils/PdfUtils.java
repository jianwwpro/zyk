package com.jee.site.common.utils;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;

public final  class PdfUtils {

	public PdfUtils() {
		// TODO Auto-generated constructor stub
	}
	
	
	public static void createPdfPic(String filePath,boolean isMultiplePic) throws Exception{
  	  // 生成图片
		
		try{
			  PDDocument pd = PDDocument.load(new File(filePath));
		      
		      PDFRenderer pdfRenderer = new PDFRenderer(pd);
		      BufferedImage combined = null;
		      for (int page = 0; page < pd.getNumberOfPages(); ++page)
		      {
		          BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 200, ImageType.RGB);
		          if(isMultiplePic){
		        	 String saveDir= filePath.substring(0, filePath.indexOf(".")>0?filePath.indexOf("."):filePath.length());
		        	File saveFile = new  File(saveDir);
		        	if(!saveFile.exists()) saveFile.mkdirs();
		        	  ImageIOUtil.writeImage(bim, saveFile.getAbsolutePath() +"/"+(page+1)+ ".png", 200);
		          }else{
		        	  if (page == 0) {
		        		  combined = bim;
		        	  } else {
		        		  combined = merge(combined, bim);
		        	  }
		          }
		      }
		      if(!isMultiplePic){
		    	  ImageIOUtil.writeImage(combined, filePath + ".png", 200);
		      }
		      pd.close();
		}catch(Exception e){
			throw new Exception(e);
		}
    
	}
	
	
	 private static BufferedImage merge(BufferedImage image1, BufferedImage image2) {
	        BufferedImage combined = new BufferedImage(
	                image1.getWidth(),
	                image1.getHeight() + image2.getHeight(),
	                BufferedImage.TYPE_INT_RGB);

	        Graphics g = combined.getGraphics();
	        g.drawImage(image1, 0, 0, null);
	        g.drawImage(image2, 0, image1.getHeight(), null);
	        g.dispose();
	        return combined;
	    }

}
