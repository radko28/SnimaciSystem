/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import sk.syntax.cyclosoft.data.AddressList;
import sk.syntax.cyclosoft.data.TeamList;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.helper.Filter;
import sk.syntax.cyclosoft.helper.QueryHelper;

/**
 *
 * @author radko28
 */
@Stateless
public class AddressBean implements AddressRemote {
    @EJB private TeamRemote teamRemote;    
    @EJB private RightsRemote rightsRemote;        
    @PersistenceContext(unitName="CycloSoft") 
    
    private EntityManager manager;
    
    public void register(Address address) {
	manager.persist(address); 
        manager.flush();
    }
    
    public void registerUpdate(Address addressUpdate) {
System.out.println("-0-------AddressBean---------------------------");        
        Address address = manager.find(Address.class,addressUpdate.getId());
        if(addressUpdate.getEmail() != null && addressUpdate.getEmail().length() > 0) {
            address.setEmail(addressUpdate.getEmail());
System.out.println("-1-------AddressBean---------------------------");            
        }
        if(addressUpdate.getPassword() != null && addressUpdate.getPassword().length() > 0) {
            address.setPassword(addressUpdate.getPassword());
System.out.println("-2-------AddressBean---------------------------");            
        }
        if(addressUpdate.getFirstname() != null && addressUpdate.getFirstname().length > 0) {
            address.setFirstname(addressUpdate.getFirstname());
System.out.println("-3-------AddressBean---------------------------");            
        }
        if(addressUpdate.getSurname() != null && addressUpdate.getSurname().length > 0) {
            address.setSurname(addressUpdate.getSurname());
System.out.println("-4-------AddressBean---------------------------");            
        }
        if(addressUpdate.getStreet() != null && addressUpdate.getStreet().length > 0) {
            address.setStreet(addressUpdate.getStreet());
System.out.println("-5-------AddressBean---------------------------");            
        }
        if(addressUpdate.getCity() != null && addressUpdate.getCity().length > 0) {
            address.setCity(addressUpdate.getCity());
System.out.println("-6-------AddressBean---------------------------");            
        }
        if(addressUpdate.getZip() != null && addressUpdate.getZip().length() > 0) {
            address.setZip(addressUpdate.getZip());
System.out.println("-7-------AddressBean---------------------------");            
        }
        if(addressUpdate.getPic() != null && addressUpdate.getPic().length() > 0) {
            address.setPic(addressUpdate.getPic());
System.out.println("-8-------AddressBean---------------------------");            
        }
        if(addressUpdate.getMobil() != null && addressUpdate.getMobil().length() > 0) {
            address.setMobil(addressUpdate.getMobil());
System.out.println("-9-------AddressBean---------------------------");            
        }
        if(addressUpdate.getWeb() != null && addressUpdate.getWeb().length() > 0) {
            address.setWeb(addressUpdate.getWeb());
System.out.println("-9-------AddressBean---------------------------");            
        }
        
       
    }    
    
    public void remove(int pKey) {
        Address address = manager.find(Address.class,pKey);
        manager.remove(address);
    }   
    
    public int login(Address address) throws Exception{
        int pKey = 0;
        try {
            pKey = getUserId(address); 
            Address addressLogin = manager.find(Address.class,pKey);
            addressLogin.setLog(1);        
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return pKey;    
        }
    }   
    
    public void logout(int pKey) {
        Address address = manager.find(Address.class,pKey);
        address.setLog(0);
    }
    
    public Address getAddress(int pKey) {
        String queryString = "from Address where id = :id";        
        Query query = manager.createQuery(queryString);            
        System.out.println("-0-AddressBean.getAddress-------------------------id_user = " + pKey);
        query.setParameter("id",pKey);                
        System.out.println("-1-AddressBean.getAddress-------------------------");                                                
        return (Address)query.getSingleResult();
    }             
    
    public Address getAddress(String email) throws Exception {
        String queryString = "from Address where email = :email";        
        Query query = manager.createQuery(queryString);            
        System.out.println("-0-AddressBean.getAddress-------------------------");                                        
        query.setParameter("email",email);                
        System.out.println("-1-AddressBean.getAddress-------------------------");                                                
        Address resultAddr = null;
        try {
            System.out.println("-2-AddressBean.getAddress-------------------------");                                                            
            Object result = query.getSingleResult();
            System.out.println("-3-AddressBean.getAddress-------------------------");                                                            
            if(result != null)
                resultAddr = (Address)result;
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return resultAddr;
        }
        
    }             

