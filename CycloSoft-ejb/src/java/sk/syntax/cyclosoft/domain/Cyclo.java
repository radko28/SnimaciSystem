/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.domain;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author radko28
 */
@Entity
@Table(name="Cyclo")
public class Cyclo implements Serializable {
    private static final long serialVersionUID = 2L;
    private int id;
    private int userId;    
    private Date date;
    private Date time;
    private float veloce;
    private float distance;
    private String track;
    private String note;
    private float temperature;
    private int heart;
    private float maxVeloce;
    

    public void setId(int id) {
        this.id = id;
    }

    @Id
    @Column(name="id")        
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) id;
        return hash;
    }
    
    @Column(name="id_user")        
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    
    
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
    
    public float getVeloce() {
        return veloce; 
    }
    
    public void setVeloce(float veloce) {
        this.veloce = veloce; 
    }

    public float getDistance() {
        return distance; 
    }
    
    public void setDistance(float distance) {
        this.distance = distance; 
    }
    
    public String getTrack() {
        return track; 
    }
    
    public void setTrack(String track) {
        this.track = track; 
    }

    public String getNote() {
        return note; 
    }
    
    public void setNote(String note) {
        this.note = note; 
    }    
    
    public float getTemperature() {
        return temperature; 
    }
    
    public void setTemperature(float temperature) {
        this.temperature = temperature; 
    }    
    

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cyclo)) {
            return false;
        }
        Cyclo other = (Cyclo) object;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "sk.syntax.cyclosoft.domain.Cyclo[id=" + id + "]";
    }

    public int getHeart() {
        return heart;
    }

    public void setHeart(int heart) {
        this.heart = heart;
    }

    public float getMaxVeloce() {
        return maxVeloce;
    }

    public void setMaxVeloce(float maxVeloce) {
        this.maxVeloce = maxVeloce;
    }

}
