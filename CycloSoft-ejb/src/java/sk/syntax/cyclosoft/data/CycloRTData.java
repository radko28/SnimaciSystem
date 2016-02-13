/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.data;

import java.io.Serializable;
import java.util.Date;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.domain.Team;

/**
 *
 * @author radko28
 */
public class CycloRTData implements Serializable {
    private Team team;
    private Address address;
    private float veloce;
    private float distance;
    private String track;
    private int heart;
    private float maxVeloce;
    private Date time;
    private float latitude;
    private float longitude;
    


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

    public String getTrack() {
        return track;
    }

    public void setTrack(String track) {
        this.track = track;
    }

    public float getDistance() {
        return distance;
    }

    public void setDistance(float distance) {
        this.distance = distance;
    }

    public float getVeloce() {
        return veloce;
    }

    public void setVeloce(float veloce) {
        this.veloce = veloce;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    
    
}
