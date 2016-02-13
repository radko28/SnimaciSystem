


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,  
                 sk.syntax.cyclosoft.domain.Address,
                 sk.syntax.cyclosoft.web.bean.TeamJavabean,
                 sk.syntax.cyclosoft.web.helper.Validation,
                 java.util.List,  
                 java.util.Map,
                 java.util.HashMap,
                 sk.syntax.cyclosoft.domain.Team,
                 java.util.*,
                 java.io.File,
                 sk.syntax.cyclosoft.web.helper.FileUtil,  
                 org.apache.commons.fileupload.servlet.ServletFileUpload,
                 org.apache.commons.fileupload.disk.DiskFileItemFactory,
                 org.apache.commons.fileupload.*,
                 org.apache.commons.io.FilenameUtils,
                 sk.syntax.cyclosoft.helper.Filter,                 
                sk.syntax.cyclosoft.data.AddressList,
                 java.lang.Exception
"%>
<div align = center>                 
        <h2>Update register</h2>
        <%! 
            AddressJavabean addressJavabean = new AddressJavabean();         
            TeamJavabean teamJavabean = new TeamJavabean();            
            Address address = null;
            FileUtil fileUtil = new FileUtil();
            
            byte[] firstname = null;
            byte[] surname = null;
            String firstnameView = "";
            String surnameView = "";
            String mobil = "";
            String streetView = "";
            String cityView = "";
            byte[] street = null;
            byte[] city = null;
            String zip = "";
            String pic = "";
            String web = "";
            int teamId = 1;
            String teamIdString = "";
        %>
        <% 
            int teamIdOld = 1;
            int teamIdSession = -1;
            String encoding = "UTF-8";
            Map<String,String> validCss = new HashMap();  
            Map<String,String> validMsg = new HashMap();              
            validMsg.put("firstname", "");
            validMsg.put("surname", "");
            validMsg.put("mobil", "");
            validMsg.put("city", "");
            validMsg.put("street", "");
            validMsg.put("zip", "");
            validMsg.put("pic", "");
            validMsg.put("web", "");
            String sessionEmail = "";
            String picContentType = "";
            long picSize = 0;
            String picName = "";
            FileItem picFileItem = null;
            byte[] imagedata = null;
            String register = "";
            String userIdString = "";
            String changePic = "";
            boolean bUpdate = false;
            int userId = 0;
        
          AddressJavabean addressJavabean = new AddressJavabean();                
          if(session.getAttribute("email") != null && session.getAttribute("userId") != null) {          
              sessionEmail = (String)session.getAttribute("email");
              System.out.println("sessionEmail = " + sessionEmail);
              String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("sessionRights = " + sessionRights);
              teamIdSession = addressJavabean.getAddress(sessionEmail).getTeam().getId();
              System.out.println("updateRegister.teamIdSession = " + teamIdSession);
               
              
              
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
                        if (fileItemTemp.getFieldName().equals("userId")) {
                            userIdString = fileItemTemp.getString();
                            System.out.println("userIdString = " + userIdString);
                            if(userIdString != null && userIdString.length() > 0)
                                userId = Integer.valueOf(userIdString).intValue();
                        }
                        if (fileItemTemp.getFieldName().equals("firstname")) {
                            firstname = fileItemTemp.get();
                            firstnameView = fileItemTemp.getString(encoding);
                        }
                        if (fileItemTemp.getFieldName().equals("surname")) {
                            surname = fileItemTemp.get();
                            surnameView = fileItemTemp.getString(encoding);
                         }
                         if (fileItemTemp.getFieldName().equals("mobil"))
                            mobil = fileItemTemp.getString();
                         if (fileItemTemp.getFieldName().equals("street")) {
                            street = fileItemTemp.get();
                            streetView = fileItemTemp.getString(encoding);
                         }
                         if (fileItemTemp.getFieldName().equals("city")) {
                            city = fileItemTemp.get();
                            cityView = fileItemTemp.getString(encoding);
                         }
                         if (fileItemTemp.getFieldName().equals("zip"))
                            zip = fileItemTemp.getString();
                         if (fileItemTemp.getFieldName().equals("web"))
                            web = fileItemTemp.getString();
                         if (fileItemTemp.getFieldName().equals("teamId")) {
                            teamIdString = fileItemTemp.getString();
                            if(teamIdString != null && teamIdString.length() > 0) 
                                teamId = Integer.valueOf(teamIdString).intValue();
                         }
                         if (fileItemTemp.getFieldName().equals("teamIdOld")) {
                            String teamIdStringOld = fileItemTemp.getString();
                            if(teamIdStringOld != null && teamIdStringOld.length() > 0) 
                                teamIdOld = Integer.valueOf(teamIdStringOld).intValue();
                         }
                        
                         if (fileItemTemp.getFieldName().equals("changePic"))
                              changePic = fileItemTemp.getString();
                         if (fileItemTemp.getFieldName().equals("pic"))
                               pic = fileItemTemp.getString();
                    } else {
                        picContentType = fileItemTemp.getContentType();
                        picSize = fileItemTemp.getSize();
                        picFileItem = fileItemTemp;
                        imagedata = fileItemTemp.get();
                        if (picFileItem!=null)
                             picName = picFileItem.getName();
                    }
                }
             }   
             if(userId <= 0)  
                userId = (Integer)session.getAttribute("userId");                                
             if(sessionRights.equals("admin") || sessionRights.equals("user") || sessionRights.equals("adminGroup")  ) 
                bUpdate = true;
        if(bUpdate) {
            List teamList =  teamJavabean.getTeamList();
            boolean isUpdated = false;
            boolean isUpdatedMin = true;
            if(register !=null &&  register.length() > 0 && register.equals("submit")) {
           
                               
//register
            System.out.println("register - ok");
            System.out.println("firstname = " + firstname);                                
            System.out.println("surname = " + surname);                                
            System.out.println("mobil = " + mobil);                                
            System.out.println("street = " + street);                                
            System.out.println("city = " + city);                                
            System.out.println("zip = " + zip);                                
            System.out.println("pic = " + pic);                                
            System.out.println("picName = " + picName);                                            
            System.out.println("web = " + web);                                
            System.out.println("teamId = " + teamId);                                            
            System.out.println("changePic = " + changePic);                                                        
            
//validacia
//firstname            
                if(firstname != null &&  Validation.validateRegex(FileUtil.removeAccents(firstnameView), "\\w{1,32}")) {
                    isUpdated = isUpdated || true;
                } else {
                    isUpdated = isUpdated && false;
                    validCss.put("firstname", "class=error");
                    validMsg.put("firstname", fileUtil.getResourceValue("register.firstname"));        
                }
                    System.out.println("addressJavabean.register.firstname isUpdated = " + isUpdated);                                                        
//surname                    
                if(surname != null && Validation.validateRegex(FileUtil.removeAccents(surnameView), "\\w{1,32}")) {
                    isUpdated = isUpdated && true;                    
                } else {
                    isUpdated = isUpdated && false;
                    validCss.put("surname", "class=error");
                    validMsg.put("surname", fileUtil.getResourceValue("register.surname"));        
                }
                    System.out.println("addressJavabean.register.surname isUpdated = " + isUpdated);                                                        
//mobil                
                if(mobil != null && mobil.length() > 0) {
                    if(Validation.validateRegex(mobil, "\\d{9,16}")) {
                        isUpdatedMin = isUpdatedMin && true;
                    } else {
                        isUpdatedMin = isUpdatedMin && false;
                        validCss.put("mobil", "class=error");
                        validMsg.put("mobil", fileUtil.getResourceValue("register.mobil"));        
                    }

                } 
                System.out.println("addressJavabean.register.mobil isUpdatedMin = " + isUpdatedMin);
//street                                           
                if(street != null && street.length > 0) {
                    if(street.length < 65 && Validation.validateRegex(FileUtil.removeAccents(streetView), "([a-zA-Z]+\\s+\\d+|[a-zA-Z]+\\s[a-zA-Z]+|[a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+\\s+\\d+)")) {
                        isUpdatedMin = isUpdatedMin && true;
                    } else {
                        isUpdatedMin = isUpdatedMin && false;
                        validCss.put("street", "class=error");
                        validMsg.put("street", fileUtil.getResourceValue("register.street"));        
                    }
                }
                System.out.println("addressJavabean.register.street isUpdatedMin = " + isUpdatedMin);
//city                        
                if(city != null && city.length > 0) {
                    if(city.length < 65 && Validation.validateRegex(FileUtil.removeAccents(cityView), "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)")) {
                        isUpdatedMin = isUpdatedMin && true;
                    } else {
                        isUpdatedMin = isUpdatedMin && false;
                        validCss.put("city", "class=validation");
                        validMsg.put("city", fileUtil.getResourceValue("register.city"));        
                    }
                }
                System.out.println("addressJavabean.register.city isUpdatedMin = " + isUpdatedMin);
//zip                
                if(zip != null && zip.length() > 0) {
                    if(Validation.validateRegex(zip, "\\d{5}")) {
                        isUpdatedMin = isUpdatedMin && true;

                    } else {
                        isUpdatedMin = isUpdatedMin && false;
                        validCss.put("zip", "class=error");
                        validMsg.put("zip", fileUtil.getResourceValue("register.zip"));        
                    }
                } 
               System.out.println("addressJavabean.register.zip isUpdatedMin = " + isUpdatedMin);                
//web                
                if(web != null && web.length() > 0) {
                    if(web.length() < 65 && Validation.validateRegex(web, "([a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+)+(/*[A-Za-z0-9/\\-_&:?\\+=//.%]*)*")) {
                        isUpdatedMin = isUpdatedMin && true;
                   } else {
                        isUpdatedMin = isUpdatedMin && false;
                        validCss.put("web", "class=error");
                        validMsg.put("web", fileUtil.getResourceValue("register.web"));        
                    }
                }
               System.out.println("addressJavabean.register.web isUpdatedMin = " + isUpdatedMin);
//pic                
                boolean bPic = false;
                System.out.println("addressJavabean.register.picName changePic = " + changePic);
                System.out.println("addressJavabean.register.picName picName = " + picName);
                System.out.println("addressJavabean.register.picName picSize = " + picSize);                
                if(changePic.trim().equals("on") && picName != null && picName.length() > 0) {
                     System.out.println("changePic == on && picName != null && picName.length() > 0");                
//subor sa nepodarilo nacitac
                    if(picSize > 0) {
                         bPic = bPic || true;
                     } else {
                         isUpdatedMin = isUpdatedMin && false;
                         validCss.put("pic", "class=error");
                         validMsg.put("pic", fileUtil.getResourceValue("register.pic.name"));        
                     }
//velkost suboru
                     if(picSize <= 1000000) {
                         bPic = bPic && true;
                     } else {
                         bPic = bPic && false;
                         isUpdatedMin = isUpdatedMin && false;
                         validCss.put("pic", "class=error");
                         validMsg.put("pic", fileUtil.getResourceValue("register.pic.size"));        
                     }
                    System.out.println("addressJavabean.register.picName picSize bPic = " + bPic);
//content-type suboru
                     if((picContentType.equals("image/pjpeg") || picContentType.equals("image/jpeg") || picContentType.equals("image/gif") || picContentType.equals("image/png"))) {
                         bPic = bPic && true;
                     } else {
                         bPic = bPic && false;
                         isUpdatedMin = isUpdatedMin && false;
                         validCss.put("pic", "class=error");
                         validMsg.put("pic", fileUtil.getResourceValue("register.pic.type"));        
                     }
                    System.out.println("addressJavabean.register.picName content-type bPic = " + bPic);

                    
//rozmer fotky
                    int[] sizeXY = FileUtil.pictureSize(imagedata);
                        if(sizeXY[0] <= 145 && sizeXY[1] <= 175) {
                           bPic = bPic && true;
                        } else {
                            bPic = bPic && false;
                            isUpdatedMin = isUpdatedMin && false;
                            validCss.put("pic", "class=error");
                            validMsg.put("pic", fileUtil.getResourceValue("register.pic.pixels"));        
                         }
                     System.out.print("File width: "+ sizeXY[0] );
                     System.out.print("File height: "+ sizeXY[1] );
                }
                System.out.print("Uploaded File Info:");
                System.out.print("Content type: "+ picContentType );
                System.out.print("Cotntent type length: "+ picContentType.length());                
                System.out.print("File name: "+ picName );
                System.out.print("File size: "+ picSize );
                System.out.println("addressJavabean.register.picName bPic = " + bPic);
               System.out.println("addressJavabean.register.picName isUpdatedMin = " + isUpdatedMin);


                                                      
            if(isUpdated && isUpdatedMin) {
               address = new Address();
                System.out.println("updateRegister.addressJavabean = " + addressJavabean);                                   
                System.out.println("updateRegister.address = " + address);                
                address.setId(userId);
                address.setFirstname(firstname);
                address.setSurname(surname);
                address.setMobil(mobil);
                address.setStreet(street);
                address.setCity(city);
                address.setZip(zip);
                address.setWeb(web);
//save pic
                    if(bPic) {
                        String dirName = "C:/images/";
                        picName = String.valueOf(System.currentTimeMillis());
                        if(picContentType.equals("image/jpeg") || picContentType.equals("image/pjpeg"))
                            picName+= ".jpeg";
                        else if(picContentType.equals("image/gif"))
                            picName+= ".gif";
                        else if(picContentType.equals("image/png"))
                            picName+= ".png";
                        File saveTo = new File(dirName + picName);
                        try {
                            picFileItem.write(saveTo);
                            System.out.print("The uploaded file has been saved successfully.");
                            File oldFile = new File(dirName + pic);
                            if(oldFile != null && oldFile.exists()) {
                                boolean success = false;
                                success = oldFile.delete();
                                if (success) {
                                    System.out.print(dirName + pic + " has been deleted.");
                                } else                                
                                    System.out.print(dirName + pic + " has not been deleted.");                                    
                            }
                            address.setPic(picName);                            
                        } catch (Exception e){
                            System.out.print("An error occurred when we tried to save the uploaded file.");
    //                        e.printStackTrace(System.out);
                        }
                    } else
                       System.out.print("The uploaded file has not been saved successfully.");
                    addressJavabean.registerUpdate(address);
//teamId                
                System.out.println("updateRegister.teamId = " + teamId);                
                System.out.println("updateRegister.address.getId() = " + address.getId());                
                
                    Filter filter = new Filter();
                    filter.setTeamId(teamIdOld);
                    filter.setRowsPerPage(0);
                    AddressList addressListOld = addressJavabean.getAddressByTeamList(filter);
                    filter.setTeamId(teamId);
                    AddressList addressList = addressJavabean.getAddressByTeamList(filter);
                    
                if(sessionRights.equals("adminGroup")  || sessionRights.equals("admin")  ) {
//add new teamName to all members of teamId
                    for(Address addressItem : addressListOld.getAddressList()) {
                        addressJavabean.addTeamToAddress(teamId, address.getId());
                        String rights = addressItem.getRights().getName().trim();
                        if(rights.equals("adminGroup"))
                            userId = addressItem.getId();
                    }
//add rights user where is adminGroup                        
                    if(userId > 0) {
                        if(addressList != null && addressList.getAddressList() != null && addressList.getAddressList().size() == 0) {
                            addressJavabean.addTeamToAddress(teamId, address.getId());
                            addressJavabean.addRightsToAddress("adminGroup", userId);
                        } else
                            addressJavabean.addRightsToAddress("user", userId);
                    }
                    
                } else {
                    addressJavabean.addTeamToAddress(teamId, address.getId());
                    if(addressList != null && addressList.getAddressList() != null && addressList.getAddressList().size() == 0) 
                         addressJavabean.addRightsToAddress("adminGroup", userId);
                }
                    
               }
            } else {
                address = addressJavabean.getAddress(userId);
                firstname = address.getFirstname();
                firstnameView = new String (firstname,encoding);
                surname = address.getSurname();
                surnameView = new String (surname,encoding);
                street = address.getStreet();
                streetView = new String (street,encoding);
                city = address.getCity();
                cityView = new String (city,encoding);
                zip = address.getZip();
                pic = address.getPic();
                web = address.getWeb();
                mobil = address.getMobil();
                teamIdOld = address.getTeam().getId();
                teamId = teamIdOld;
           }
            if(!isUpdated || !isUpdatedMin) {
//valid messages
out.print("<table>");   
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
        
        out.print("<form action=index.jsp?page=updateRegister method = POST ENCTYPE=multipart/form-data ><table>");
                  out.print("<tr ><th align=left    >Email</th><td align=right   >");
                    out.print(sessionEmail +"</td></tr>");
            out.print("<tr "+validCss.get("firstname")+" ><th align= left   >Firstname*</th><td align = right  >");
            out.print("<input type = text name =firstname value = '"+ firstnameView +"' /></td></tr>");                        
            out.print("<tr "+validCss.get("surname")+" ><th align= left    >Surname*</th><td align = right  >");
            out.print("<input type = text name =surname value = '"+ surnameView +"' /></td></tr>");            
            out.print("<tr "+validCss.get("mobil")+" ><th align= left>Mobil</th><td align = right  ><input type = text name =mobil value = '"+ mobil +"' /></td></tr>");            
            out.print("<tr "+validCss.get("street")+" ><th align= left>Street</th><td align = right  ><input type = text name =street value = '"+ streetView +"' /></td></tr>");            
            out.print("<tr "+validCss.get("city")+"  ><th align= left>City</th><td align = right ><input type = text name =city value = '"+ cityView +"' /></td></tr>");            
            out.print("<tr "+validCss.get("zip")+" ><th align= left>Zip</th><td align = right ><input type = text name =zip value = '"+ zip +"' /></td></tr>");            
            out.print("<tr "+validCss.get("pic")+" ><th align= left>Picture</th><td align = left >");
            out.print("<input name = changePic type=checkbox onclick=changepic() > change");            
            out.print("</td><td>");
            out.print("<input type = file id = picFileId name = pic value = '"+ pic +"' style = 'visibility:hidden' />");
            out.print("</td></tr>");            
            out.print("<tr "+validCss.get("web")+" ><th align= left>Web</th><td align = right ><input type = text name =web value = '"+ web +"' /></td></tr>");   
            out.print("<tr  ><th align=  left >Team</th><td align =  right ><select name = teamId >");
            
                    for(Object teamItem : teamList) {
                        int teamItemId = ((Team)teamItem).getId();
                        String teamView = (new String(((Team)teamItem).getName(),"UTF-8")).trim(); 
                        if(teamId == teamItemId)
                            out.print("<option value = "+ teamItemId +" selected >"+ teamView+"</option>");
                        else
                            out.print("<option value = "+ teamItemId +" >"+teamView +"</option>");                            
                    }
            
            out.print("</select></td></tr>");
             out.print("<tr><td colspan =2 class = oznam >hodnoty vyznacene hviezdickou* su povinne</td></tr>");                        
            out.print("<tr><td align=right colspan = 2><input type = reset value = Reset /><input type = submit value = 'Update register' /></td></tr>");
               out.print("</table>");            
            out.print("<input type = hidden name = userId value = '" +  userId +"' />");                    
            out.print("<input type = hidden name = teamIdOld value = '" +  teamIdOld +"' />");                    
            out.print("<input type = hidden name = pic value = '" +  pic +"' />");                                
            out.print("<input type = hidden name = register value = submit />");                 
            out.print("<input type = hidden name = page value = updateRegister />");                 
            
        out.print("</form>");    
        
        } else {
                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="addressDetail" />
            </jsp:forward>
                <%
        }
             } else {
                out.print("uzivatel nema pravo na zmenu");
             }
} else {
         out.print("uzivatel nie je prihlaseny");          
}             
%>
</div>