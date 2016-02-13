<%-- 
    Document   : teamsLadder
    Created on : Dec 1, 2008, 11:34:33 PM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.TeamJavabean,
sk.syntax.cyclosoft.web.bean.CycloStatisticsJavabean,
java.util.List,sk.syntax.cyclosoft.helper.Filter,
sk.syntax.cyclosoft.data.Ladder,sk.syntax.cyclosoft.data.LadderList,
sk.syntax.cyclosoft.web.helper.RoundNumber
"%>   
<div align = center>        
    <%@ include file = "navigationLadder.jsp" %>
    <h2>Teams ladder</h2>        
</div>    
    <p>
<%
        String track = "";
        String monthFrom = "";
        String yearFrom = "";
        String monthTo = "";
        String yearTo = "";
        String filterString = "";
        int row = 0;
        int rows = 0;
        String sortString = "0";
        int sort = 0;
        int rowsPerPage = 10;
        int edge = 0;

            String edgeString = (String)request.getParameter("edge");
            if(edgeString != null && edgeString.length() > 0) {
                edge = Integer.valueOf(edgeString).intValue();
            }

        
            sortString = (String)request.getParameter("sort");
            if(sortString != null && sortString.length() > 0) {
                sort = Integer.valueOf(sortString).intValue();
            }
            track = (String)session.getAttribute("track");
            if(track == null || track.length() == 0)
                track = (String)request.getParameter("track");
            monthFrom = (String)request.getParameter("monthFrom");
            yearFrom = (String)request.getParameter("yearFrom");
            monthTo = (String)request.getParameter("monthTo");
            yearTo = (String)request.getParameter("yearTo");
            filterString = (String)request.getParameter("filter");
            filterString = (filterString != null && filterString.length() > 0)?filterString:"hide";
            String rowString = (String)request.getParameter("row");
            if(rowString != null && rowString.length() > 0) {
                row = Integer.valueOf(rowString).intValue();
            } else
                rowString = "0";
            System.out.println("teamLadder.sort = " + sort);
            System.out.println("teamLadder.row = " + row);
            System.out.println("teamLadder.track = " + track);
            System.out.println("teamLadder.monthFrom = " + monthFrom);
            System.out.println("teamLadder.monthTo = " + monthTo);
            System.out.println("teamLadder.yearFrom = " + yearFrom);
            System.out.println("teamLadder.yearTo = " + yearTo);
            System.out.println("teamLadder.filter = " + filterString);
            System.out.println("read teamLadder.edge = " + edge);
           
//date,time,distance,veloce,track,temp,note
//read
                Filter filter = new Filter();
                filter.setSortBy(sort);
                
//filter
                if(track != null && track.length() > 0 && !track.equals("all"))
                    filter.setTrack(track);
                if(yearFrom != null && yearFrom.length() > 0 && !yearFrom.equals("all"))
                    filter.setYearFrom(yearFrom);
                if(yearTo != null && yearTo.length() > 0 && !yearTo.equals("all"))
                    filter.setYearTo(yearTo);
                if(monthFrom != null && monthFrom.length() > 0 && !monthFrom.equals("all"))
                    filter.setMonthFrom(monthFrom);
                if(monthTo != null && monthTo.length() > 0 && !monthTo.equals("all"))
                    filter.setMonthTo(monthTo);
                
//paging
                filter.setRow(row);
                filter.setRowsPerPage(rowsPerPage);

                CycloStatisticsJavabean cycloJavabean = new CycloStatisticsJavabean();
                LadderList ladderList =  cycloJavabean.getTeamsLadder(filter);

                rows = ladderList.getRows();
                System.out.println("teamLadder.row = " + row);
                System.out.println("teamLadder.rows = " + rows);
                System.out.println("teamLadder.RowsPerPage = " + rowsPerPage);
%>
<p>
<%@ include file = "navigationFilter.jsp" %>    
<div align = center>
                    <table border width = 100% >
