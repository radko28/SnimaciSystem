<%-- 
    Document   : addTeam
    Created on : Mar 27, 2008, 12:36:31 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.TeamJavabean,
sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.web.helper.Validation,
                 sk.syntax.cyclosoft.web.helper.FileUtil,
                 java.util.Map,
                 java.util.HashMap,
                                  java.util.*,
                org.apache.commons.fileupload.servlet.ServletFileUpload,
                 org.apache.commons.fileupload.disk.DiskFileItemFactory,
                 org.apache.commons.fileupload.*,
                 org.apache.commons.io.FilenameUtils,
java.util.List,sk.syntax.cyclosoft.domain.Team"%>       
<div align = center>
        <h2>Add team</h2>
        <% 
        boolean bAddTeam = false;
        boolean bAddTeamSession = false;
        byte[] name = null;
        String teamView = "";
        FileUtil fileUtil = new FileUtil();
            Map<String,String> validCss = new HashMap();
            Map<String,String> validMsg = new HashMap();
            validMsg.put("name", "");
            
          if(session.getAttribute("email") != null ) {
              TeamJavabean teamJavabean = new TeamJavabean();
              String sessionEmail = (String)session.getAttribute("email");
              System.out.println("addTeam.sessionEmail = " + sessionEmail);
              AddressJavabean addressJavabean = new AddressJavabean();                              
              String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("addTeam.sessionRights = " + sessionRights);
              
              if(sessionRights.equals("admin") ||  sessionRights.equals("user")  ) {
                  bAddTeamSession = true;
              } 
        
        if(bAddTeamSession) {
//read form                
            String add = "";
            if(ServletFileUpload.isMultipartContent(request)) {
                System.out.print("addTeam.ServletFileUpload.isMultipartContent" );
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()){
                    FileItem fileItemTemp = (FileItem)it.next();
                    if (fileItemTemp.isFormField()){
                        System.out.print("addTeam.Field name:"+ fileItemTemp.getFieldName()+" = "+ fileItemTemp.getString() );
                          if (fileItemTemp.getFieldName().equals("add"))
                            add = fileItemTemp.getString();
                            if (fileItemTemp.getFieldName().equals("name")) {
                                name = fileItemTemp.get();
                                teamView = fileItemTemp.getString("UTF-8");
                            }
                    }
                }
            }
            System.out.println("addteam.add = " + add);            
            System.out.println("addteam.teamView = " + teamView);
            if(add !=null && add.length() > 0 && add.equals("submit")) {
//validacia
                if(name != null && name.length > 0 && Validation.validateRegex(FileUtil.removeAccents(teamView), "[A-Za-z0-9]{3,16}")) {
                      if(teamJavabean.getTeam(name) == 0) {
                            bAddTeam = true;
                        } else {
                            bAddTeam = false;
                            validCss.put("name", "class=error");
                            validMsg.put("name", fileUtil.getResourceValue("addteam.team.exist"));
                        }
                } else {
                        bAddTeam = false;
                        validCss.put("name", "class=error");
                        validMsg.put("name", fileUtil.getResourceValue("addteam.format"));
                }
                System.out.println("addTeam.name bAddTeam = " + bAddTeam);
            if(bAddTeam) {
                Team team = new Team();
                team.setName(name);
                
                teamJavabean.add(team);
                int userId = (Integer)session.getAttribute("userId");                
                System.out.println("addTeam.userId = " + userId);                                
//add to new team
                addressJavabean.addTeamToAddress(teamJavabean.getTeam(name), userId);
                if(sessionRights.equals("user")) {
//add id_rights adminGroup to userId         
                    addressJavabean.addRightsToAddress("adminGroup", userId);
                }
              }
            }
            if(!bAddTeam) {
//valid messages
out.print("<table>");   
         out.print("<tr "+validCss.get("name")+" ><td  align= left >"+validMsg.get("name")+"</td></tr>");                         
out.print("</table>");            
//form                      
        out.print("<form action=index.jsp?page=addTeam method = POST ENCTYPE=multipart/form-data ><table>");
            out.print("<tr "+validCss.get("name")+" ><th align=left>Team name</th><td align=right><input type = text name =name value = '"+teamView+"' /></td></tr>");
            out.print("<tr><td colspan =2 ><br/></td></tr>");            
            out.print("<tr><td align=right colspan=2><input type = submit value = Add /></td></tr>");
            out.print("</table>");
            out.print("<input type = hidden name = page value = addTeam />");
            out.print("<input type = hidden name = add value = submit />");
        out.print("</form>");
         } else {
            %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="teamList" />
            </jsp:forward>
            <%
        }
     } else {
                out.print("uzivatel nema pravo na mazanie");
             }
} else {
         out.print("uzivatel nie je prihlaseny");          
}                   
            %>
</div>