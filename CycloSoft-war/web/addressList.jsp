<%--    
    Document   : addressList
    Created on : Mar 27, 2008, 12:33:20 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sk.syntax.cyclosoft.web.bean.AddressJavabean,
                 sk.syntax.cyclosoft.data.AddressList,
                 sk.syntax.cyclosoft.helper.Filter,                 
                 sk.syntax.cyclosoft.domain.Address"%>
       <h2 align = center>Address list</h2>
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

//teamId
            Object teamObjectAddressList = (Object)request.getParameter("teamId");
            int teamIdAddressList = 0;
            if(teamObjectAddressList != null) {
              if(!((String)teamObjectAddressList).equals("all"))  
                teamIdAddressList = Integer.valueOf((String)teamObjectAddressList).intValue();
            }
            System.out.println("addressList.teamString = " + teamObjectAddressList);
            System.out.println("addressList.teamId = " + teamIdAddressList);

 //paging
            Filter filter = new Filter();            
            filter.setRow(row);
            filter.setRowsPerPage(rowsPerPage);
            AddressList addressList =  null;
            if(teamIdAddressList == 0) {
                addressList =  addressJavabean.getAddressListPaging(filter);
            } else {
                filter.setTeamId(teamIdAddressList);
                addressList =  addressJavabean.getAddressListPagingTeam(filter);
            }
            rows = addressList.getRows();
            System.out.println("addressList.row = " + row);
            System.out.println("addressList.rows = " + rows);
            System.out.println("addressList.RowsPerPage = " + rowsPerPage);
            
            
            
            out.print("<div align = center><table border width = 100% >");            
            out.print("<tr class = header>");                                                
            out.print("<th>");                                                
            out.print("Email");
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Team");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Firstname");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Surname");                                                                
            out.print("</th>");
            out.print("<th>");                                                
            out.print("Action");                                                                
            out.print("</th>");
            out.print("</tr>");
            String encoding = "UTF-8";
            int rowNum =0;
            for(Address addressItem : addressList.getAddressList()) {
                int userIdAddressList = addressItem.getId();
                rowNum++;
                String className  = (rowNum % 2 == 0) ? "even":"odd";
                out.print("<tr class = "+className+" >");                                                                    
                out.print("<td>");
                out.print("<a href =index.jsp?page=addressDetail&userId="+userIdAddressList+">"+addressItem.getEmail()+"</a>");
                out.print("</td>");                               
                out.print("<td>");
                String teamView = (new String(addressItem.getTeam().getName(),encoding)).trim();
                out.print("<a href =index.jsp?page=addressList&teamId="+addressItem.getTeam().getId()+"&filter=show>"+teamView+"</a>");
                out.print("</td>");                               
                out.print("<td>");                              
                String firstnameView = new String(addressItem.getFirstname(),encoding);
                out.print(firstnameView);                
                out.print("</td>");                               
                out.print("<td>");                              
                String surnameView = new String(addressItem.getSurname(),encoding);
                out.print(surnameView);                                  
                out.print("</td>");                                               
                out.print("<td align = center>"); 
                String rights = addressItem.getRights().getName();
                if(session.getAttribute("email") != null)
                    if( (session.getAttribute("email").equals(addressItem.getEmail()) && (rights.equals("user") || rights.equals("adminGroup")) || bAdmin ) ) {
                        out.print("<a href=index.jsp?page=updateRegister&userId="+userIdAddressList+">");
                    }
                out.print("update");
                if(session.getAttribute("email") != null)
                    if( (session.getAttribute("email").equals(addressItem.getEmail()) && (rights.equals("user") || rights.equals("adminGroup")) || bAdmin ) ) {
                        out.print("</a>");
                    }
                out.print(" | ");
                if(session.getAttribute("email") != null)
                    if( (session.getAttribute("email").equals(addressItem.getEmail()) && (rights.equals("user") || rights.equals("adminGroup")) || bAdmin ) ) {
                        out.print("<a href=index.jsp?page=removeAddress&userId="+userIdAddressList+">");                
                    }
                out.print("remove");
                if(session.getAttribute("email") != null)
                    if( (session.getAttribute("email").equals(addressItem.getEmail()) && (rights.equals("user") || rights.equals("adminGroup")) || bAdmin ) ) {
                        out.print("</a>");
                    }
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
System.out.println("set addressList.edgeDown = " + edgeDown);           
System.out.println("set addressList.edgeUp = " + edgeUp);           
out.print("<p>");                          
            int previous = row - rowsPerPage;
            if(previous >= 0)
                out.print("<a href = index.jsp?page=addressList&row="+previous+"&teamId="+teamIdAddressList+">Previous&nbsp;&laquo;</a> | ");

            for(int i = edgeDown; i <= edgeUp; i = i + rowsPerPage) {
                    if(i != row )
                        out.print("<a href = index.jsp?page=addressList&row="+i+"&teamId="+teamIdAddressList+">");
                    out.print(i);
                    if(i != row )
                        out.print("</a>");
                      if(i <= (edgeUp - rowsPerPage))                    
                        out.print(" - ");
            }
            int next = row + rowsPerPage;
            if(next < rows)
                out.print(" | <a href = index.jsp?page=addressList&row="+next+"&teamId="+teamIdAddressList+">&raquo;&nbsp;Next</a>");
            
            
out.print("</p>");                          
}
        %>

    
