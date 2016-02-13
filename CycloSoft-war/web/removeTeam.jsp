<%-- 
    Document   : removeTeam
    Created on : Mar 27, 2008, 12:36:51 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.TeamJavabean,
sk.syntax.cyclosoft.web.bean.AddressJavabean,
sk.syntax.cyclosoft.domain.Team,
sk.syntax.cyclosoft.helper.Filter,                 
sk.syntax.cyclosoft.data.AddressList,
sk.syntax.cyclosoft.domain.Address
"%> 
        <%
        boolean bRemoveTeam = false;
        TeamJavabean teamJavabean = new TeamJavabean();        
          if(session.getAttribute("email") != null && request.getParameter("teamId") != null) {          
              String sessionEmail = (String)session.getAttribute("email");
              System.out.println("removeTeam.sessionEmail = " + sessionEmail);
              AddressJavabean addressJavabean = new AddressJavabean();                              
              String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("removeTeam.sessionRights = " + sessionRights);
              
              Team team = addressJavabean.getAddress(sessionEmail).getTeam();
              int teamIdSessionInt = team.getId();
              System.out.println("removeTeam.teamIdSessionInt = " + teamIdSessionInt);                
              String teamIdString = request.getParameter("teamId");
              int teamId = Integer.valueOf(teamIdString).intValue();
              System.out.println("removeTeam.teamId = " + teamId);
              String teamName = new String (teamJavabean.getTeam(teamId).getName(),"UTF-8");
              if(!teamName.equals("noTeam") && (sessionRights.equals("admin") || (teamId == teamIdSessionInt) && sessionRights.equals("adminGroup"))  ) {
                  bRemoveTeam = true;
              } 
        
        if(bRemoveTeam) {
              
                if(teamId > 0) {
//add noTeam to all members of teamId
                    Filter filter = new Filter();
                    filter.setTeamId(teamId);
                    filter.setRowsPerPage(0);
                    AddressList addressList = addressJavabean.getAddressByTeamList(filter);
                    int userId = 0;
                    for(Address addressItem : addressList.getAddressList()) {
                        addressJavabean.addTeamToAddress(1, addressItem.getId());
                        String rights = addressItem.getRights().getName().trim();
                        if(rights.equals("adminGroup"))
                            userId = addressItem.getId();
                        System.out.println("removeTeam.userId = " + userId);
                    }
//add rights user where is adminGroup                        
                    if(userId > 0)
                        addressJavabean.addRightsToAddress("user", userId);
//delete team                    
                    
                    teamJavabean.remove(teamId);
//redirect index.jsp  
                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="teamList" />
            </jsp:forward>
                <%
                 }
 
             } else {
                out.print("uzivatel nema pravo na mazanie");
             }
} else {
         out.print("uzivatel nie je prihlaseny");          
}             

        
        %>
