<%@ page   contentType ="text/html; charset=UTF-8" pageEncoding = "UTF-8" %>

<html>
<head>
<title>CycloSoft - Cyklisticky snimaci system</title>
<script>
var ns4class='';

cc=0;
function changepic()
{
    if (cc==0) 
    {
        cc=1;
        document.getElementById('picFileId').style.visibility='visible';
    } else {
        cc=0;
        document.getElementById('picFileId').style.visibility='hidden';
        document.getElementById('picFileId').value='';
    }
}



</script>
<link rel=stylesheet type=text/css href="css/sablona.css"/>
</head>
<body>
<table border width=1240>
<tr  >
<td colspan=2>
    <img src = "/images/banner.gif"  />
</td>
</tr>
    
<tr>
<td colspan=2 class = top>
    <div align = center>
<%@ include file = "navigation.jsp" %>
</div>
    <div align = right class = login>
    <b>logged : </b><%= (String)session.getAttribute("email")  %>
    </div>
</td>
</tr>

<tr height=670>
<td  width=10% valign=top class = left>
<%@ include file = "navigationLeft.jsp" %>
</td>

<!-- aktual -->
<td valign=top class = main>
<%    
  String actualPage = (String)request.getParameter("page");  
  System.out.println("index.actualPage = " + actualPage);
  
  if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("register")) {
    %>
   <%@ include file = "register.jsp" %>
   <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("login")) {
      %>
      <%@ include file = "login.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("logout")) {
      %>
      <%@ include file = "logout.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("addressList")) {
      %>
      <%@ include file = "filterTeam.jsp" %>
      <%@ include file = "addressList.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("cycloList")) {
      %>
      <%@ include file = "filter.jsp" %>
      <%@ include file = "cycloList.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("addCyclo")) {
      %>
      <%@ include file = "addCyclo.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("updateCyclo")) {
      %>
      <%@ include file = "updateCyclo.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("removeCyclo")) {
      %>
      <%@ include file = "removeCyclo.jsp" %>
      <%
  } else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("updateRegister")) {
      %>
      <jsp:include page = "updateRegister.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("removeAddress")) {
      %>
      <jsp:include page = "removeAddress.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("changePassword")) {
      %>
      <jsp:include page = "changePassword.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("teamList")) {
      %>
      <jsp:include page = "teamList.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("removeTeam")) {
      %>
      <jsp:include page = "removeTeam.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("addTeam")) {
      %>
      <jsp:include page = "addTeam.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("cycloLadder")) {
      %>
      <jsp:include page = "filter.jsp" />
      <jsp:include page = "cycloLadder.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("teamLadder")) {
      %>
      <jsp:include page = "filter.jsp" />
      <jsp:include page = "teamLadder.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("teamsLadder")) {
      %>
      <jsp:include page = "filter.jsp" />
      <jsp:include page = "teamsLadder.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("addressDetail")) {
      %>
      <jsp:include page = "addressDetail.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("forget")) {
      %>
      <jsp:include page = "forget.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("cycloRT")) {
      %>
      <jsp:include page = "cycloRT.jsp"/>
      <%
} else if(actualPage !=null && actualPage.length() > 0 && actualPage.equals("cycloRTDetail")) {
      %>
      <jsp:include page = "cycloRTDetail.jsp"/>
      <%
} else {
      %>
      <%@ include file = "indexBody.jsp" %>
      <%
  }
 
%>    
 </td>
<!-- side --> 
<!--td width=10%>side</td-->
</tr>

<tr class = sign>
 <!-- admin -->
<td colspan=2 align = center >
<a href = "mailto:rado.kuzma@gmail.sk" class = adminLink>Syntax</a> 2008 - 2009
</td>
</tr>
</table>
</body>
</html>