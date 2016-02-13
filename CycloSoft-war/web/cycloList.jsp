<%-- 
    Document   : cycloList
    Created on : Mar 27, 2008, 12:33:47 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 java.text.SimpleDateFormat,
                 sk.syntax.cyclosoft.web.bean.CycloJavabean,
                 java.util.List,
                 sk.syntax.cyclosoft.helper.Filter,
                 sk.syntax.cyclosoft.domain.Cyclo,
                 sk.syntax.cyclosoft.domain.CycloList,
                 sk.syntax.cyclosoft.web.helper.RoundNumber
                 "%>
        <%! 
        String track = "";
        String monthFrom = "";
        String yearFrom = "";
        String monthTo = "";
        String yearTo = "";
        String filterString = "";
        int row = 0;
        int rows = 0;
        int edge = 0;
        int rowsPerPage = 10;        
           %>
           <%
//sort
            int sort = 3;
            String sortString = "";
            String order = "desc";
            if(request.getParameter("sort") != null) {
                sortString = (String)request.getParameter("sort");
                if(sortString.length() > 0) {
                    sort = Integer.valueOf(sortString).intValue();
                }
            }
//order
            if(request.getParameter("order") != null) {
                order = (String)request.getParameter("order");
             }
//track
            track = (String)session.getAttribute("track");
            if(track == null || track.length() == 0)
                track = (String)request.getParameter("track");
//monthfrom            
            monthFrom = (String)session.getAttribute("monthFrom");
            if(monthFrom == null || monthFrom.length() == 0)
                monthFrom = (String)request.getParameter("monthFrom");            
//yearfrom
            yearFrom = (String)session.getAttribute("yearFrom");
            if(yearFrom == null || yearFrom.length() == 0)
                yearFrom = (String)request.getParameter("yearFrom");            
//monthto          
            monthTo = (String)session.getAttribute("monthTo");
            if(monthTo == null || monthTo.length() == 0)
                monthTo = (String)request.getParameter("monthTo");            
