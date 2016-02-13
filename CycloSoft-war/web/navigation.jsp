<%-- 
    Document   : navigation
    Created on : May 27, 2008, 1:02:06 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   <table border="0" width = 20% >
  <tr>
      <%
if( session.getAttribute("email") == null ) {
        out.print("<td ><a href=index.jsp?page=login class=menulink class=&{ns4class}; >Login</a></td>");
        out.print("<td ><a href=index.jsp?page=register class=menulink class=&{ns4class};>Register</a></td>");        
} else {
        out.print("<td ><a href=index.jsp?page=updateRegister class=menulink class=&{ns4class}; >UpdateRegister</a></td>");
        out.print("<td ><a href=index.jsp?page=changePassword class=menulink class=&{ns4class}; >ChangePassword</a></td>");        
        out.print("<td ><a href=index.jsp?page=logout class=menulink class=&{ns4class};>Logout</a></td>");        
}        
      %>
  </tr>
</table>

   
