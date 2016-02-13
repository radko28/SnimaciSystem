<%-- 
    Document   : logout
    Created on : Mar 27, 2008, 12:32:51 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean"%>       
<h2>Logout</h2>
        <%
        if(session.getAttribute("userId") != null) {
            int sessionUserId = (Integer)session.getAttribute("userId");            
            AddressJavabean addressJavabean = new AddressJavabean();        
            if(sessionUserId > 0) {
                addressJavabean.logout(sessionUserId);                
                session.removeAttribute("userId");                
                session.removeAttribute("email");
                %>
            <jsp:forward page="index.jsp?page=null" />
                <%
            }
        } else 
         out.print("uzivatel nie je prihlaseny");          
        %>
    
