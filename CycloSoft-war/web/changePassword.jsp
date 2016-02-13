<%-- 
    Document   : changePassword
    Created on : Oct 13, 2008, 11:00:10 PM
    Author     : radko28
--%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.web.helper.Validation,
                 sk.syntax.cyclosoft.web.helper.FileUtil,
                 java.util.List,  
                 java.util.Map,
                 java.util.HashMap,
                 sk.syntax.cyclosoft.domain.Address,
                 sk.syntax.cyclosoft.web.bean.AddressServiceJavabean                 
"%>   
<div align = center>      
        <h2>Change password</h2>
        <% 
            AddressJavabean addressJavabean = new AddressJavabean();         
            Address address = null;
            String password = "";            
            String verifyPassword = "";                        
            String sessionEmail = "";
           boolean bChangePassword = false;
           FileUtil fileUtil = new FileUtil();
          if(session.getAttribute("email") != null && session.getAttribute("userId") != null) {
            Map<String,String> validCss = new HashMap();
            Map<String,String> validMsg = new HashMap();
            validMsg.put("error", "");
            validMsg.put("password", "");
            validMsg.put("verifyPassword", "");

              sessionEmail = (String)session.getAttribute("email");
              System.out.println("sessionEmail = " + sessionEmail);
              String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("sessionRights = " + sessionRights);
              
                int userIdSessionInt = (Integer)session.getAttribute("userId");
                System.out.println("userIdSessionInt = " + userIdSessionInt);                
                   
              if(sessionRights.equals("admin") || sessionRights.equals("user") || sessionRights.equals("adminGroup")  ) {
                  bChangePassword = true;
              } 

           if(bChangePassword) { 
            
            String change = (String)request.getParameter("change");
            System.out.println("change = " + change);            
            boolean isUpdated = false;
            //String userIdString = request.getParameter("userId");
            //int userId = Integer.valueOf(userIdString).intValue();
//doplnit session             
            int userId = (Integer)session.getAttribute("userId");
             System.out.println("userId = " + userId);
            if(change !=null &&  change.equals("submit")) {
//validate
                password = (String)request.getParameter("password");;
                System.out.println("password = " + password);
                if(password != null &&  Validation.validateRegex(password, "\\w{6,16}")) {
                    isUpdated = isUpdated || true;
                } else {
                    isUpdated = isUpdated && false;
                    validCss.put("password", "class=error");
                    validMsg.put("password", fileUtil.getResourceValue("changepassword.password"));
                }
                 System.out.println("changePassword.password isUpdated = " + isUpdated);
//verifyPassword
                verifyPassword = (String)request.getParameter("verifyPassword");;
                System.out.println("verifyPassword = " + verifyPassword);
                if(verifyPassword != null &&  Validation.validateRegex(verifyPassword, "\\w{6,16}")) {
                    isUpdated = isUpdated && true;
                } else {
                    isUpdated = isUpdated && false;
                    validCss.put("verifyPassword", "class=error");
                    validMsg.put("verifyPassword", fileUtil.getResourceValue("changepassword.verifyPassword"));
                }
                 System.out.println("changePassword.verifyPassword isUpdated = " + isUpdated);
//register
                if(isUpdated) {
                    address = new Address();
                    System.out.println("addressJavabean = " + addressJavabean);
                    System.out.println("address = " + address);
                    address.setId(userId);
                    address.setPassword(password);
                    if( password.equals(verifyPassword) ) {
                        System.out.println("change02 - ok");
                        addressJavabean.registerUpdate(address);
                        out.print("heslo bolo zmenene");
                        isUpdated = isUpdated && true;
                    } else {
                        isUpdated = isUpdated && false;
                        validCss.put("error", "class=error");
                        validMsg.put("error", fileUtil.getResourceValue("changepassword.error"));
                    }
                 }
            }
            if(!isUpdated) {
                out.print("<table>");
                    out.print("<tr "+validCss.get("error")+" ><td  align= left colspan =3  >"+validMsg.get("error")+"</td></tr>");                
                    out.print("<tr "+validCss.get("password")+" ><td  align= left colspan =3  >"+validMsg.get("password")+"</td></tr>");                
                    out.print("<tr "+validCss.get("verifyPassword")+" ><td  align= left colspan =3  >"+validMsg.get("verifyPassword")+"</td></tr>");                
                out.print("</table>");                    
        %>

        <form action="index.jsp" method = POST>
          <table>
      <%

            out.print("<tr "+validCss.get("password")+" ><th align= left  >New password</th><td align= right><input type = password name =password /></td></tr>");
            out.print("<tr "+validCss.get("verifyPassword")+" ><th align= left  >Verify password</th><td align= right><input type = password name =verifyPassword /></td></tr>");
            out.print("<tr><td colspan = 3 ><br/></td></tr>");            
%>
            <tr><td align="right" colspan=2><input type = "reset" value = "Reset"/><input type = "submit" value = "Change" /></td></tr>
          </table>            
            <input type = "hidden" name = "change" value = "submit" />                 
            <input type = "hidden" name = "page" value = "changePassword" />                 
        </form>
        <%
        } else {
//send email        
            AddressServiceJavabean addressServiceJavabean = new AddressServiceJavabean();
            if(addressServiceJavabean.changePassword(sessionEmail)) {
                out.print("na adresu " + sessionEmail + " bolo poslane nove heslo");
            } else
                out.print("na adresu " + sessionEmail + " sa nepodarilo poslat email");
        }    
     } else 
        out.print("uzivatel nema pravo na mazanie");
 } else
     out.print("uzivatel nie je prihlaseny");
%>
</div>