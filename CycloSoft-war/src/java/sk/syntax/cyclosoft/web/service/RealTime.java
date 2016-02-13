/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.service;

import java.io.*;
import java.net.*;

import javax.servlet.*;
import javax.servlet.http.*;
import sk.syntax.cyclosoft.web.bean.CycloRTJavabean;
import sk.syntax.cyclosoft.web.data.CycloRTValueObject;
import sk.syntax.cyclosoft.web.helper.ServletHelper;

/**
 *
 * @author radko28
 */
public class RealTime extends HttpServlet {
    private CycloRTValueObject cycloRTValueObject = null;
    private CycloRTJavabean cycloRTJavabean = null;
   
    /** 
    * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
    * @param request servlet request
    * @param response servlet response
    */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        System.out.println("RealTime servlet");
        String action = request.getParameter("action");
        String idString = request.getParameter("id");
        int id = 0;
        if(idString != null && idString.length() > 0) {
            id = Integer.parseInt(idString);
        }
        
        String userIdString = request.getParameter("userid");
        int userId = 0;
        if(userIdString != null && userIdString.length() > 0) {
            userId = Integer.parseInt(userIdString);
        }

    /*private Date date;
    private Date time;*/
        String veloceString = request.getParameter("veloce");
        float veloce = 0;
        if(veloceString != null && veloceString.length() > 0) {
            veloce = Float.parseFloat(veloceString);
        }
        String distanceString = request.getParameter("distance");
        float distance = 0;
        if(distanceString != null && distanceString.length() > 0) {
            distance = Float.parseFloat(distanceString);
        }
        String track = request.getParameter("track");
        String note = request.getParameter("note");
        String temperatureString = request.getParameter("temperature");
        float temperature = 0;
        if(temperatureString != null && temperatureString.length() > 0) {
            temperature = Float.parseFloat(temperatureString);
        }
        String latitudeString = request.getParameter("latitude");
        float latitude = 0;
        if(latitudeString != null && latitudeString.length() > 0) {
            latitude = Float.parseFloat(latitudeString);
        }
        String longitudeString = request.getParameter("longitude");
        float longitude = 0;
        if(longitudeString != null && longitudeString.length() > 0) {
            longitude = Float.parseFloat(longitudeString);
        }
        cycloRTValueObject.setId(id);
        cycloRTValueObject.setUserId(userId);
        cycloRTValueObject.setVeloce(veloce);
        cycloRTValueObject.setDistance(distance);
                
        System.out.println("RealTime servlet :" + action);
        if(action != null && action.equals("add")) {
           System.out.println("RealTime servlet : add");
           add(cycloRTValueObject);
        } else if(action != null && action.equals("modify")) {
           System.out.println("RealTime servlet : modify");
           modify(cycloRTValueObject);
        } else if(action != null && action.equals("end")) {
           System.out.println("RealTime servlet : end");
           end(userId);
        }
    }

    public RealTime() {
        cycloRTValueObject = new CycloRTValueObject();
        cycloRTJavabean = new CycloRTJavabean();
    }
    
    private void add(CycloRTValueObject cycloRTValueObject) {
        cycloRTJavabean.add(ServletHelper.cycloRTValueObjectToCycloRT(cycloRTValueObject));
    }
    
    private void modify(CycloRTValueObject cycloRTValueObject) {
        cycloRTJavabean.modify(ServletHelper.cycloRTValueObjectToCycloRT(cycloRTValueObject));
    }
    
    private void end(int userId) {
        cycloRTJavabean.end(userId);
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
    * Handles the HTTP <code>GET</code> method.
    * @param request servlet request
    * @param response servlet response
    */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
    * Handles the HTTP <code>POST</code> method.
    * @param request servlet request
    * @param response servlet response
    */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
    * Returns a short description of the servlet.
    */
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
