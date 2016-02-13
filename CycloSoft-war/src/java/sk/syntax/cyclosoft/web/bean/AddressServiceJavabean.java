/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.bean;

import java.util.Properties;
import javax.naming.Context;
import sk.syntax.cyclosoft.facade.AddressServiceRemote;


/**
 *
 * @author radko28
 */
public class AddressServiceJavabean {
        private AddressServiceRemote sessionAddressService = null;
    
    public static Context getInitialContext() 
        throws javax.naming.NamingException 
    {
        Properties p = new Properties();
        p.put(Context.INITIAL_CONTEXT_FACTORY,"org.jnp.interfaces.NamingContextFactory");
        p.put(Context.URL_PKG_PREFIXES,"org.jboss.naming:org.jnp.interfaces");        
        p.put(Context.PROVIDER_URL,"jnp://localhost:1099");                
        
        
        return new javax.naming.InitialContext(p);
    }

    public AddressServiceJavabean() {
        try {
         Context jndiContext = getInitialContext();
         Object ref = jndiContext.lookup("AddressServiceBean/remote");
         sessionAddressService = (AddressServiceRemote)ref;         
            
        } catch (Exception ex) {
            System.out.println("Couldn't create converter bean."+ ex.getMessage());
        }
    }

    
    public boolean forgetPassword(String email) throws Exception {
        return sessionAddressService.forgetPassword(email);
    }
    
    public boolean registerUser(String email) throws Exception {
        return sessionAddressService.registerUser(email);
    }
    
    public boolean changePassword(String email) throws Exception {
        return sessionAddressService.changePassword(email);
    }

}
