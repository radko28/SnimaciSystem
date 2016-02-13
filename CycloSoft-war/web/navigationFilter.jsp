<%-- 
    Document   : navigationFilter
    Created on : Dec 2, 2008, 12:31:03 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   
   
   
<%
  String actualPageNavFilter = "";
  String filterNavFilter = "";


  actualPageNavFilter = (String)request.getParameter("page");
  System.out.println("navigationFilter.actualPage = " + actualPageNavFilter);
  filterNavFilter = (String)request.getParameter("filter");
  System.out.println("navigationFilter.filterString = " + filterNavFilter);

  if(filterNavFilter!=null && filterNavFilter.equals("show"))
    out.print("<a href =  index.jsp?page="+actualPageNavFilter+"&filter=hide>hide filter</a>");
  else 
    out.print("<a href =  index.jsp?page="+actualPageNavFilter+"&filter=show>show filter</a>");
%>