<%-- 
    Document   : filter
    Created on : May 27, 2008, 1:32:32 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,sk.syntax.cyclosoft.web.bean.CycloJavabean,java.util.List, sk.syntax.cyclosoft.domain.Address, sk.syntax.cyclosoft.domain.Team"%>       
        <%
            String yearFrom = "";
            String monthFrom = "";            
            String yearTo = "";
            String monthTo = "";            
            String track = "";
            String filterString = "";
            String teamId = "all";
            String actualPageFilter = "";

            actualPageFilter = (String)request.getParameter("page");
            System.out.println("filter.actualPageFilter = " + actualPageFilter);

//submit form            
            String filled = (String)request.getParameter("filled");
            System.out.println("filter.filled = " + filled);
//filter state            
            filterString = (String)request.getParameter("filter");
            System.out.println("filter.filter = " + filterString);            
//filter state            
            if(filterString!= null && filterString.equals("show")) {
//teamId
             if(filled != null && filled.length() > 0 && filled.equals("submit")) {
                 teamId = (String)request.getParameter("teamId");             
                 if(teamId != null && teamId.length() > 0)
                     session.setAttribute("teamId" , teamId);                                  
                 System.out.println("filter.teamId = " + teamId);
              } else {
                  teamId = (String)session.getAttribute("teamId");
                  System.out.println("filter.teamId session= " + teamId);
                }
             int teamIdInt = 0;
              if(teamId != null && teamId.length() > 0 && !teamId.equals("all"))
               teamIdInt = Integer.valueOf(teamId).intValue();
              System.out.println("session teamIdInt = " + teamIdInt);
//track                
             if(filled != null && filled.length() > 0 && filled.equals("submit")) {
                 track = (String)request.getParameter("track");
                 if(track != null && track.length() > 0)
                   session.setAttribute("track" , track);                 
               } else
                   track = (String)session.getAttribute("track");    
            System.out.println("session track = " + track);
//monthFrom                
             if(filled != null && filled.length() > 0 && filled.equals("submit")) {
                monthFrom = (String)request.getParameter("monthFrom");                 
                 if(monthFrom != null && monthFrom.length() > 0)
                    session.setAttribute("monthFrom" , monthFrom);                 
               } else {
                    monthFrom = (String)session.getAttribute("monthFrom");                     
               }
System.out.println("session monthFrom = " + monthFrom);            
//yearFrom            
             if(filled != null && filled.length() > 0 && filled.equals("submit")) {
                yearFrom = (String)request.getParameter("yearFrom");
                if(yearFrom != null && yearFrom.length() > 0)
                    session.setAttribute("yearFrom" , yearFrom);                 
             } else {
                 yearFrom = (String)session.getAttribute("yearFrom");                     
             }
System.out.println("session yearFrom = " + yearFrom);            
//monthTo            
             if(filled != null && filled.length() > 0 && filled.equals("submit")) {
                monthTo = (String)request.getParameter("monthTo");
                if(monthTo != null && monthTo.length() > 0)                                 
                    session.setAttribute("monthTo" , monthTo);                     
             } else {
                monthTo = (String)session.getAttribute("monthTo");                     
             }
System.out.println("session monthTo = " + monthTo);            
//yearTo            
            if(filled != null && filled.length() > 0 && filled.equals("submit")) {
                 yearTo = (String)request.getParameter("yearTo");
                 if(yearTo != null && yearTo.length() > 0)                 
                    session.setAttribute("yearTo" , yearTo);                 
            } else
                yearTo = (String)session.getAttribute("yearTo");                
System.out.println("session yearTo = " + yearTo);            
            int userId = 0;
            String userIdString = "";
System.out.println("session userIdString = " + userIdString);                        
            if(request.getParameter("userId") != null) {
                userIdString = request.getParameter("userId");
                userId = Integer.valueOf(userIdString).intValue();
            } else {
//doplnit session             
                if(session.getAttribute("userId") != null)
                    userId = (Integer)session.getAttribute("userId");
            }
            System.out.println("userId = " + userId);
                CycloJavabean cycloJavabean = new CycloJavabean();
                List<String> trackList = cycloJavabean.getTrackList();
                int yearMinInt = 0;
                int yearMaxInt = 0;
                if(actualPageFilter.equals("cycloList") && userId > 0) {
                    yearMaxInt = cycloJavabean.getMaxYear(userId);                    
                    yearMinInt = cycloJavabean.getMinYear(userId);                
                } else if(!actualPageFilter.equals("cycloList")){
                    yearMaxInt = cycloJavabean.getMaxYear();                    
                    yearMinInt = cycloJavabean.getMinYear();                
                }
                System.out.println("yearMax = " + yearMaxInt);
                System.out.println("yearMin = " + yearMinInt);                
//filled
                System.out.println("filled - ok");
                System.out.println("userId = " + userId);                
        %>
       <h3>Filter</h3>
        <form action="index.jsp" method = POST>
<table>
<tr>            <th align = left >Year</th><th>from</th><td><select name = "yearFrom">
                  <%
                  out.print("<option value = all >-->all</option>");
                  for(int i = yearMinInt ; i <= yearMaxInt; i++)
                      if(yearFrom!= null && yearFrom.length() > 0 && yearFrom.equals(String.valueOf(i)))                          
                        out.print("<option value = "+i+" selected >"+i+"</option>");                          
                      else    
                        out.print("<option value = "+i+" >"+i+"</option>");
                  %>
              </select></td>
              <th>to</th><td><select name = "yearTo">
                  <%
                  out.print("<option value = all >-->all</option>");                  
                  for(int i = yearMinInt ; i <= yearMaxInt; i++)
                      if(yearTo!= null && yearTo.length() > 0 && yearTo.equals(String.valueOf(i)))                          
                        out.print("<option value = "+i+" selected >"+i+"</option>");                          
                      else
                        out.print("<option value = "+i+" >"+i+"</option>");
                  %>
          </select></td></tr>
          <tr><th align = left >Month<th>from</th><td><select name = "monthFrom">
                  <%
                  out.print("<option value = all >-->all</option>");                  
                  for(int i = 1 ; i <= 12; i++)
                      if(i > 9) {
                        if(monthFrom!= null && monthFrom.length() > 0 && monthFrom.equals(String.valueOf(i)))                          
                          out.print("<option value = "+i+" selected >"+i+"</option>");
                        else
                          out.print("<option value = "+i+" >"+i+"</option>");                            
                       } else  {
                        if(monthFrom!= null && monthFrom.length() > 0 && monthFrom.equals(String.valueOf("0"+i)))                                                
                          out.print("<option value = 0"+i+" selected >"+i+"</option>");
                        else
                          out.print("<option value = 0"+i+" >"+i+"</option>");                            
                       }
                  %>
              </select></td>
              <th>to</th><td><select name = "monthTo">
                  <%
                  out.print("<option value = all >-->all</option>");                  
                  for(int i = 1 ; i <= 12; i++)
                      if(i > 9) {
                        if(monthTo!= null && monthTo.length() > 0 && monthTo.equals(String.valueOf(i)))
                           out.print("<option value = "+i+" selected >"+i+"</option>");
                        else
                           out.print("<option value = "+i+" >"+i+"</option>");
                      }  else  {
                         if(monthTo!= null && monthTo.length() > 0 && monthTo.equals(String.valueOf("0"+i)))
                           out.print("<option value = 0"+i+" selected >"+i+"</option>");
                         else 
                           out.print("<option value = 0"+i+" >"+i+"</option>");                             
                      }
                  %>
          </select></td></tr>
          <tr><th align = left >Track<td><select name = "track">
                  <%
                  out.print("<option value = all >-->all</option>");                  
                   for(String trackItem : trackList) 
                      if(track!= null && track.length() > 0 && trackItem.equals(track)) {
                          out.print("<option value = "+trackItem+" selected >"+trackItem+"</option>");
                       } else   
                           out.print("<option value = "+trackItem+" >"+trackItem+"</option>");                           
                  %>
          </select></td><td></td>
              
              
                  <%
                  if(actualPageFilter != null && actualPageFilter.length() > 0 && actualPageFilter.equals("teamLadder")) {
                    out.print("<th>Team</th><td><select name = teamId>");
                    out.print("<option value = all >-->all</option>");                  
                        AddressJavabean addressJavabean = new AddressJavabean();
                        List teamList = addressJavabean.getTeamList();
                    
                        for(Object teamItem : teamList) {
                            int teamIdItem = ((Team)teamItem).getId();
                            String teamView = (new String(((Team)teamItem).getName(),"UTF-8")).trim();
                            if(teamIdInt == teamIdItem) {
                                out.print("<option value = "+teamIdItem+" selected >"+teamView+"</option>");
                            } else   
                                out.print("<option value = "+teamIdItem+" >"+teamView+"</option>");                           
 
                        }
                        
                        
                     out.print("</select></td>");                   
                   } else {
                           out.print("<td></td><td></td>");                   
                   }
                  %>
                  <td colspan = 2>
            <input type = "submit" value = "Filter" />
        </td></tr>
            </table>
           
           <input type = "hidden" name = "filled" value = "submit" />
            <input type = "hidden" name = "userId" value = '<%= userId %>' />                             
            <input type = "hidden" name = "page" value = '<%= actualPageFilter %>' />
            <input type = "hidden" name = "filter" value = "show" />                 

        </form>
        <hr/>
        <%
            } else {
//delete session track                
                System.out.println("filter.sjp delete session track");
                 session.removeAttribute("track");                
                 session.removeAttribute("monthFrom");                                 
                 session.removeAttribute("monthTo");                                                  
                 session.removeAttribute("yearFrom");                                                  
                 session.removeAttribute("yearTo");                                                  
                 session.removeAttribute("teamId");                                                                   
            }

%>
