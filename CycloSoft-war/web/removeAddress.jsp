<%-- 
    Document   : removeAddress
    Created on : Mar 27, 2008, 12:35:26 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.CycloJavabean,
sk.syntax.cyclosoft.web.bean.AddressJavabean,
java.io.File
"%> 
        <%
        boolean bRemove = false;
        boolean bRemoveSession = false;
        int userId = 0;
          AddressJavabean addressJavabean = new AddressJavabean();                
          if(session.getAttribute("email") != null && session.getAttribute("userId") != null) {          
              String sessionEmail = (String)session.getAttribute("email");
              System.out.println("sessionEmail = " + sessionEmail);
              String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
              System.out.println("sessionRights = " + sessionRights);
              
              
              String userIdString = request.getParameter("userId");
                System.out.println("userIdString = " + userIdString);
                userId = Integer.valueOf(userIdString).intValue();
                System.out.println("userId = " + userId);                
                int userIdSessionInt = (Integer)session.getAttribute("userId");
                System.out.println("userIdSessionInt = " + userIdSessionInt);                
                if(userId == userIdSessionInt) 
                   bRemoveSession = true;
                   
              if(sessionRights.equals("admin") || (userId == userIdSessionInt) && (sessionRights.equals("user") || sessionRights.equals("adminGroup"))  ) {
                  bRemove = true;
              } 
             if(bRemove) {
//delete cyclo                     
                    CycloJavabean cycloJavabean = new CycloJavabean();
                    cycloJavabean.removeAll(userId);
                    String pic = addressJavabean.getAddress(userId).getPic();
//delete address                                                 
                    addressJavabean.remove(userId);
                    String dirName = "/home/radko28/images/";
                     File oldFile = new File(dirName + pic);
                     if(oldFile != null && oldFile.exists()) {
                         boolean success = false;
                         success = oldFile.delete();
                         if (success) {
                             System.out.print(dirName + pic + " has been deleted.");
                         } else                                
                             System.out.print(dirName + pic + " has not been deleted.");                                    
                    }
                    if(bRemoveSession) {
                        session.removeAttribute("userId");
                        session.removeAttribute("email");
                    }
//redirect index.jsp
                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="addressList" />
            </jsp:forward>
                <%
                 } else 
                     out.print("uzivatel nema pravo na mazanie");
 } else
     out.print("uzivatel nie je prihlaseny");
        %>
