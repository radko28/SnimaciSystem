/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import sk.syntax.cyclosoft.data.AddressList;
import sk.syntax.cyclosoft.data.CycloRTData;
import sk.syntax.cyclosoft.data.CycloRTList;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.domain.Cyclo;
import sk.syntax.cyclosoft.domain.CycloRT;
import sk.syntax.cyclosoft.helper.DistanceComparator;
import sk.syntax.cyclosoft.helper.Filter;
import sk.syntax.cyclosoft.helper.VeloceComparator;

/**
 *
 * @author radko28
 */
@Stateless
public class CycloRTBean implements CycloRTRemote {
    @EJB private CycloRemote cycloRemote;    
    @EJB private AddressRemote addressRemote;
    @PersistenceContext(unitName="CycloSoft") 
    private EntityManager manager;
    private static final String CYCLO_RT_TABLE = "cycloRT";
/**
 * Pridanie do CycloRT. 
 */    
    public void add(CycloRT cycloRT) {
	manager.persist(cycloRT);        
    }
/**
 *Prepis CycloRT. 
 */
    public void modify(CycloRT cycloRT) {
        manager.merge(cycloRT);        
    } 
/**
 * Kopirovanie do Cyclo.
 */    
    public void end(int userId) {
        CycloRT cycloRT = getCyclo(userId);
        Cyclo cyclo = new Cyclo();
        cyclo.setDate(cycloRT.getDate());
        cyclo.setDistance(cycloRT.getDistance());
        cyclo.setNote(cycloRT.getNote());
        cyclo.setTemperature(cycloRT.getTemperature());
        cyclo.setTime(cycloRT.getTime());
        cyclo.setTrack(cycloRT.getTrack());
        cyclo.setUserId(userId);
        cyclo.setVeloce(cycloRT.getVeloce());
        cycloRemote.add(cyclo,userId); 
        delete(userId);
    }   
    
    public CycloRTList getCycloList(Filter filter) throws Exception{
        System.out.println("-0-------getCycloList---------------------------");
        CycloRTList cycloRTList = new CycloRTList();
        List<CycloRTData> cycloRT = new ArrayList<CycloRTData>();
        AddressList addressList = addressRemote.getAddressList(filter,CYCLO_RT_TABLE);
        System.out.println("-1-------getCycloList---------size = " +addressList.getAddressList().size());        
        CycloRTData cycloRTData = null;
        System.out.println("-2-------getCycloList---------------------------");        
        for(Address address : addressList.getAddressList()) {
            System.out.println("-3-------getCycloList---------------------------");            
            cycloRTData = new CycloRTData();
            cycloRTData.setAddress(address);
            cycloRTData.setTeam(address.getTeam());
//getaddreslist ktory su RT        
            System.out.println("-4-------getCycloList-------------------address.getId()=" + address.getId());            
            CycloRT cyclo = getCyclo(address.getId());
            
            System.out.println("-5-------getCycloList----cyclo=" + cyclo);            
            if(cyclo != null) {
                cycloRTData.setVeloce(cyclo.getVeloce());
                cycloRTData.setDistance(cyclo.getDistance());
                cycloRT.add(cycloRTData);
            }
        }
        System.out.println("-4-------getCycloList---------------------------");        
//sort
        switch(filter.getSortBy()) {
            case 0:
                Collections.sort(cycloRT, new VeloceComparator());                                
                break;
            case 1:
                Collections.sort(cycloRT, new DistanceComparator());                
                break;
            default:
                break;
        }
        cycloRTList.setCycloRTList(cycloRT);
        if(addressList != null) {
//rowsPerPage
            cycloRTList.setRowsPerPage(filter.getRowsPerPage());
//rows
            cycloRTList.setRows(addressList.getRows());
        }
        return cycloRTList;
        
    }   
    
    public CycloRT getCyclo(int userId) {
        ///*
         String queryString = "select c from CycloRT as c where c.userId = :userId";
        Query query = manager.createQuery(queryString);                
        query.setParameter("userId",userId);                                    
        return (CycloRT)query.getSingleResult();//*/
        //return manager.find(CycloRT.class, userId);
    }        
    private void delete(int userId) {
        CycloRT cycloRT = getCyclo(userId);
        manager.remove(cycloRT);
    }        
}
