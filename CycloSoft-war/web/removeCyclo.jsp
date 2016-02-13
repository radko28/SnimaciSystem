<%-- 
    Document   : removeCyclo
    Created on : Mar 27, 2008, 12:36:21 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.CycloJavabean,
                 sk.syntax.cyclosoft.web.bean.AddressJavabean
"%>       
        
        <% 
          boolean bRemove = false;
          int userId = 0;
          AddressJavabean addressJavabean = new AddressJavabean();                
          String cycloIdString = "";
          int cycloId = 0;
          String sessionRights = "";
          if(request.getParameter("cycloId") != null && session.getAttribute("email") != null && session.getAttribute("userId") != null) {          
              String sessionEmail = (String)session.getAttribute("email");
              System.out.println("sessionEmail = " + sessionEmail);
              sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("sessionRights = " + sessionRights);
              int userIdSessionInt = (Integer)session.getAttribute("userId");
              System.out.println("userIdSessionInt = " + userIdSessionInt);                
              cycloIdString = (String)request.getParameter("cycloId");               
              cycloId = Integer.valueOf(cycloIdString).intValue();                 
              
              if(request.getParameter("userId") != null ) { 
                String userIdString = request.getParameter("userId");
                System.out.println("addCyclo.userIdString = " + userIdString);
                if(userIdString != null && userIdString.length() > 0)
                    userId = Integer.valueOf(userIdString).intValue();
                System.out.println("addCyclo.userId = " + userId);                
              }
              
              if(userId > 0 && sessionRights.equals("admin")) {
                  userIdSessionInt = userId;
              }

              
              if(cycloId > 0 && (sessionRights.equals("admin") ||  (sessionRights.equals("user") || sessionRights.equals("adminGroup"))  )) {
                  bRemove = true;
              } 

        
        if(bRemove) {
            CycloJavabean cycloJavabean = new CycloJavabean();
            cycloJavabean.remove(cycloId);
                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="cycloList" />
            </jsp:forward>
                <%
          } else
             out.print("uzivatel nema pravo na mazanie");               
         } else
             out.print("uzivatel nie je prihlaseny");          
           response.sendRedirect("index.jsp?page=cycloList");
        %> 
