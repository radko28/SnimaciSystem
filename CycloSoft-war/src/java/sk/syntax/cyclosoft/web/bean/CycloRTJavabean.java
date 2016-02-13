/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.bean;

import java.util.Properties;
import javax.naming.Context;
import sk.syntax.cyclosoft.data.CycloRTList;
import sk.syntax.cyclosoft.domain.CycloRT;
import sk.syntax.cyclosoft.facade.CycloRTRemote;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
public class CycloRTJavabean {
    
    private CycloRTRemote sessionCycloRT = null;
    
    public static Context getInitialContext() 
        throws javax.naming.NamingException 
    {
        Properties p = new Properties();
        p.put(Context.INITIAL_CONTEXT_FACTORY,"org.jnp.interfaces.NamingContextFactory");
        p.put(Context.URL_PKG_PREFIXES,"org.jboss.naming:org.jnp.interfaces");        
        p.put(Context.PROVIDER_URL,"jnp://localhost:1099");                
        
        
        return new javax.naming.InitialContext(p);
    }

    public CycloRTJavabean() {
        try {
         Context jndiContext = getInitialContext();
         Object ref = jndiContext.lookup("CycloRTBean/remote");
         sessionCycloRT = (CycloRTRemote)ref;         
            
        } catch (Exception ex) {
            System.out.println("Couldn't create converter bean."+ ex.getMessage());
        }
    }
    
/**
 * Pridanie do CycloRT. 
 */    
    public void add(CycloRT cycloRT) {
        sessionCycloRT.add(cycloRT);
    }
/**
 *Prepis CycloRT. 
 */
    public void modify(CycloRT cycloRT) {
        sessionCycloRT.modify(cycloRT);
    }    
/**
 * Kopirovanie do Cyclo.
 */    
    public void end(int userId) {
        sessionCycloRT.end(userId);
    }        
/**
 * zoznam RT cyklistov
 * @return
 */
    public CycloRTList getCycloList(Filter filter) throws Exception {
        return sessionCycloRT.getCycloList(filter);
    }    
/**
 * detail RT cyklistu
 * @param pKey
 * @return
 */    
    public CycloRT getCyclo(int userId) {
        return sessionCycloRT.getCyclo(userId);
    }        

}
