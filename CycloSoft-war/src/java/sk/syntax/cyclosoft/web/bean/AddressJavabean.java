/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.bean;

import java.util.List;
import java.util.Properties;
import javax.naming.Context;
import sk.syntax.cyclosoft.data.AddressList;
import sk.syntax.cyclosoft.data.TeamList;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.facade.AddressRemote;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
public class AddressJavabean {
    private AddressRemote sessionAddress = null;
    
    public static Context getInitialContext() 
        throws javax.naming.NamingException 
    {
        Properties p = new Properties();
        p.put(Context.INITIAL_CONTEXT_FACTORY,"org.jnp.interfaces.NamingContextFactory");
        p.put(Context.URL_PKG_PREFIXES,"org.jboss.naming:org.jnp.interfaces");        
        p.put(Context.PROVIDER_URL,"jnp://localhost:1099");                
        
        
        return new javax.naming.InitialContext(p);
    }

    public AddressJavabean() {
        try {
         Context jndiContext = getInitialContext();
         Object ref = jndiContext.lookup("AddressBean/remote");
         sessionAddress = (AddressRemote)ref;         
            
        } catch (Exception ex) {
            System.out.println("Couldn't create converter bean."+ ex.getMessage());
        }
    }
    
    
    public void register(Address address) {
        sessionAddress.register(address);
        
    }
    public void registerUpdate(Address address) {
        sessionAddress.registerUpdate(address);
        
    }    
    public void remove(int pKey) {
        sessionAddress.remove(pKey);
        
    }        
    public int login(Address address) throws Exception {
        return sessionAddress.login(address);
        
    }                
    public void logout(int pKey) {
        sessionAddress.logout(pKey);
        
    }             
    public TeamList getTeamList(Filter filter) {
        return sessionAddress.getTeamList(filter);
    }

    public List getTeamList() {
        return sessionAddress.getTeamList();
    }

    public AddressList getAddressByTeamList(Filter filter) {
        return sessionAddress.getAddressByTeamList(filter);
        
    }    
    public AddressList getAddressList(Filter filter,String table) throws Exception {
        return sessionAddress.getAddressList(filter,table);
        
    }
    public AddressList getAddressListPaging(Filter filter) {
        return sessionAddress.getAddressListPaging(filter);
        
    }

    public AddressList getAddressListPagingTeam(Filter filter) throws Exception {
        return sessionAddress.getAddressListPagingTeam(filter);

    }

    
    public Address getAddress(int pKey) {
        return sessionAddress.getAddress(pKey);
        
    }         
    
    public Address getAddress(String email) throws Exception {
        return sessionAddress.getAddress(email);
        
    }         
    
    
    public void addTeamToAddress(int teamId, int addressId) {
        sessionAddress.addTeamToAddress(teamId, addressId);
    }
    
    public void addRightsToAddress(String rights, int addressId) {
        sessionAddress.addRightsToAddress(rights, addressId);
    }
   
    
    public boolean isUser(Address address) {
        return sessionAddress.isUser(address);
    }
    
    public boolean isLoggedIn(Address address) {
        return sessionAddress.isLoggedIn(address);
    }
}
