/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.bean;

import java.util.List;
import java.util.Properties;
import javax.naming.Context;
import sk.syntax.cyclosoft.domain.Cyclo;
import sk.syntax.cyclosoft.domain.CycloList;
import sk.syntax.cyclosoft.facade.CycloRemote;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
public class CycloJavabean {
    
    private CycloRemote sessionCyclo = null;
    
    public static Context getInitialContext() 
        throws javax.naming.NamingException 
    {
        Properties p = new Properties();
        p.put(Context.INITIAL_CONTEXT_FACTORY,"org.jnp.interfaces.NamingContextFactory");
        p.put(Context.URL_PKG_PREFIXES,"org.jboss.naming:org.jnp.interfaces");        
        p.put(Context.PROVIDER_URL,"jnp://localhost:1099");                
        
        
        return new javax.naming.InitialContext(p);
    }

    public CycloJavabean() {
        try {
         Context jndiContext = getInitialContext();
         Object ref = jndiContext.lookup("CycloBean/remote");
         sessionCyclo = (CycloRemote)ref;         
            
        } catch (Exception ex) {
            System.out.println("Couldn't create converter bean."+ ex.getMessage());
        }
    }
    
    public void add(Cyclo cyclo, int userId) {
        sessionCyclo.add(cyclo, userId);
    }
    public void modify(Cyclo cyclo) {
        sessionCyclo.modify(cyclo);
    }    
    
    public void remove(int pKey) {
        sessionCyclo.remove(pKey);
    }        
    
    public void removeAll(int userId) {
        sessionCyclo.removeAll(userId);
    }
    public Cyclo getCyclo(int pKey) {
        return sessionCyclo.getCyclo(pKey);
    }
    public CycloList getCycloList(Filter filter) {
        return sessionCyclo.getCycloList(filter);
    }
    
    public List<String> getTrackList() {
        return sessionCyclo.getTrackList();
    }
    
    public int getMaxYear(int userId) {
        return sessionCyclo.getMaxYear(userId);
    }
    
    public int getMinYear(int userId) {
        return sessionCyclo.getMinYear(userId);
    }
    
    public int getMaxYear() {
        return sessionCyclo.getMaxYear();
    }
    
    public int getMinYear() {
        return sessionCyclo.getMinYear();
    }
    
    
}
