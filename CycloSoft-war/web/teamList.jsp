<%-- 
    Document   : teamList
    Created on : Mar 27, 2008, 12:33:33 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.TeamJavabean,
sk.syntax.cyclosoft.web.bean.AddressJavabean,
java.util.List,
sk.syntax.cyclosoft.domain.Team,
sk.syntax.cyclosoft.data.TeamList,
java.util.List,sk.syntax.cyclosoft.helper.Filter
"%>    

       <h2 align = center>Teams</h2>                
        <% 
            int rowsPerPage = 10;
            int edge = 0;
            int row = 0;
            int rows = 0;
//add        
            String sessionRights = "";
            int teamIdSessionInt = 0;
          if(session.getAttribute("email") != null ) {          
              String sessionEmail = (String)session.getAttribute("email");
              System.out.println("teamList.sessionEmail = " + sessionEmail);
              AddressJavabean addressJavabean = new AddressJavabean();                              
              sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("teamList.sessionRights = " + sessionRights);
              Team team = addressJavabean.getAddress(sessionEmail).getTeam();
              teamIdSessionInt = team.getId();
              System.out.println("teamList.teamIdSessionInt = " + teamIdSessionInt);                                
            }
            String rowString = (String)request.getParameter("row");
            if(rowString != null && rowString.length() > 0) {
                row = Integer.valueOf(rowString).intValue();
            } else
                rowString = "0";
            System.out.println("teamLadder.row = " + row);
//read           
            TeamJavabean teamJavabean = new TeamJavabean();
            Filter filter = new Filter();
//paging
            filter.setRow(row);
            filter.setRowsPerPage(rowsPerPage);
            TeamList teamList =  teamJavabean.getTeamList(filter);
            rows = teamList.getRows();
            System.out.println("teamLadder.row = " + row);
            System.out.println("teamLadder.rows = " + rows);
            System.out.println("teamLadder.RowsPerPage = " + rowsPerPage);
            out.print("<div align = center>");
            out.print("<table border=1 width = 40% >");            
            if(session.getAttribute("email") != null && (sessionRights.equals("admin") ||  sessionRights.equals("user"))) {
                out.print("<caption ><a href=index.jsp?page=addTeam>");
                out.print("add");
                out.print("</a></caption>");
            }
            out.print("<tr class = header>");                                                
            out.print("<th align = left>");                                                
            out.print("Name");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Action");                                                                
            out.print("</th>");
            out.print("</tr>");            
            int rowNum =0;
            for(Team teamItem : teamList.getTeamList()) {
                int teamId = teamItem.getId();
                String teamView = (new String(teamItem.getName(),"UTF-8")).trim();
                rowNum++;
                String className  = (rowNum % 2 == 0) ? "even":"odd";
                out.print("<tr class = "+className+" >");                                                                    
                out.print("<td>");                              
                out.print("<a href=index.jsp?page=addressList&teamId="+teamId+">"+ teamView +"</a>");
                out.print("</td>");
                out.print("<td align = center>");                              
                if(!teamView.equals("noTeam") && session.getAttribute("email") != null && (sessionRights.equals("admin") ||  (teamId == teamIdSessionInt) && sessionRights.equals("adminGroup")))
                    out.print("<a href=index.jsp?page=removeTeam&teamId="+teamId+">");
                out.print("remove");
                if(!teamView.equals("noTeam") && session.getAttribute("email") != null && (sessionRights.equals("admin") ||  (teamId == teamIdSessionInt) && sessionRights.equals("adminGroup")))                
                    out.print("</a>");                                
                out.print("</td>");                                               
                out.print("</tr>");                
            }
              out.print("</table>");
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
                out.print("<a href = index.jsp?page=teamList&row="+previous+"&edge="+edge+">Previous&nbsp;&laquo;</a> | ");

            for(int i = edgeDown; i <= edgeUp; i = i + rowsPerPage) {
                    if(i != row )
                        out.print("<a href = index.jsp?page=teamList&row="+i+"&edge="+edge+">");
                    out.print(i);
                    if(i != row )
                        out.print("</a>");
                      if(i <= (edgeUp - rowsPerPage))                    
                        out.print(" - ");
            }
            int next = row + rowsPerPage;
            if(next < rows)
                out.print(" | <a href = index.jsp?page=teamList&row="+next+"&edge="+edge+">&raquo;&nbsp;Next</a>");
            
            
out.print("</p>");                          
}
        %>

    

