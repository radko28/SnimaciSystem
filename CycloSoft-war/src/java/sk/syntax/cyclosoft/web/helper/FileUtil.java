/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.helper;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import javax.imageio.ImageIO;
import java.io.IOException;  
import java.io.InputStream;  
import java.util.Properties;  
import java.io.*;
import java.text.Normalizer;
import java.text.Normalizer.Form;



/**
 *
 * @author ext5201m
 */
public class FileUtil {
    private InputStream inputStream = null;
    private Properties properties = null;
public FileUtil() {
            inputStream = this.getClass().getClassLoader().getResourceAsStream("conf-war.properties");  
            properties = new Properties();  
            
}
    public static int[] pictureSize(byte[] imagedata) {
        int[] sizeXY = {0,0};
        if(imagedata != null) {
            System.out.println("FileUtil.imagedata");
            BufferedImage image = fromJPEG(imagedata);
            sizeXY[0] = image.getWidth(null);
            sizeXY[1] = image.getHeight(null);
        }
        return sizeXY;
    }
  private static BufferedImage fromJPEG( byte[] jpegBytes )
{
  BufferedImage result = null;

  ByteArrayInputStream bis= new ByteArrayInputStream( jpegBytes );

  try
  {
    result = ImageIO.read( bis );
  }
  catch ( Exception e )
  {
      e.printStackTrace(System.out);
  }
  finally
  {
    try
    {
 bis.close();
    }
    catch ( Exception e )
    {
        e.printStackTrace(System.out);
    }
  }

  return result;
}
  
    public String getResourceValue(String key) throws IOException {
        String result = key;
        try {
    
            properties.load(inputStream);  
            result = properties.getProperty(key);  
            System.out.println(key + " = " + result);
        } catch(IOException ioe) {
            ioe.printStackTrace(System.out);
        } finally {
            return result;            
        }
    }  
    
    
    public static String removeAccents(String text) {
        System.out.println("fileutil.text = " + text);
        String decomposed = Normalizer.normalize(text, Form.NFD);
        System.out.println("fileutil.decomposed = " + decomposed);
         String accentsGone = decomposed.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
         System.out.println("fileutil.accentsGone = " + accentsGone);
         return accentsGone;
    }    
    

}