    public AddressList getAddressListPaging(Filter filter) {
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        System.out.println("getAddressList.rowFrom = " + rowFrom);
        System.out.println("getAddressList.rowsPerPage = " + rowsPerPage);
        String queryString = "from Address";        
        Query query = manager.createQuery(queryString);            
        int rows = query.getResultList().size();
        System.out.println("-5-getAddressList.rows = ------------" + rows);
        AddressList addressList = new AddressList();        
        addressList.setRows(rows);
        addressList.setAddressList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
        System.out.println("-2--getAddressList-------------------------");
        return addressList;
    }
    
    public AddressList getAddressListPagingTeam(Filter filter) throws Exception {
        System.out.println("-0-------AddressBean.getAddressList---------------------------");
        String queryString = "from Address a";
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        System.out.println("getAddressList.rowFrom = " + rowFrom);
        System.out.println("getAddressList.rowsPerPage = " + rowsPerPage);
        int teamId = filter.getTeamId();
        
        boolean whereFlag = false;
        if(teamId > 0) {
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;
            queryString += " a.team.id = :teamId";
        }
        Query query = manager.createQuery(queryString);
        AddressList addressList = new AddressList();                
        try {
            System.out.println("-1--AddressBean.getAddressList-------------------------teamId = " + teamId);
        if(teamId > 0)
            query.setParameter("teamId",teamId);
        int rows = query.getResultList().size();
        System.out.println("-2-AddressBean.getAddressList.rows = ------------" + rows);

        addressList.setRows(rows);
        addressList.setAddressList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
        System.out.println("-3--AddressBean.getAddressList-------------------------");

        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
         return addressList;
        }
    }


    public AddressList getAddressList(Filter filter,String table) throws Exception {
        System.out.println("-0-------AddressBean---------------------------");                
        String queryString = "SELECT distinct a FROM Address a, IN(a."+table+") b";
        int teamId = filter.getTeamId();
        String track = filter.getTrack();       
        float veloceFrom = filter.getVeloceFrom();
        float veloceTo = filter.getVeloceTo();        
        float distanceFrom = filter.getDistanceFrom();                
        float distanceTo = filter.getDistanceTo();                                
        String yearFrom = filter.getYearFrom();
        String monthFrom = filter.getMonthFrom();
        String yearTo = filter.getYearTo();
        String monthTo = filter.getMonthTo();
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        System.out.println("getCycloList.rowFrom = " + rowFrom);
        System.out.println("getCycloList.rowsPerPage = " + rowsPerPage);

        boolean whereFlag = false;
        if(teamId > 0) {        
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;            
            queryString += " a.team.id = :teamId";        

        }
        if(track != null && track.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " b.track = :track";        
        }
        if(veloceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " b.veloce >= :veloceFrom";        
        }
        if(veloceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " b.veloce <= :veloceTo";        
        }
        if(distanceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " b.distance >= :distanceFrom";        
        }
        if(distanceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " b.distance <= :distanceTo";        
        }
        
        if(monthTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " SUBSTRING(b.date,6,2) <=:monthTo";        
        }
        if(monthFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " SUBSTRING(b.date,6,2) >= :monthFrom";        
        }

        
        if(yearTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " SUBSTRING(b.date,1,4) <= :yearTo";        
        }
        if(yearFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;                        
            queryString += " SUBSTRING(b.date,1,4) >= :yearFrom";        
        }

        
        System.out.println("addressBean queryString = " + queryString);
        Query query = manager.createQuery(queryString);
        AddressList addressList = new AddressList();
        try {
            System.out.println("-0--AddressBean-------------------------");        
            if(teamId > 0)
                query.setParameter("teamId",teamId);
            if(track != null && track.length() > 0)
                query.setParameter("track",track);
            if(veloceFrom > 0)
                query.setParameter("veloceFrom",veloceFrom);
            if(veloceTo > 0)
                query.setParameter("veloceTo",veloceTo);
            if(distanceFrom > 0)
                query.setParameter("distanceFrom",distanceFrom);
            if(distanceTo > 0)
                query.setParameter("distanceTo",distanceTo);
            if(monthFrom.length() > 0)
                query.setParameter("monthFrom",monthFrom);
            if(monthTo.length() > 0)
                query.setParameter("monthTo",monthTo);
            if(yearFrom.length() > 0)
                query.setParameter("yearFrom",yearFrom);
            if(yearTo.length() > 0)
                query.setParameter("yearTo",yearTo);
            System.out.println("-1--AddressBean-------------------------");
            int rows = query.getResultList().size();
            System.out.println("-5-AddressBean.rows = ------------" + rows);
            addressList.setRows(rows);
            addressList.setAddressList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
            System.out.println("-2--AddressBean-------------------------");
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return addressList;
        }
    }

    
    public AddressList getAddressByTeamList(Filter filter) {
        System.out.println("-0-------AddressBean.getAddressByTeamList---------------------------");
        String queryString = "from Address a";                
        int teamId = filter.getTeamId();
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        System.out.println("getAddressByTeamList.rowFrom = " + rowFrom);
        System.out.println("getAddressByTeamList.rowsPerPage = " + rowsPerPage);

        boolean whereFlag = false;
        if(teamId > 0) {        
            queryString = QueryHelper.getWhereQuery(queryString, whereFlag);
            whereFlag = true;            
            queryString += " a.team.id = :teamId";        
        }
        Query query = manager.createQuery(queryString);
        AddressList addressList = new AddressList();
        try {
            System.out.println("-0--AddressBean.getAddressByTeamList-------------------------");
        if(teamId > 0)
            query.setParameter("teamId",teamId);
        System.out.println("-1--AddressBean.getAddressByTeamList-------------------------");
        if(rowsPerPage > 0) {        
             int rows = query.getResultList().size();
            System.out.println("-5-AddressBean.getAddressByTeamList.rows = ------------" + rows);
            addressList.setRows(rows);
            addressList.setAddressList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
        } else
            addressList.setAddressList(query.getResultList());
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return addressList;
        }
    }    
    
