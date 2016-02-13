<%-- 
    Document   : forget
    Created on : Mar 29, 2008, 10:06:48 PM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressServiceJavabean,
                 sk.syntax.cyclosoft.web.helper.Validation,
                 sk.syntax.cyclosoft.web.helper.FileUtil,
                 java.util.Map,
                 java.util.HashMap,
                 sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.domain.Address"%>       
<div align = center>
        <h2>Forget password</h2>        
        <%
            Map<String,String> validCss = new HashMap();
            Map<String,String> validMsg = new HashMap();
            validMsg.put("email", "");
            boolean bForget = false;

          String hidden = request.getParameter("forget");
            System.out.println("hidden = " + hidden);
        FileUtil fileUtil = new FileUtil();
        if(hidden != null && hidden.equals("submit") ) {
            String email = request.getParameter("email");
            System.out.println("email = " + email);
//validation
//email 
            AddressJavabean addressJavabean = new AddressJavabean();
                if(email != null && email.length() > 0 && Validation.validateRegex(email, "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[_A-Za-z0-9-]+)"))
                    if(addressJavabean.getAddress(email) != null) {
                        bForget = true;
                    } else {
                        bForget = false;
                        validCss.put("email", "class=error");
                        validMsg.put("email", fileUtil.getResourceValue("forget.email"));
                    }
                else {
                        bForget = false;
                        validCss.put("email", "class=error");
                        validMsg.put("email", fileUtil.getResourceValue("forget.email"));
                }
                 System.out.println("addressJavabean.forget.email bForget = " + bForget);

                if(bForget) {
//send forget email                                
                    AddressServiceJavabean addressServiceJavabean = new AddressServiceJavabean();
                    if(addressServiceJavabean.forgetPassword(email))
                        out.print("na adresu " + email + " bolo poslane heslo");
                    else
                        out.print("na adresu " + email + " sa nepodarilo poslat email");
                }
            }
            if(!bForget) {
//valid messages
out.print("<table>");   
         out.print("<tr "+validCss.get("email")+" ><td  align= left >"+validMsg.get("email")+"</td></tr>");                         
out.print("</table>");            
//form                      
                
                out.print("<form action = index.jsp method = post><table>");
                out.print("<tr "+validCss.get("email")+" ><th align= left>Email</th><td><input type = text name = email /></td></tr>");
                out.print("<tr><td colspan =2 ><br/></td></tr>");
                out.print("<tr><td align=right colspan = 2><input type = reset value = Reset /><input type = submit value = Forget /></td></tr>");
                out.print("</table>");
                out.print("<input type = hidden name = forget value = submit />");
                out.print("<input type = hidden name = page value = forget />");
                out.print("</form>");
          } 
            %>
</div>
