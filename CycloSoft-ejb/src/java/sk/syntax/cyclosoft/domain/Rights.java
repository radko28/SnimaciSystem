/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.domain;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author radko28
 */
@Entity
public class Rights implements Serializable {
    private static final long serialVersionUID = 8L;
    private int id;
    private String name;        

    public void setId(int id) {
        this.id = id;
    }

    @Id
    @Column(name="id")        
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
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
        if (!(object instanceof Rights)) {
            return false;
        }
        Rights other = (Rights) object;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "sk.syntax.cyclosoft.domain.Rights[id=" + id + "]";
    }

}
