/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.data;

/**
 *
 * @author radko28
 */
import sk.syntax.cyclosoft.domain.Address;
import java.io.Serializable;
import java.util.Date;
import sk.syntax.cyclosoft.domain.Team;

public class Ladder implements Serializable {
    private Address address;
    private Team team;    
    private double veloce;
    private double distance;
    private Long training;
    private Date date;
    private Date time;
    private String track;
    private String note;
    private double temperature;
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getTrack() {
        return track;
    }

    public void setTrack(String track) {
        this.track = track;
    }
    
    public Address getAddress() {
        return address;
    }
    
     public void setAddress(Address address) {
        this.address = address;
    }
     
    public Team getTeam() {
        return team;
    }
    
     public void setTeam(Team team) {
        this.team = team;
    }
     
     public double getVeloce() {
         return veloce;
     }

      public void setVeloce(double veloce) {
         this.veloce = veloce;
     }
      
      public double getDistance() {
         return distance;
     }

      public void setDistance(double distance) {
         this.distance = distance;
     }

      public Long getTraining() {
         return training;
     }

      public void setTraining(Long training) {
         this.training = training;
     }

}
