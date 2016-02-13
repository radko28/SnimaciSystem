/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author radko28
 */
@Entity
@Table(name="Address")
public class Address implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String email;
    private String password;
    private byte[] firstname;
    private byte[] surname;
    private String mobil;
    private byte[] city;
    private byte[] street;    
    private String zip;
    private String pic;
    private String web;
    private int log;
    private Collection<Cyclo> cyclo = new ArrayList<Cyclo>();
    private Collection<CycloRT> cycloRT = new ArrayList<CycloRT>();
    private Team team;
    private Rights rights;    
    private int weight;    
    private int height;        
    private String sex;            
    private boolean rtflag;


    

    public void setId(int id) {
        this.id = id;
    }

    @Id
    @Column(name="id")    
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }
    
        @Column(name="email")
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    @Column(name="log")
    public int getLog() {
        return log;
    }
    
    public void setLog(int log) {
        this.log = log;
    }
    
    @Column(name="password")    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Column(name="firstname")    
    public byte[] getFirstname() {
        return firstname;
    }
    
    public void setFirstname(byte[] firstname) {
        this.firstname = firstname;
    }
    
    @Column(name="surname")    
    public byte[] getSurname() {
        return surname;
    }
    
    public void setSurname(byte[] surname) {
       this.surname = surname;
    }

    @Column(name="mobil")    
    public String getMobil() {
        return mobil;
    }
    
    public void setMobil(String mobil) {
        this.mobil = mobil;
    }
    

    @Column(name="city")    
    public byte[] getCity() {
        return city;
    }
    
     public void setCity(byte[] city) {
        this.city = city;
    }
     
    @Column(name="street")    
    public byte[] getStreet() {
        return street;
    }
    
     public void setStreet(byte[] street) {
        this.street = street;
    }
     
    
    @Column(name="zip")    
    public String getZip() {
        return zip;
    }
    
    public void setZip(String zip) {
        this.zip = zip;
    }
    
    
    @Column(name="pic")    
    public String getPic() {
        return pic;
    }
    
     public void setPic(String pic) {
        this.pic = pic;
    }

    
    @Column(name="web")    
    public String getWeb() {
        return web;
    }
    
    public void setWeb(String web) {
        this.web = web;
    }
    
    @OneToMany(cascade={CascadeType.ALL})
    @JoinColumn(name="id_user")
    public Collection<Cyclo> getCyclo() {
        return cyclo;
    }
    
    public void setCyclo(Collection<Cyclo> cyclo) {
        this.cyclo = cyclo;
    }
    
    
    @OneToMany(cascade={CascadeType.ALL})
    @JoinColumn(name="id_user")
    public Collection<CycloRT> getCycloRT() {
        return cycloRT;
    }
    
    public void setCycloRT(Collection<CycloRT> cycloRT) {
        this.cycloRT = cycloRT;
    }

    @ManyToOne()
    @JoinColumn(name="id_team")
    public Team getTeam() {
        return team;
    }

    public void setTeam(Team team) {
        this.team = team;
    }
    
    @ManyToOne()
    @JoinColumn(name="id_rights")
    public Rights getRights() {
        return rights;
    }

    public void setRights(Rights rights) {
        this.rights = rights;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) id;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Address)) {
            return false;
        }
        Address other = (Address) object;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "sk.syntax.cyclosoft.domain.Address[id=" + id + "]";
    }
    @Column(name="weight",nullable = false)    
    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
    @Column(name="height")        
    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }
    @Column(name="rtflag")    
    public boolean isRtflag() {
        return rtflag;
    }

    public void setRtflag(boolean rtflag) {
        this.rtflag = rtflag;
    }
    @Column(name="sex")    
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
    

}
