<%-- 
    Document   : login
    Created on : Mar 27, 2008, 12:32:42 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean, sk.syntax.cyclosoft.domain.Address,
                 java.util.Map,
                 java.util.HashMap,
                 sk.syntax.cyclosoft.web.helper.FileUtil                 

"%>       
<div align = center> 
        <h2>Login</h2>        
        <%
            int isLoggedIn = 0;
            Address address = null;
            AddressJavabean addressJavabean = new AddressJavabean();        
            FileUtil fileUtil = new FileUtil();
            if(session.getAttribute("email") == null ) {
                Map<String,String> validCss = new HashMap();
                Map<String,String> validMsg = new HashMap();
                validMsg.put("error", "");
            String password = request.getParameter("password");
            System.out.println("password = " + password);                            
            String email = request.getParameter("email");
            System.out.println("email01 = " + email);                                        
            String hidden = request.getParameter("login");
            System.out.println("hidden = " + hidden);
            if(isLoggedIn == 0 && hidden != null && hidden.equals("submit") ) {
                
                address = new Address();
                address.setEmail(email);
                address.setPassword(password);
                isLoggedIn = addressJavabean.login(address);
                System.out.println("login.email07 = " + email);                                                                        
                System.out.println("login.email08 = " + password);     
                if(isLoggedIn == 0) {
                    validCss.put("error", "class=error");
                    if(password == null || password.length() <= 0 || email == null || email.length() <= 0) {
                        validMsg.put("error", fileUtil.getResourceValue("login.empty"));                        
                    } else
                        validMsg.put("error", fileUtil.getResourceValue("login.error"));                        
                }    
            }
            if(isLoggedIn <= 0){
out.print("<table>");   
         out.print("<tr "+validCss.get("error")+" ><td  align= left >"+validMsg.get("error")+"</td></tr>");                         
out.print("</table>");            

                out.print("<form action = index.jsp method = post><table>");

        
            out.print("<tr  "+validCss.get("error")+" ><th align=left>Email</th><td align=right><input type = text name = email /></td></tr>");
            out.print("<tr "+validCss.get("error")+" ><th align=left>Password</th><td align=right><input type = password name = password /></td></tr>");
        %>                               
            <tr><td align=right colspan = 2 class = login><a href= index.jsp?page=forget >Forget password</a></td></tr>
            
            <tr><td colspan =2 ><br/></td></tr>
                    
            <tr><td align="right" colspan = 2><input type = "reset" value = "Reset"/><input type = "submit" value = "Login"/></td></tr>
         </table>   
            <input type = "hidden" name = "login" value = "submit"/>           
            <input type = "hidden" name = "page" value = "login"/>            
        </form>
        
        
        <% } else {
                session.setAttribute("email" , email);
                session.setAttribute("userId" , new Integer(isLoggedIn));                
                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="addressDetail" />
            </jsp:forward>
                <%
        }
        } else {
         out.print("uzivatel je uz prihlaseny");          
        }
            
                %>
</div>        
        

