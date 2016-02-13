<%-- 
    Document   : updateCyclo
    Created on : Mar 27, 2008, 12:36:10 AM
    Author     : radko28
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.text.SimpleDateFormat,
                 sk.syntax.cyclosoft.web.bean.CycloJavabean, 
                 sk.syntax.cyclosoft.web.bean.AddressJavabean,                  
                 sk.syntax.cyclosoft.domain.Cyclo,
                 sk.syntax.cyclosoft.web.helper.Validation,
                 sk.syntax.cyclosoft.web.helper.FileUtil,
                 java.util.Map,
                 java.util.HashMap,
                 java.util.Date"%> 
<div align = center>      
        <h2>Update cyclo</h2>
        <% 
            boolean bUpdateCyclo = true;
            boolean bUpdateCycloSession = false;
            Date date = null;
            Date time = null;
            float veloce = 0F;
            float distance = 0F;                       
            float temperature = 0F;
            String note = "";
            String track = "";
            Cyclo cyclo = null;            
            String dateString = "";
            String timeString = "";
            String veloceString = "";
            String distanceString = "";
            String temperatureString = "";
             boolean isValid = false;
             boolean isValidMin = true;

            int userId = 0;

          String cycloIdString = "";
          int cycloId = 0;
          FileUtil fileUtil = new FileUtil();
          if(request.getParameter("cycloId") != null && session.getAttribute("email") != null && session.getAttribute("userId") != null) {
            Map<String,String> validCss = new HashMap();
            Map<String,String> validMsg = new HashMap();
            validMsg.put("date", "");
            validMsg.put("time", "");
            validMsg.put("veloce", "");
            validMsg.put("distance", "");
            validMsg.put("track", "");
            validMsg.put("note", "");
            validMsg.put("temperature", "");

              AddressJavabean addressJavabean = new AddressJavabean();                              
              String sessionEmail = (String)session.getAttribute("email");
              System.out.println("sessionEmail = " + sessionEmail);
              String sessionRights = addressJavabean.getAddress(sessionEmail).getRights().getName();
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
                  bUpdateCycloSession = true;
              } 

            if(bUpdateCycloSession) {
            SimpleDateFormat sDateFormat = new SimpleDateFormat("dd-MM-yyyy");            
            SimpleDateFormat sTimeFormat = new SimpleDateFormat("HH:mm:ss");                            
            CycloJavabean cycloJavabean = new CycloJavabean();                    
            String updateCyclo = (String)request.getParameter("updateCyclo");                    
            System.out.println("updateCyclo = " + updateCyclo);            
            if(updateCyclo !=null && updateCyclo.length() > 0 && updateCyclo.equals("submit")) {
//validacia
//date
                System.out.println("dateString =" +request.getParameter("date"));
                if(request.getParameter("date") != null &&  Validation.validateRegex((String)request.getParameter("date"), "(\\d{1,2})-(\\d{1,2})-(\\d{4})")) {
                    isValid = isValid || true;
                    dateString = (String)request.getParameter("date");
                    date = sDateFormat.parse(dateString);
                } else {
                    isValid = isValid && false;
                    validCss.put("date", "class=error");
                    validMsg.put("date", fileUtil.getResourceValue("addcyclo.date"));
                }
                System.out.println("addCyclo.date isValid = " + isValid);
                System.out.println("date =" +date);
//time
                System.out.println("timeString =" + request.getParameter("time"));
                if(request.getParameter("time") != null &&  Validation.validateRegex((String)request.getParameter("time"), "(\\d{1,2}):(\\d{2}):(\\d{2})")) {
                    isValid = isValid && true;
                    timeString = (String)request.getParameter("time");
                    time = sTimeFormat.parse(timeString);
                } else {
                    isValid = isValid && false;
                    validCss.put("time", "class=error");
                    validMsg.put("time", fileUtil.getResourceValue("addcyclo.time"));
                }
                System.out.println("addCyclo.time isValid = " + isValid);
                System.out.println("time =" +time);
//veloce
                System.out.println("veloceString = "+request.getParameter("veloce"));
                if(request.getParameter("veloce") != null &&  Validation.validateRegex((String)request.getParameter("veloce"), "(\\d{2}).(\\d{1,2})")) {
                    isValid = isValid && true;
                    veloceString = (String)request.getParameter("veloce");
                    veloce = Float.parseFloat(veloceString);
                } else {
                    isValid = isValid && false;
                    validCss.put("veloce", "class=error");
                    validMsg.put("veloce", fileUtil.getResourceValue("addcyclo.veloce"));
                }
                System.out.println("addCyclo.veloce isValid = " + isValid);
                System.out.println("veloce = "+veloce);
//distance
                System.out.println("distanceString = "+request.getParameter("distance"));
                if(request.getParameter("distance") != null &&  Validation.validateRegex((String)request.getParameter("distance"), "(\\d{2}).(\\d{1,2})")) {
                    isValid = isValid && true;
                    distanceString = (String)request.getParameter("distance");
                    distance = Float.parseFloat(distanceString);
                } else {
                    isValid = isValid && false;
                    validCss.put("distance", "class=error");
                    validMsg.put("distance", fileUtil.getResourceValue("addcyclo.distance"));
                }
                System.out.println("addCyclo.distance isValid = " + isValid);
                System.out.println("distance = "+distance);
//track
                track = (String)request.getParameter("track");
                System.out.println("track = "+track);
                if(track != null &&  track.length() > 0) {
                    if(track.length() <= 128) {
                        isValid = isValid && true;
                    } else {
                        isValid = isValid && false;
                        validCss.put("track", "class=error");
                        validMsg.put("track", fileUtil.getResourceValue("addcyclo.track"));
                    }
                 } else {
                    isValid = isValid && false;
                    validCss.put("track", "class=error");
                    validMsg.put("track", "chybny vstup");
                 }
                System.out.println("addCyclo.track isValid = " + isValid);
                System.out.println("track = "+track);
//temperature
                System.out.println("temperatureString = "+temperatureString);
                if(request.getParameter("temperature") != null &&  ((String)request.getParameter("temperature")).length() > 0 )
                    if(Validation.validateRegex(request.getParameter("temperature"), "\\d{1,2}.\\d{1}")) {
                        isValidMin = isValidMin && true;
                        temperatureString = (String)request.getParameter("temperature");
                        temperature = Float.parseFloat(temperatureString);
                    } else {
                        isValidMin = isValidMin && false;
                        validCss.put("temperature", "class=error");
                        validMsg.put("temperature", fileUtil.getResourceValue("addcyclo.temperature"));
                    }

                System.out.println("addCyclo.temperature isValidMin = " + isValidMin);
                System.out.println("temperature = "+temperature);
//note
                note = (String)request.getParameter("note");
                System.out.println("note = "+note);
                if(note != null &&  note.length() > 0)
                    if(note.length() <= 128) {
                        isValidMin = isValidMin && true;
                    } else {
                        isValidMin = isValidMin && false;
                        validCss.put("note", "class=error");
                        validMsg.put("note", fileUtil.getResourceValue("addcyclo.note"));
                    }
                System.out.println("addCyclo.note isValidMin = " + isValidMin);

                if(isValid && isValidMin) {
                    cyclo = new Cyclo();
                    cyclo.setDate(date);
                    cyclo.setTime(time);
                    cyclo.setVeloce(veloce);
                    cyclo.setDistance(distance);
                    cyclo.setTrack(track);
                    cyclo.setTemperature(temperature);
                    cyclo.setNote(note);
                    cyclo.setId(cycloId);
                    cyclo.setUserId(userIdSessionInt);
                    cycloJavabean.modify(cyclo);
                    bUpdateCyclo = false;

                %>
            <jsp:forward page="index.jsp">
                <jsp:param name="page" value="cycloList" />
            </jsp:forward>
                <%
                } else {
                    bUpdateCyclo = true;
                }
             } else {
                 cyclo = cycloJavabean.getCyclo(cycloId);
                 date = cyclo.getDate();
                 dateString = sDateFormat.format(date);
                 time = cyclo.getTime();
                 timeString = sTimeFormat.format(time);
                 veloce = cyclo.getVeloce();
                 veloceString = String.valueOf(veloce);
                 distance = cyclo.getDistance();
                 distanceString = String.valueOf(distance);
                 track = cyclo.getTrack();                 
                 temperature = cyclo.getTemperature();
                 temperatureString = String.valueOf(temperature);
                 note = cyclo.getNote();
                 bUpdateCyclo = true;
              }
             if(bUpdateCyclo) {
//valid messages
out.print("<table>");   
         out.print("<tr "+validCss.get("date")+" ><td  align= left >"+validMsg.get("date")+"</td></tr>");                         
         out.print("<tr "+validCss.get("time")+" ><td  align= left >"+validMsg.get("time")+"</td></tr>");                         
         out.print("<tr "+validCss.get("distance")+" ><td  align= left >"+validMsg.get("distance")+"</td></tr>");                         
         out.print("<tr "+validCss.get("veloce")+" ><td  align= left >"+validMsg.get("veloce")+"</td></tr>");                         
         out.print("<tr "+validCss.get("track")+" ><td  align= left >"+validMsg.get("track")+"</td></tr>");                         
         out.print("<tr "+validCss.get("temperature")+" ><td  align= left >"+validMsg.get("temperature")+"</td></tr>");                         
         out.print("<tr "+validCss.get("note")+" ><td  align= left >"+validMsg.get("note")+"</td></tr>");                         

         
out.print("</table>");            
                
//form                      
                 
                out.print("<form action=index.jsp method = POST>");
                out.print("<table>");
                out.print("<tr "+validCss.get("date")+" ><th align=left >Date*</th><td align=right ><input type = text name = date value = '"+ dateString +"' /></td></tr>");
                out.print("<tr "+validCss.get("time")+" ><th align=left>Time*</th><td align=right><input type = text name =time value = '"+ timeString +"'/></td></tr>");
                out.print("<tr "+validCss.get("veloce")+" ><th align=left>Veloce*</th><td align=right><input type = text name =veloce value = '"+ veloceString +"'/></td></tr>");
                out.print("<tr "+validCss.get("distance")+" ><th align=left>Distance*</th><td align=right><input type = text name =distance value = '"+ distanceString +"'/></td></tr>");
                out.print("<tr "+validCss.get("track")+" ><th align=left>Track*</th><td align=right><input type = text name =track value = '"+ track +"'/></td></tr>");
                out.print("<tr "+validCss.get("temperature")+" ><th align=left>Temperature</th><td align=right><input type = text name =temperature value = '"+ temperatureString +"'/></td><td>"+validMsg.get("temperature")+"</td></tr>");
                out.print("<tr "+validCss.get("note")+" ><th align=left>Note</th><td align=right><input type = text name =note value = '"+ note +"'/></td></tr>");
            out.print("<tr><td colspan =2 class = oznam >hodnoty vyznacene hviezdickou* su povinne</td></tr>");                                                 
                    out.print("<tr><td align=right colspan=2 ><input type = submit value = Update /></td></tr>");
                    out.print("</table>");
                    out.print("<input type = hidden name = cycloId value = '"+ cycloIdString +"' />");
                    out.print("<input type = hidden name = userId value = '"+ userIdSessionInt +"' />");
                    out.print("<input type = hidden name = page value = updateCyclo />");
                    out.print("<input type = hidden name = updateCyclo value = submit />");
                out.print("</form>");
                 }
            } else
             out.print("uzivatel nema pravo na mazanie");               
            } else
               out.print("uzivatel nie je prihlaseny");          
                    
                    %>
</div>