<%-- 
    Document   : filterTeam
    Created on : 8.12.2008, 13:52:08
    Author     : ext5201m
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,sk.syntax.cyclosoft.web.bean.CycloJavabean,java.util.List, sk.syntax.cyclosoft.domain.Address, sk.syntax.cyclosoft.domain.Team"%>
        <%
            String filterString = "";
            int teamId = 0;
            String actualPageFilter = "";
            
            actualPageFilter = (String)request.getParameter("page");
            System.out.println("filterTeam.actualPageFilter = " + actualPageFilter);

//submit form
            String filledTeam = (String)request.getParameter("filled");
            System.out.println("filterTeam.filled = " + filledTeam);
//teamId
            String teamString = (String)request.getParameter("teamId");
            System.out.println("filterTeam.teamString01 = " + teamString);
                if(teamString != null && teamString.length() > 0 && !teamString.equals("all")) {
                    System.out.println("filterTeam.teamString02 = " + teamString);
                    teamId = Integer.valueOf(teamString).intValue();
                }    
            System.out.println("filterTeam.teamId = " + teamId);
//filled
                System.out.println("filled - ok");
        %>
        <form action="index.jsp" method = POST>
          <table><tr><th>Team</th>
            <td>
              <select name = teamId >
                <option value = all >-->all</option>            
                  <%
                        AddressJavabean addressJavabeanFilter = new AddressJavabean();
                        List teamList = addressJavabeanFilter.getTeamList();
                        for(Object teamItem : teamList) {
                            int teamIdItem = ((Team)teamItem).getId();
                            String teamView = (new String(((Team)teamItem).getName(),"UTF-8")).trim();
                            if(teamId == teamIdItem) {
                                out.print("<option value = "+teamIdItem+" selected >"+teamView+"</option>");
                            } else
                                out.print("<option value = "+teamIdItem+" >"+teamView+"</option>");
                        }                            
                  %>
              </select>
            <td>
            <td>            
              <input type = "submit" value = "Filter" />
            </td>
          </tr></table>        
           <input type = "hidden" name = "filled" value = "submit" />
           <input type = "hidden" name = "page" value = '<%= actualPageFilter %>' />

        </form>
