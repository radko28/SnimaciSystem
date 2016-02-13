/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import sk.syntax.cyclosoft.domain.Rights;

/**
 *
 * @author radko28
 */
@Stateless
public class RightsBean implements RightsRemote {
    @PersistenceContext(unitName="CycloSoft") 
    private EntityManager manager;
    
    public void add(Rights rights) {
        manager.persist(rights);        
    }
    
    public Rights getRights(int pKey) {
        String queryString = "from Rights where id = :pKey";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("pKey",pKey);                
        System.out.println("pKey = " + pKey);
        return (Rights)query.getSingleResult();        
    }
        
    public int getRights(String rightsName) {
        String queryString = "select id from Rights where name = :rightsName";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("rightsName",rightsName);                
        System.out.println("rightsName = " + rightsName);
        return (Integer)query.getSingleResult();        
    }     

}
