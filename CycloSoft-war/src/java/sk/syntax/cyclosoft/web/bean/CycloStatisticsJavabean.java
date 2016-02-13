/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.bean;

import java.util.ArrayList;
import java.util.Properties;
import javax.naming.Context;
import sk.syntax.cyclosoft.data.Ladder;
import sk.syntax.cyclosoft.data.LadderList;
import sk.syntax.cyclosoft.facade.CycloStatisticsRemote;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
public class CycloStatisticsJavabean {
    
    private CycloStatisticsRemote sessionCycloStatistics = null;
    
    public static Context getInitialContext() 
        throws javax.naming.NamingException 
    {
        Properties p = new Properties();
        p.put(Context.INITIAL_CONTEXT_FACTORY,"org.jnp.interfaces.NamingContextFactory");
        p.put(Context.URL_PKG_PREFIXES,"org.jboss.naming:org.jnp.interfaces");        
        p.put(Context.PROVIDER_URL,"jnp://localhost:1099");                
        
        
        return new javax.naming.InitialContext(p);
    }

    public CycloStatisticsJavabean() {
        try {
         Context jndiContext = getInitialContext();
         Object ref = jndiContext.lookup("CycloStatisticsBean/remote");
         sessionCycloStatistics = (CycloStatisticsRemote)ref;         
            
        } catch (Exception ex) {
            System.out.println("Couldn't create converter bean."+ ex.getMessage());
        }
    }

    
    /**
 *Rebrik cyklistov samostatne
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getCycloLadder(Filter filter) throws Exception {
        return sessionCycloStatistics.getCycloLadder(filter);        
    }
/**
 *Rebrik cyklistov v time
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getTeamLadder(Filter filter) throws Exception {
        return sessionCycloStatistics.getTeamLadder(filter);
    }
    
    
/**
 *Rebrik timov
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getTeamsLadder(Filter filter) {
        return sessionCycloStatistics.getTeamsLadder(filter);
    }    


}