<%
                out.print("<tr class = header>");
                out.print("<th>");
                out.print("Team");
                out.print("</th>");
                out.print("<th>");
                out.print("<a href =index.jsp?page=teamsLadder&sort=0&row="+rowString+"&filter="+filterString+" class = headerLink >Veloce</a>");
                out.print("</th>");
                out.print("<th>");
                out.print("<a href =index.jsp?page=teamsLadder&sort=1&row="+rowString+"&filter="+filterString+" class = headerLink >Distance</a>");
                out.print("</th>");
                out.print("<th>");
                out.print("<a href =index.jsp?page=teamsLadder&sort=2&row="+rowString+"&filter="+filterString+" class = headerLink >Training</a>");
                out.print("</th>");
                out.print("</tr>");
                int rowNum = 0;
                for(Ladder ladderItem : ladderList.getLadderList()) {
                    rowNum++;
                    String className  = (rowNum % 2 == 0) ? "even":"odd";
                    out.print("<tr class = "+className+" >");                                                                    
                    out.print("<td>");
                    String teamNameView = (new String(ladderItem.getTeam().getName(),"UTF-8")).trim();
                    out.print("<a href =index.jsp?page=teamLadder&sort=0&row="+rowString+"&filter="+filterString+"&teamId="+ladderItem.getTeam().getId()+"  >"+teamNameView+"</a>");
                    out.print("</td>");
                    out.print("<td>");
                    out.print(RoundNumber.round((float)ladderItem.getVeloce()));
                    out.print("</td>");
                    out.print("<td>");
                    out.print(RoundNumber.round((float)ladderItem.getDistance()));
                    out.print("</td>");
                    out.print("<td>");
                    out.print(ladderItem.getTraining());
                    out.print("</td>");
                    out.print("</tr>");
                }

                    out.print("</table></div>");
                out.print("</p>");                

        //paging
if(rows > 10) {              
//5,3-30,2,1
           int edgeDown = 0;
           int edgeUp = 0; 
if(rows > 30) {              
//edgeDown              
           edgeDown = row - 2*rowsPerPage;   
           edgeUp = row + 2*rowsPerPage;   

           if(edgeDown < 0) {
               edgeDown = row - rowsPerPage;   
               edgeUp = row + 3*rowsPerPage;   
           }
           if(edgeDown < 0) {
               edgeDown = 0;   
               edgeUp = row + 4*rowsPerPage;   
           }
//edgeUp              
           
           if(edgeUp >= rows) {
               edgeUp = row + rowsPerPage;   
               edgeDown = row - 3*rowsPerPage;                  
           }
           
           
           if(edgeUp >= rows) {
               edgeUp = row;   
               edgeDown = row - 4*rowsPerPage;                                 
           }
           
} else if(rows > 20) {           
//edgeDown              
           edgeDown = row - rowsPerPage;   
           edgeUp = row + rowsPerPage;   

           if(edgeDown < 0) {
               edgeDown = 0;   
               edgeUp = row + 2*rowsPerPage;   
           }
//edgeUp              
           if(edgeUp >= rows) {
               edgeUp = row;   
               edgeDown = row - 2*rowsPerPage;                                 
           }
} else if(rows > 10) {           
//edgeDown              
           edgeDown = 0;   
           edgeUp = rowsPerPage;   
}
System.out.println("set addressList.edgeDown = " + edgeDown);           
System.out.println("set addressList.edgeUp = " + edgeUp);           
out.print("<p>");                          
            int previous = row - rowsPerPage;
            if(previous >= 0)
                out.print("<a href = index.jsp?page=teamsLadder&row="+previous+"&filter="+filterString+"&sort="+sort+"&edge="+edge+">Previous&nbsp;&laquo;</a> | ");

            for(int i = edgeDown; i <= edgeUp; i = i + rowsPerPage) {
                    if(i != row )
                        out.print("<a href = index.jsp?page=teamsLadder&row="+i+"&filter="+filterString+"&sort="+sort+"&edge="+edge+">");
                    out.print(i);
                    if(i != row )
                        out.print("</a>");
                      if(i <= (edgeUp - rowsPerPage))                    
                        out.print(" - ");
            }
            int next = row + rowsPerPage;
            if(next < rows)
                out.print(" | <a href = index.jsp?page=teamsLadder&row="+next+"&filter="+filterString+"&sort="+sort+"&edge="+edge+">&raquo;&nbsp;Next</a>");
            
            
out.print("</p>");                          
}
        %>
            