//yearto            
            yearTo = (String)session.getAttribute("yearTo");
            if(yearTo == null || yearTo.length() == 0)
                yearTo = (String)request.getParameter("yearTo");            
            
            filterString = (String)request.getParameter("filter");
            String edgeString = (String)request.getParameter("edge");
            if(edgeString != null && edgeString.length() > 0) {
                edge = Integer.valueOf(edgeString).intValue();
            }
            String rowString = (String)request.getParameter("row");
            if(rowString != null && rowString.length() > 0) {
                row = Integer.valueOf(rowString).intValue();
            } else
                rowString = "0";
            System.out.println("cycloList.row = " + row);
            System.out.println("read cycloList.edge = " + edge);
            System.out.println("cycloList.track = " + track);
            System.out.println("cycloList.monthFrom = " + monthFrom);
            System.out.println("cycloList.monthTo = " + monthTo);
            System.out.println("cycloList.yearFrom = " + yearFrom);
            System.out.println("cycloList.yearTo = " + yearTo);            
            System.out.println("cycloList.filter = " + filterString);
            AddressJavabean addressJavabean = new AddressJavabean();

           String sessionEmail = "";
           boolean bAdmin = false;
           String email = "";
           int userIdList = 0;
           String sessionRights = "";
          if(session.getAttribute("email") != null && session.getAttribute("userId") != null) {
                sessionEmail = (String)session.getAttribute("email");
                sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName().trim();
                System.out.println("cycloList.sessionRights = " + sessionRights);            
                bAdmin = sessionRights.equals("admin")?true:false;
                userIdList = (Integer)session.getAttribute("userId");
                email = sessionEmail.trim();

            }
           System.out.print("cycloList.bAdmin = "+bAdmin);
           System.out.print("cycloList.sessionRights = "+sessionRights);
            
            String userIdString = "";           
            if(request.getParameter("userId") != null)
                userIdString = (String)request.getParameter("userId");
            System.out.println("cycloList.userIdString = " + userIdString);            
            
            String rights = "";                                    
            if(userIdString != null && userIdString.length() > 0) {
                userIdList = Integer.parseInt(userIdString);
                email = addressJavabean.getAddress(userIdList).getEmail().trim();
                rights = addressJavabean.getAddress(email).getRights().getName().trim();                
            } 
            System.out.print("cycloList.email = "+email);            
            System.out.print("cycloList.sessionEmail = "+sessionEmail);                        
            System.out.print("cycloList.email.equals(sessionEmail)= "+email.equals(sessionEmail));                        
            System.out.print("cycloList.rights = "+rights);            
            System.out.print("cycloList.rights.equals(user)= "+rights.equals("user"));                                    
            System.out.print("cycloList.rights.equals(adminGroup)= "+rights.equals("adminGroup"));                                                
            out.print("<h2 align = center>");
            out.print("Cyclo list");
            if(userIdList > 0) {
               System.out.print("cycloList.userIdList = "+userIdList);
//email - team               
                String teamName = (new String(addressJavabean.getAddress(userIdList).getTeam().getName(),"UTF-8")).trim();            
                out.print("(" + email + " - ");
                out.print(teamName + ")</h2><p>");
                CycloJavabean cycloJavabean = new CycloJavabean();
//date,time,distance,veloce,track,temp,note         
//read
                Filter filter = new Filter();
                filter.setSortBy(sort);
                filter.setOrder(order);
                if(order != null && order.length() > 0 )
                    if(order.equals("asc"))
                       order = "desc";
                    else
                       order = "asc";
                filter.setId(userIdList);
                filter.setRow(row);
                filter.setRowsPerPage(10);
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
                filter.setRowsPerPage(rowsPerPage);                
                CycloList cycloList =  cycloJavabean.getCycloList(filter);
                rows = cycloList.getRows();
                
                System.out.println("cycloList.rows = " + rows);
                if(session.getAttribute("email") != null)
                    if( ((sessionRights.equals("user") || sessionRights.equals("adminGroup"))&& email.equals(sessionEmail) || bAdmin ) ) {
                        out.print("<a href =index.jsp?page=addCyclo>");                        
                        out.print("add");
                        out.print("</a>");                                
                    }    
                if( rows > 0 && ((sessionRights.equals("user") || sessionRights.equals("adminGroup")) && email.equals(sessionEmail) || bAdmin ) )
                    out.print(" | ");
                if(rows > 0)
                    if(filterString!=null && filterString.equals("show"))
                        out.print("<a href =  index.jsp?page=cycloList&filter=hide&userId="+userIdList+">hide filter</a>");                                                    
                    else 
                        out.print("<a href =  index.jsp?page=cycloList&filter=show&userId="+userIdList+">show filter</a>");                                                

            SimpleDateFormat sDateFormat = new SimpleDateFormat("dd-MM-yyyy");            
            SimpleDateFormat sTimeFormat = new SimpleDateFormat("HH:mm:ss");                            
                               
            out.print("<div align = center><table border width = 100% >");            
                out.print("<tr class = header>");                                                
                out.print("<th>");
                out.print("<a href =index.jsp?page=cycloList&sort=3&order="+order+"&row="+rowString+"&filter="+filterString+"&userId="+userIdList+" class = headerLink >Date</a>");
                out.print("</th>");
                out.print("<th>");                                                
                out.print("<a href =index.jsp?page=cycloList&sort=4&order="+order+"&row="+rowString+"&filter="+filterString+"&userId="+userIdList+" class = headerLink >Time</a>");
                out.print("</th>");
                out.print("<th>");                                                
                out.print("<a href =index.jsp?page=cycloList&sort=0&order="+order+"&row="+rowString+"&filter="+filterString+"&userId="+userIdList+" class = headerLink >Veloce</a>");
                out.print("</th>");
                out.print("<th>");                                                
                out.print("<a href =index.jsp?page=cycloList&sort=1&order="+order+"&row="+rowString+"&filter="+filterString+"&userId="+userIdList+" class = headerLink >Distance</a>");
                out.print("</th>");
                out.print("<th>");                                                
                out.print("Track");                                                                
                out.print("</th>");
                out.print("<th>");                                                
                out.print("Temperature");                                                                
                out.print("</th>");
                out.print("<th>");                                                
                out.print("Note");                                                                
                out.print("</th>");
                out.print("<th>");                                                
                out.print("Action");                                                                
                out.print("</th>");
                out.print("</tr>");
                int rowNum = 0;
                for(Cyclo cycloItem : cycloList.getCyloList()) {
                    rowNum++;
                    String className  = (rowNum % 2 == 0) ? "even":"odd";
                    out.print("<tr class = "+className+" >");                                                                    
                    out.print("<td align=center>");                                                                    
                    if(cycloItem.getDate() != null)
                        out.print(sDateFormat.format(cycloItem.getDate()));
                    out.print("</td>");                                                                                        
                    out.print("<td align=center>");                                                                                        
                    if(cycloItem.getTime() != null)
                        out.print(sTimeFormat.format(cycloItem.getTime()));
                    out.print("</td>");                                                                                        
                    out.print("<td>");

                    out.print(RoundNumber.round(cycloItem.getVeloce()));
                    out.print("</td>");                                                                                        
                    out.print("<td>");                                                                                        

                    out.print(RoundNumber.round(cycloItem.getDistance()));
                    out.print("</td>");                                                                                        
                    out.print("<td>");                                                                                        

                    out.print(cycloItem.getTrack());                                        
                    out.print("</td>");                                                                                        
                    out.print("<td>");                                                                                        

                    out.print(cycloItem.getTemperature());                                        
                    out.print("</td>");                                                                                        
                    out.print("<td>");                                                                                        

                    out.print(cycloItem.getNote());                                        
                    out.print("</td>");                                                                                        
                    out.print("<td align = center>");                                                                                        
                if(session.getAttribute("email") != null)
                    if( (  sessionRights.equals("adminGroup") || (sessionRights.equals("user")  ) && email.equals(sessionEmail) || bAdmin ) ) {
                        out.print("<a href = index.jsp?page=updateCyclo&cycloId="+cycloItem.getId()+"&userId="+userIdList+">");
                    }
                    out.print("update");
                if(session.getAttribute("email") != null)
                    if( (  sessionRights.equals("adminGroup") || (sessionRights.equals("user")  ) && email.equals(sessionEmail) || bAdmin ) ) {
                        out.print("</a>");                    
                    }
                    out.print(" | ");                    
                if(session.getAttribute("email") != null)
                    if( (  sessionRights.equals("adminGroup") || (sessionRights.equals("user")  ) && email.equals(sessionEmail) || bAdmin ) ) {
                        out.print("<a href = index.jsp?page=removeCyclo&cycloId="+cycloItem.getId()+"&userId="+userIdList+">");
                    }
                    out.print("remove");
                if(session.getAttribute("email") != null)
                    if( (  sessionRights.equals("adminGroup") || (sessionRights.equals("user")  ) && email.equals(sessionEmail) || bAdmin ) ) {
                        out.print("</a>");                                        
                    }                    
                    out.print("</td>");                                                                                        
                    out.print("</tr>");                                    
                }
                
              out.print("</table></div>");                          
            out.print("</p>");
            }
                                                   
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
                out.print("<a href = index.jsp?page=cycloList&row="+previous+"&edge="+edge+"&filter="+filterString+"&userId="+userIdList+">Previous&nbsp;&laquo;</a> | ");

            for(int i = edgeDown; i <= edgeUp; i = i + rowsPerPage) {
                    if(i != row )
                        out.print("<a href = index.jsp?page=cycloList&row="+i+"&edge="+edge+"&filter="+filterString+"&userId="+userIdList+">");
                    out.print(i);
                    if(i != row )
                        out.print("</a>");
                      if(i <= (edgeUp - rowsPerPage))                    
                        out.print(" - ");
            }
            int next = row + rowsPerPage;
            if(next < rows)
                out.print(" | <a href = index.jsp?page=cycloList&row="+next+"&edge="+edge+"&filter="+filterString+"&userId="+userIdList+">&raquo;&nbsp;Next</a>");
            
            
out.print("</p>");                          
}
        %>

    
            
