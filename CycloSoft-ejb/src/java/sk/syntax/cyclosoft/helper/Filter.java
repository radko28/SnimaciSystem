/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.helper;

import java.io.Serializable;

/**
 *
 * @author radko28
 */
public class Filter extends Paging implements Serializable {
    private int id = 0;
    private int teamId = 0;
    private String yearFrom = "";
    private String monthFrom = "";
    private String yearTo = "";
    private String monthTo = "";
    private float veloceFrom = 0.0F; 
    private float veloceTo = 0.0F;    
    private float distanceFrom = 0.0F;
    private float distanceTo = 0.0F;    
    private String track = "";
//0 - veloce, 1 - distance, 2 - trainning, 3- date, 4 - time
    private int sortBy = 0;
//asc, desc    
    private String order ="";
    private boolean rtflag;

    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getTeamId() {
        return teamId;
    }
    
    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public String getYearFrom() {
        return yearFrom;
    }
    
     public void setYearFrom(String yearFrom) {
        this.yearFrom = yearFrom;
    }
     
    public String getYearTo() {
        return yearTo;
    }
    
     public void setYearTo(String yearTo) {
        this.yearTo = yearTo;
    }

     
    public String getMonthFrom() {
        return monthFrom;
    }
    
     public void setMonthFrom(String monthFrom) {
        this.monthFrom = monthFrom;
    }
     
    public String getMonthTo() {
        return monthTo;
    }
    
     public void setMonthTo(String monthTo) {
        this.monthTo = monthTo;
    }


    public float getVeloceFrom() {
        return veloceFrom;
    }
    
     public void setVeloceFrom(float veloceFrom) {
        this.veloceFrom = veloceFrom;
    }

    public float getVeloceTo() {
        return veloceTo;
    }
    
     public void setVeloceTo(float veloceTo) {
        this.veloceTo = veloceTo;
    }

    public float getDistanceFrom() {
        return distanceFrom;
    }
    
     public void setDistanceFrom(float distanceFrom) {
        this.distanceFrom = distanceFrom;
    }
     
    public float getDistanceTo() {
        return distanceTo;
    }
    
     public void setDistanceTo(float distanceTo) {
        this.distanceTo = distanceTo;
    }

    public String getTrack() {
        return track;
    }
    
     public void setTrack(String track) {
        this.track = track;
    }
     
    public int getSortBy() {
        return sortBy;
    }
    
     public void setSortBy(int sortBy) {
        this.sortBy = sortBy;
    }

    /**
     * @return the order
     */
    public String getOrder() {
        return order;
    }

    /**
     * @param order the order to set
     */
    public void setOrder(String order) {
        this.order = order;
    }

    public boolean isRtflag() {
        return rtflag;
    }

    public void setRtflag(boolean rtflag) {
        this.rtflag = rtflag;
    }
     
    
     
}
