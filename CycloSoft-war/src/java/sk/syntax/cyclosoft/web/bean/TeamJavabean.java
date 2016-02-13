/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.bean;


import java.util.List;
import java.util.Properties;
import javax.naming.Context;
import sk.syntax.cyclosoft.data.TeamList;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.facade.TeamRemote;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
public class TeamJavabean {
    
    private TeamRemote sessionTeam = null;
    
    public static Context getInitialContext() 
        throws javax.naming.NamingException 
    {
        Properties p = new Properties();
        p.put(Context.INITIAL_CONTEXT_FACTORY,"org.jnp.interfaces.NamingContextFactory");
        p.put(Context.URL_PKG_PREFIXES,"org.jboss.naming:org.jnp.interfaces");        
        p.put(Context.PROVIDER_URL,"jnp://localhost:1099");                
        
        
        return new javax.naming.InitialContext(p);
    }
    public TeamJavabean() {
        try {
         Context jndiContext = getInitialContext();
         Object ref = jndiContext.lookup("TeamBean/remote");
         sessionTeam = (TeamRemote)ref;         
            
        } catch (Exception ex) {
            System.out.println("Couldn't create converter bean."+ ex.getMessage());
        }
    }
    

    public void add(Team team) {
        sessionTeam.add(team);
    }
    public void modify(Team team) {
        sessionTeam.modify(team);
    }    
    public void remove(int pKey) {
        sessionTeam.remove(pKey);
    }        
    public Team getTeam(int pKey) {
        return sessionTeam.getTeam(pKey);
    }    
    
    public int getTeam(byte[] name) throws Exception {
        return sessionTeam.getTeam(name);
    }    
    
    public TeamList getTeamList(Filter filter) {
        return sessionTeam.getTeamList(filter);
    }

     public List getTeamList() {
        return sessionTeam.getTeamList();
    }

}
