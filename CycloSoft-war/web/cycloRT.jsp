<%-- 
    Document   : cycloRT
    Created on : 29.8.2009, 12:01:37
    Author     : radko28
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.web.bean.CycloRTJavabean,
                 sk.syntax.cyclosoft.data.CycloRTList,
                 sk.syntax.cyclosoft.data.CycloRTData,
                 sk.syntax.cyclosoft.helper.Filter,                 
                 sk.syntax.cyclosoft.domain.Address"%>
       <h2 align = center>Cyclo real-time list</h2>
       <%
        int row = 0;
        int rows = 0;
        int rowsPerPage = 10;
            
                    //submit form
            String filled = (String)request.getParameter("filled");
            System.out.println("addressList.filled = " + filled);

            
            String rowString = (String)request.getParameter("row");
            if(rowString != null && rowString.length() > 0 && filled == null) {
                row = Integer.valueOf(rowString).intValue();
            } else
                rowString = "0";
            System.out.println("addressList.row = " + row);
       
          AddressJavabean addressJavabean = new AddressJavabean();
         String sessionEmail = "";
        boolean bAdmin = false;
        if(session.getAttribute("email") != null && session.getAttribute("userId") != null) {
            sessionEmail = (String)session.getAttribute("email");
            String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
            System.out.println("addressList.sessionRights = " + sessionRights);            
            bAdmin = sessionRights.equals("admin")?true:false;
        }

 //paging
            Filter filter = new Filter();            
            filter.setRow(row);
            filter.setRowsPerPage(rowsPerPage);
            CycloRTJavabean cycloRTJavabean = new CycloRTJavabean();
            CycloRTList cycloRTList = cycloRTJavabean.getCycloList(filter);
            rows = cycloRTList.getRows();
            System.out.println("cycloRTList.row = " + row);
            System.out.println("cycloRTList.rows = " + rows);
            System.out.println("cycloRTList.RowsPerPage = " + rowsPerPage);
            
            
            
            out.print("<div align = center><table border width = 100% >");            
            out.print("<tr class = header>");                                                
            out.print("<th>");                                                
            out.print("Email");
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Team");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Veloce");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Distance");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Time");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Track");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Max. veloce");                                                                
            out.print("</th>");
            out.print("</tr>");
            String encoding = "UTF-8";
            int rowNum =0;
            for(CycloRTData cycloRTItem : cycloRTList.getCycloRTList()) {
                int userIdCycloRTList = cycloRTItem.getAddress().getId();
                rowNum++;
                String className  = (rowNum % 2 == 0) ? "even":"odd";
                out.print("<tr class = "+className+" >");                                                                    
                out.print("<td>");
                out.print("<a href =index.jsp?page=cycloRTDetail&userId="+userIdCycloRTList+">"+cycloRTItem.getAddress().getEmail()+"</a>");
                out.print("</td>");                               
                out.print("<td>");
                String teamView = (new String(cycloRTItem.getTeam().getName(),encoding)).trim();
                out.print(teamView);
                out.print("</td>");                               
                out.print("<td>");                              
                float veloceView = cycloRTItem.getVeloce();
                out.print(String.valueOf(veloceView));                
                out.print("</td>");                               
                out.print("<td>");                              
                float distanceView = cycloRTItem.getDistance();
                out.print(String.valueOf(distanceView));                
                out.print("</td>");                                               
                out.print("<td>");                              
                out.print("</td>");                                               
                out.print("<td>");                              
                String trackView = cycloRTItem.getTrack();
                out.print(String.valueOf(trackView));                
                out.print("</td>");                                               
                out.print("<td>");                              
                float maxVeloceView = cycloRTItem.getMaxVeloce();
                out.print(String.valueOf(maxVeloceView));                
                out.print("</td>");                                               
                out.print("</tr>");                
            }
              out.print("</table></div>");                          
        
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
System.out.println("set cycloRT.edgeDown = " + edgeDown);           
System.out.println("set cycloRT.edgeUp = " + edgeUp);           
out.print("<p>");                          
            int previous = row - rowsPerPage;
            if(previous >= 0)
                out.print("<a href = index.jsp?page=cycloRT&row="+previous+">Previous&nbsp;&laquo;</a> | ");

            for(int i = edgeDown; i <= edgeUp; i = i + rowsPerPage) {
                    if(i != row )
                        out.print("<a href = index.jsp?page=cycloRT&row="+i+">");
                    out.print(i);
                    if(i != row )
                        out.print("</a>");
                      if(i <= (edgeUp - rowsPerPage))                    
                        out.print(" - ");
            }
            int next = row + rowsPerPage;
            if(next < rows)
                out.print(" | <a href = index.jsp?page=cycloRT&row="+next+">&raquo;&nbsp;Next</a>");
            
            
out.print("</p>");                          
}
        %>

    
