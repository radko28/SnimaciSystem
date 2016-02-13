/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import javax.ejb.Remote;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.helper.Filter;
import java.util.List;
import sk.syntax.cyclosoft.data.AddressList;
import sk.syntax.cyclosoft.data.TeamList;

/**
 *
 * @author radko28
 */
@Remote
public interface AddressRemote {
    public void register(Address address);
    public void registerUpdate(Address address);    
    public void remove(int pKey);        
    public int login(Address address) throws Exception;                
    public void logout(int pKey);             
    public TeamList getTeamList(Filter filter);
    public List getTeamList();
    public AddressList getAddressByTeamList(Filter filter);
    public AddressList getAddressListPaging(Filter filter);
    public AddressList getAddressListPagingTeam(Filter filter) throws Exception;    
    public AddressList getAddressList(Filter filter,String table) throws Exception;
    public Address getAddress(int pKey);         
    public Address getAddress(String email) throws Exception; 
    public void addTeamToAddress(int teamId, int addressId);
    public void addRightsToAddress(String rights, int addressId);    
    public boolean isUser(Address address);
    public boolean isLoggedIn(Address address);    
    public int getUserId(Address address) throws Exception;    
}