        public TeamList getTeamList(Filter filter) {
        System.out.println("-0-AddressBean.getTeamList---------------------------");
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        System.out.println("getAddressByTeamList.rowFrom = " + rowFrom);
        System.out.println("getAddressByTeamList.rowsPerPage = " + rowsPerPage);
        String queryString = "select distinct a.team from Address a";                
        Query query = manager.createQuery(queryString);    
        TeamList teamList = new TeamList();
        try {
            System.out.println("-1-AddressBean.getTeamList-------------------------");        
         int rows = query.getResultList().size();
         System.out.println("-2-AddressBean.getTeamList.rows = ------------" + rows);
         teamList.setRows(rows);
         teamList.setLadderList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
         System.out.println("-3-AddressBean.getTeamList-------------------------");
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return teamList;
        }
    }

 public List getTeamList() {
        System.out.println("-0-AddressBean.getTeamList---------------------------");
        String queryString = "select distinct a.team from Address a";
        Query query = manager.createQuery(queryString);
        List result = null;
        try {
            System.out.println("-1-AddressBean.getTeamList-------------------------");
         result = query.getResultList();
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return result;
        }
    }


    
    public void addTeamToAddress(int teamId, int addressId) {
        System.out.println("-0-AddressBean.addTeamToAddress-------------------------");                        
        //Address address = manager.find(Address.class,addressId);
        Address address = getAddress(addressId);
        System.out.println("-1-AddressBean.addTeamToAddress------------------------addressId = "+ address.getId());                        
        //Team team = teamRemote.getTeam(teamId);
        address.setTeam(teamRemote.getTeam(teamId));
        System.out.println("-2-AddressBean.addTeamToAddress-----------------------");                                
    }    
    
    public void addRightsToAddress(String rights, int addressId) {
        System.out.println("-0-AddressBean.addRightsToAddress-------------------------");                        
        Address address = getAddress(addressId);
        System.out.println("-1-AddressBean.addRightsToAddress------------------------addressId = "+ address.getId());                        
        int rightsId = rightsRemote.getRights(rights);         
        address.setRights(rightsRemote.getRights(rightsId));
        System.out.println("-2-AddressBean.addRightsToAddress-----------------------");                                
    }    

    
    public boolean isUser(Address address) {
        String queryString = "from Address where email = :email and password = :password";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("email",address.getEmail());
        query.setParameter("password",address.getPassword());        
        Object result = query.getSingleResult();
        return result == null ? false : true;     
    }
    
    public boolean isLoggedIn(Address address) {
        String queryString = "from Address where email = :email and password = :password and log = 1";        
        Query query = manager.createQuery(queryString);            
        System.out.println("test01");        
        query.setParameter("email",address.getEmail());
        query.setParameter("password",address.getPassword());        
        System.out.println("test02 " + address.getEmail());        
        System.out.println("test02 " + address.getPassword());                
        Object result = query.getSingleResult();
        System.out.println("test03");
        return result == null ? false : true;
    }
    
    public int getUserId(Address address) throws Exception {
        String queryString = "select id from Address where email = :email and password =:password";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("email",address.getEmail());                
        System.out.println("email = " + address.getEmail());
        query.setParameter("password",address.getPassword());                
        System.out.println("password = " + address.getPassword());
        int result = (Integer)query.getSingleResult();        
        return result;
    }
    
}
