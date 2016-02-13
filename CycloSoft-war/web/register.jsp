<%-- 
    Document   : register
    Created on : Mar 27, 2008, 12:31:54 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.web.bean.AddressServiceJavabean,
                 java.util.List,
                 java.lang.String,
                 sk.syntax.cyclosoft.web.helper.Validation,
                 sk.syntax.cyclosoft.web.helper.FileUtil,
                 java.util.Map,
                 java.util.HashMap,
                 sk.syntax.cyclosoft.domain.Address,
                 java.util.*,
                 java.io.File,
                 org.apache.commons.fileupload.servlet.ServletFileUpload,
                 org.apache.commons.fileupload.disk.DiskFileItemFactory,
                 org.apache.commons.fileupload.*,
                 org.apache.commons.io.FilenameUtils,
                 java.lang.Exception
                 "%>
        <% 
        out.print("<div align = center><h2>Register</h2>");
        FileUtil fileUtil = new FileUtil();
      if(session.getAttribute("email") == null) {
            Map<String,String> validCss = new HashMap();  
            Map<String,String> validMsg = new HashMap();              
            validMsg.put("email", "");
            validMsg.put("password", "");
            validMsg.put("firstname", "");
            validMsg.put("surname", "");
            validMsg.put("mobil", "");
            validMsg.put("city", "");
            validMsg.put("street", "");
            validMsg.put("zip", "");
            validMsg.put("pic", "");
            validMsg.put("web", "");
            
            String register = "";
            String email = "";
            String password = "";
            String firstnameView = "";
            byte[] firstname = null;            
            String surnameView = "";            
            byte[] surname = null;
            String mobil = "";
            String streetView = "";
            String cityView = "";
            byte[] street = null;
            byte[] city = null;
            String zip = "";
            String web = "";
            String picContentType = "";
            long picSize = 0;
            String picName = "";
            FileItem picFileItem = null;
            byte[] imagedata = null;
               String encoding = request.getCharacterEncoding();
            System.out.print("regiater.encoding = " +encoding);               
			if ( encoding == null ) {
				encoding = "UTF-8" ;
			}
            System.out.print("register.encoding = " +encoding);               
           if(ServletFileUpload.isMultipartContent(request)) {

                System.out.print("register.ServletFileUpload.isMultipartContent" );
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()){
                    FileItem fileItemTemp = (FileItem)it.next();
                    if (fileItemTemp.isFormField()){
                        if (fileItemTemp.getFieldName().equals("register"))
                            register = fileItemTemp.getString();
                        if (fileItemTemp.getFieldName().equals("email"))
                            email = fileItemTemp.getString();
                        if (fileItemTemp.getFieldName().equals("password"))
                            password = fileItemTemp.getString();
                        if (fileItemTemp.getFieldName().equals("firstname")) {
                            firstnameView = fileItemTemp.getString(encoding);
                            firstname = fileItemTemp.get();
                        }
                        if (fileItemTemp.getFieldName().equals("surname")) {
                            surnameView = fileItemTemp.getString(encoding);
                            surname = fileItemTemp.get();
                        }    
                        if (fileItemTemp.getFieldName().equals("mobil"))
                            mobil = fileItemTemp.getString();
                        if (fileItemTemp.getFieldName().equals("street")) {
                            streetView = fileItemTemp.getString(encoding);
                            street = fileItemTemp.get();
                        }
                        if (fileItemTemp.getFieldName().equals("city")) {
                            cityView = fileItemTemp.getString(encoding);
                            city = fileItemTemp.get();
                        }    
                        if (fileItemTemp.getFieldName().equals("zip"))
                            zip = fileItemTemp.getString();
                        if (fileItemTemp.getFieldName().equals("web"))
                            web = fileItemTemp.getString();
                    } else {
                       System.out.print("picture" );
                        picContentType = fileItemTemp.getContentType();
                        picSize = fileItemTemp.getSize();
                        picFileItem = fileItemTemp;
                        imagedata = fileItemTemp.get();
                        if (picFileItem!=null)
                             picName = picFileItem.getName();
                     }
                 }
            }

            boolean isRegister = false;
            boolean isRegisterMin = true;
            AddressJavabean addressJavabean = new AddressJavabean();        
            if(register !=null && register.length() > 0 && register.equals("submit")) {
//validacia
           
                
                if(email != null && email.length() > 0 && Validation.validateRegex(email, "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[_A-Za-z0-9-]+)")) 
                    if(addressJavabean.getAddress(email) == null) {
                        isRegister = true;                    
                    } else {
                        isRegister = false;
                        validCss.put("email", "class=error");
                        validMsg.put("email", fileUtil.getResourceValue("register.email.exist"));
                    }
                else {
                        isRegister = false;
                        validCss.put("email", "class=error");
                        validMsg.put("email", fileUtil.getResourceValue("register.email"));
                }
                 System.out.println("addressJavabean.register.email isRegister = " + isRegister);                                        
                
                if(password != null &&  Validation.validateRegex(password, "\\w{6,16}")) {
                    isRegister = isRegister && true;                    
                } else {
                    isRegister = isRegister && false;
                    validCss.put("password", "class=error");
                    validMsg.put("password", fileUtil.getResourceValue("register.password"));                    
                }
                    System.out.println("addressJavabean.register.password isRegister = " + isRegister);                                            
                if(firstname != null &&  Validation.validateRegex(FileUtil.removeAccents(firstnameView), "\\w{1,32}")) {
                    isRegister = isRegister && true;                    
                } else {
                    isRegister = isRegister && false;
                    validCss.put("firstname", "class=error");
                    validMsg.put("firstname", fileUtil.getResourceValue("register.firstname"));        
                }
                System.out.println("addressJavabean.register.firstname isRegister = " + isRegister);                                                        
                    
                if(surname != null && Validation.validateRegex(FileUtil.removeAccents(surnameView), "\\w{1,32}")) {
                    isRegister = isRegister && true;                    
                } else {
                    isRegister = isRegister && false;
                    validCss.put("surname", "class=error");
                    validMsg.put("surname", fileUtil.getResourceValue("register.surname"));        
                }
                    System.out.println("addressJavabean.register.surname isRegister = " + isRegister);                                                        
                
                if(mobil != null && mobil.length() > 0) {
                    if(Validation.validateRegex(mobil, "\\d{9,16}")) {
                        isRegisterMin = isRegisterMin && true;
                    } else {
                        isRegisterMin = isRegisterMin && false;
                        validCss.put("mobil", "class=error");
                        validMsg.put("mobil", fileUtil.getResourceValue("register.mobil"));        
                    }

                } 
                        System.out.println("addressJavabean.register.mobil isRegister = " + isRegisterMin);                                                        
//street
                if(street != null && street.length > 0) {
                    if(street.length < 65 && Validation.validateRegex(FileUtil.removeAccents(streetView), "([a-zA-Z]+\\s+\\d+|[a-zA-Z]+\\s[a-zA-Z]+|[a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+\\s+\\d+)")) {
                        isRegisterMin = isRegisterMin && true;
                    } else {
                        isRegisterMin = isRegisterMin && false;
                        validCss.put("street", "class=error");
                        validMsg.put("street", fileUtil.getResourceValue("street"));        
                    }
                }
                        System.out.println("addressJavabean.register.street isRegister = " + isRegisterMin);                                                                                    
//city
                if(city != null && city.length > 0) {
                    if(city.length < 65 && Validation.validateRegex(FileUtil.removeAccents(cityView), "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)")) {
                        isRegisterMin = isRegisterMin && true;
                    } else {
                        isRegisterMin = isRegisterMin && false;
                        validCss.put("city", "class=error");
                        validMsg.put("city", fileUtil.getResourceValue("register.city"));        
                    }
                }
                        System.out.println("addressJavabean.register.city isRegister = " + isRegisterMin);                                                            
                        
//zip
                if(zip != null && zip.length() > 0) {
                    if(Validation.validateRegex(zip, "\\d{5}")) {
                        isRegisterMin = isRegisterMin && true;
                        System.out.println("addressJavabean.register.zip isRegister = " + isRegisterMin);                                    
                    } else {
                        isRegisterMin = isRegisterMin && false;
                        validCss.put("zip", "class=error");
                        validMsg.put("zip", fileUtil.getResourceValue("register.zip"));        
                    }
                } 
//pic
                boolean bPic = false;
                if(picName != null && picName.length() > 0) {
//subor sa nepodarilo nacitac
                    if(picSize > 0) {
                         bPic = bPic || true;
                     } else {
                         isRegisterMin = isRegisterMin && false;
                         validCss.put("pic", "class=error");
                         
                         validMsg.put("pic", fileUtil.getResourceValue("register.pic.name"));
                     }
//velkost suboru
                     if(picSize <= 1000000) {
                         bPic = bPic && true;
                     } else {
                         bPic = bPic && false;
                         isRegisterMin = isRegisterMin && false;
                         validCss.put("pic", "class=error");
                         validMsg.put("pic", fileUtil.getResourceValue("register.pic.size"));
                     }
//content-type suboru
                     if((picContentType.equals("image/jpeg") || picContentType.equals("image/gif") || picContentType.equals("image/png"))) {
                         bPic = bPic && true;
                     } else {
                         bPic = bPic && false;
                         isRegisterMin = isRegisterMin && false;
                         validCss.put("pic", "class=error");
                         validMsg.put("pic", fileUtil.getResourceValue("register.pic.type"));
                     }
//rozmer fotky
                    int[] sizeXY = FileUtil.pictureSize(imagedata);
                        if(sizeXY[0] <= 110 && sizeXY[1] <= 150) {
                           bPic = bPic && true;
                        } else {
                            bPic = bPic && false;
                            isRegisterMin = isRegisterMin && false;
                            validCss.put("pic", "class=error");
                            validMsg.put("pic", fileUtil.getResourceValue("register.pic.pixels"));
                         }
                     System.out.print("File width: "+ sizeXY[0] );
                     System.out.print("File height: "+ sizeXY[1] );
                }
                System.out.print("Uploaded File Info:");
                System.out.print("Content type: "+ picContentType );
                System.out.print("File name: "+ picName );
                System.out.print("File size: "+ picSize );


                if(web != null && web.length() > 0) {
                    if(web.length() < 65 && Validation.validateRegex(web, "([a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+)+(/*[A-Za-z0-9/\\-_&:?\\+=//.%]*)*")) {
                        isRegisterMin = isRegisterMin && true;
                   } else {
                        isRegisterMin = isRegisterMin && false;
                        validCss.put("web", "class=error");
                        validMsg.put("web", fileUtil.getResourceValue("register.web"));
                    }
                }
               System.out.println("addressJavabean.register.web isRegister = " + isRegisterMin);                                                            
                if(isRegister && isRegisterMin) {
                    Address address = new Address();
                    address.setEmail(email);
                    address.setPassword(password);
                    address.setFirstname(firstname);
                    address.setSurname(surname);
                    address.setMobil(mobil);
                    address.setCity(city);
                    address.setStreet(street);
                    address.setZip(zip);
                    address.setWeb(web);
//save pic
                    if(bPic) {
                        String dirName = fileUtil.getResourceValue("image.dir");
                        System.out.print("image.dir = " + dirName);
                        picName = String.valueOf(System.currentTimeMillis());
                        if(picContentType.equals("image/jpeg"))
                            picName+= ".jpeg";
                        else if(picContentType.equals("image/gif"))
                            picName+= ".gif";
                        else if(picContentType.equals("image/png"))
                            picName+= ".png";
                        File saveTo = new File(dirName + picName);
                        try {
                            picFileItem.write(saveTo);
                            System.out.print("The uploaded file has been saved successfully.");
                        } catch (Exception e){
                            System.out.print("An error occurred when we tried to save the uploaded file.");
    //                        e.printStackTrace(System.out);
                        }
                    } else
                       System.out.print("The uploaded file has not been saved successfully.");
                    address.setPic(picName);                    
                    addressJavabean.register(address);                    
                } else
                    System.out.println("addressJavabean.register not registered");                    
            }
            if(!isRegister || !isRegisterMin) {
//valid messages
out.print("<table>");   
         out.print("<tr "+validCss.get("email")+" ><td  align= left >"+validMsg.get("email")+"</td></tr>");                         
         out.print("<tr "+validCss.get("password")+" ><td  align= left >"+validMsg.get("password")+"</td></tr>");                         
         out.print("<tr "+validCss.get("firstname")+" ><td  align= left >"+validMsg.get("firstname")+"</td></tr>");                         
         out.print("<tr "+validCss.get("surname")+" ><td  align= left >"+validMsg.get("surname")+"</td></tr>");                         
         out.print("<tr "+validCss.get("mobil")+" ><td  align= left >"+validMsg.get("mobil")+"</td></tr>");                         
         out.print("<tr "+validCss.get("street")+" ><td  align= left >"+validMsg.get("street")+"</td></tr>");                         
         out.print("<tr "+validCss.get("city")+" ><td  align= left >"+validMsg.get("city")+"</td></tr>");                         
         out.print("<tr "+validCss.get("zip")+" ><td  align= left >"+validMsg.get("zip")+"</td></tr>");                         
         out.print("<tr "+validCss.get("pic")+" ><td  align= left >"+validMsg.get("pic")+"</td></tr>");                         
         out.print("<tr "+validCss.get("web")+" ><td  align= left >"+validMsg.get("web")+"</td></tr>");                         
         
out.print("</table>");            
                
//form                      
       out.print("<form action=index.jsp?page=register method = POST ENCTYPE=multipart/form-data   >");
          out.print("<table border = 0 >");
             
            out.print("<tr "+validCss.get("email")+" ><th align=left    >Email*</th><td align=left   >");
                    out.print("<input type = text name =email value ='"+ email +"' /></td></tr>");
            out.print("<tr "+validCss.get("password")+" ><th align=left  >Password*</th><td align=left  >");
                    out.print("<input type = password name =password /></td></tr>");            
            out.print("<tr "+validCss.get("firstname")+" ><th align= left   >Firstname*</th><td align = left  >");
                    out.print("<input type = text name =firstname value = '"+ firstnameView +"' /></td></tr>");                        
            out.print("<tr "+validCss.get("surname")+" ><th align= left    >Surname*</th><td align = left  >");
                    out.print("<input type = text name =surname value = '"+ surnameView +"' /></td></tr>");            
            out.print("<tr "+validCss.get("mobil")+" ><th align= left>Mobil</th><td align = left  ><input type = text name =mobil value = '"+ mobil +"' /></td></tr>");
            out.print("<tr "+validCss.get("street")+" ><th align= left>Street</th><td align = left  ><input type = text name =street value = '"+ streetView +"' /></td></tr>");
            out.print("<tr "+validCss.get("city")+"  ><th align= left>City</th><td align = left ><input type = text name =city value = '"+ cityView +"' /></td></tr>");
            out.print("<tr "+validCss.get("zip")+" ><th align= left>Zip</th><td align = left ><input type = text name =zip value = '"+ zip +"' /></td></tr>");

            out.print("<tr "+validCss.get("pic")+" ><th align= left>Picture</th><td align = left ><input type = file name =pic value = '"+ picName +"' /></td></tr>");

            out.print("<tr "+validCss.get("web")+" ><th align= left>Web</th><td align = left ><input type = text name =web value = '"+ web +"' /></td></tr>");
            out.print("<tr><td colspan =2 class = oznam >hodnoty vyznacene hviezdickou* su povinne</td></tr>");                        
            out.print("<tr><td align=right colspan = 2><input type = reset value = Reset /><input type = submit value = Register /></td></tr>");
            out.print("</table>");            
            out.print("<input type = hidden name = register value = submit />");                 
            out.print("<input type = hidden name = page value = register />");                 
        out.print("</form>");    

          %>                   
            
        <% } else {
            int id = addressJavabean.getAddress(email).getId();    
            System.out.println("addressJavabean.register = " + id);
            addressJavabean.addTeamToAddress(1, id);
            addressJavabean.addRightsToAddress("user", id);
            out.print("uzivatel " + email + " bol uspesne zaregistrovany");
//send email        
             AddressServiceJavabean addressServiceJavabean = new AddressServiceJavabean();
             if(addressServiceJavabean.registerUser(email))
                 out.print("registacne udaje boli poslane na adresu " + email);

                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="login" />
            </jsp:forward>
                <%

} 
} else {
         out.print("uzivatel je uz prihlaseny");          
}
        out.print("</div>");
                       %>

