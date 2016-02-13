<%-- 
    Document   : cycloRTDetail
    Created on : 13.9.2009, 23:31:07
    Author     : radko28
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.domain.Address,
                 sk.syntax.cyclosoft.web.helper.FileUtil
                 "%>
<div align = "center">                 
        <h2>Cyclo real-time detail</h2>
        <%!
            AddressJavabean addressJavabean = new AddressJavabean();
            
            Address address = null;
            String email = "";
            String teamNameView = "";
            byte[] teamName = null;            
            byte[] firstname = null;
            String firstnameView = null;
            byte[] surname = null;
            String surnameView = "";
            String mobil = "";
            String streetView = "";
            String cityView = "";
            byte[] street = null;
            byte[] city = null;
            String zip = "";
            String web = "";
            String pic = "";
        %>
        <%
            FileUtil fileUtil = new FileUtil();
            int userId;
            String userIdString = request.getParameter("userId");
            if(userIdString != null) {
                userId = Integer.valueOf(userIdString).intValue();
            } else {
//doplnit session
                userId = (Integer)session.getAttribute("userId");
            }
             System.out.println("userId = " + userId);
                address = addressJavabean.getAddress(userId);
                email = address.getEmail();
                teamName = address.getTeam().getName();
                teamNameView =  new String(teamName,"UTF-8").trim();
                firstname = address.getFirstname();
                firstnameView =  new String(firstname,"UTF-8");
                surname=address.getSurname();
                surnameView =  new String(surname,"UTF-8");
                mobil = address.getMobil();
                street = address.getStreet();
                streetView =  new String(street,"UTF-8");
                city = address.getCity();
                cityView =  new String(city,"UTF-8");
                zip = address.getZip();
                web = address.getWeb();
                pic = address.getPic();
out.print("<table border=0 width = 60% >");
out.print("<tr><th align = left>Email</th><td align = left>"+ email +"</td>");
out.print("<td rowspan=9><img src = "+fileUtil.getResourceValue("image.url")+ pic +" alt = photo /></td></tr>");
        %>
    <tr><th align = "left">Team</th><td align = "left"><%= teamNameView %></td></tr>
    <tr><th align = "left">Firstname</th><td align = "left"><%= firstnameView %></td></tr>
    <tr><th align = "left">Surname</th><td align = "left"><%= surnameView %></td></tr>
    <tr><th align = "left">Veloce</th><td align = "left"><%= mobil %></td></tr>
    <tr><th align = "left">Distance</th><td align = "left"><%= streetView %></td></tr>
    <tr><th align = "left">Time</th><td align = "left"><%= cityView %></td></tr>
    <tr><th align = "left">Track</th><td align = "left"><%= zip %></td></tr>
    <tr><th align = "left">Max. veloce</th><td align = "left">
        <%
        out.print("<a href = http://"+ web + " target = _blank >"+web+"</a>");
        %>
        </td></tr>
</table>
</div>






