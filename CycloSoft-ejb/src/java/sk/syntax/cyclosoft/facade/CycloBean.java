/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import sk.syntax.cyclosoft.data.Ladder;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.domain.Cyclo;
import sk.syntax.cyclosoft.domain.CycloList;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.helper.Filter;
import sk.syntax.cyclosoft.helper.QueryHelper;

/**
 *
 * @author radko28
 */
@Stateless
public class CycloBean implements CycloRemote {
    @PersistenceContext(unitName="CycloSoft") 
    private EntityManager manager;
    
    public void add(Cyclo cyclo, int userId) {
        System.out.println("cycloBean.add userId = " + userId);
        Address address = manager.find(Address.class,userId);
        System.out.println("cycloBean.add email = " + address.getEmail());
        address.getCyclo().add(cyclo);
    }
    public void modify(Cyclo cyclo) {
        manager.merge(cyclo);
    }    
    public void remove(int pKey) {
        Cyclo cyclo = getCyclo(pKey);
        manager.remove(cyclo);
    }        
    
    public void removeAll(int userId) {
        String queryString = "delete from Cyclo as c where c.userId = :userId";       
        System.out.println(queryString);        
        Query query = manager.createQuery(queryString);                
        query.setParameter("userId",userId);                                            
        query.executeUpdate();
    }
    
    public Cyclo getCyclo(int pKey) {
        return manager.find(Cyclo.class, pKey);
    }    
//pre jedneho userId    
    public CycloList getCycloList(Filter filter) {    
        String queryString = "select c from Cyclo as c ";
        System.out.println(queryString);        
        int userId = filter.getId();
        String track = filter.getTrack();       
        float veloceFrom = filter.getVeloceFrom();
        float veloceTo = filter.getVeloceTo();        
        float distanceFrom = filter.getDistanceFrom();                
        float distanceTo = filter.getDistanceTo();                                
        String yearFrom = filter.getYearFrom();
        String yearTo = filter.getYearTo();
        String monthFrom = filter.getMonthFrom();
        String monthTo = filter.getMonthTo();
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        String order = filter.getOrder();
                System.out.println("getCycloList.sortBy = " + filter.getSortBy());
        System.out.println("getCycloList.order = " + order);
        System.out.println("getCycloList.rowFrom = " + rowFrom);
        System.out.println("getCycloList.rowsPerPage = " + rowsPerPage);
        System.out.println("getCycloList.monthFrom = " + monthFrom);
        System.out.println("getCycloList.monthTo = " + monthTo);
        queryString = QueryHelper.getWhereQuery(queryString, false);
        queryString += " c.userId = :userId";        
        if(track != null && track.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.track = :track";        
        }
        if(veloceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.veloce >= :veloceFrom";        
        }
        if(veloceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.veloce <= :veloceTo";        
        }
        if(distanceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.distance >= :distanceFrom";        
        }
        if(distanceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.distance <= :distanceTo";        
        }
        if(monthTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,6,2) <= :monthTo";        
        }
        if(monthFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,6,2) >= :monthFrom";        
        }
        
        if(yearFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,1,4) >= :yearFrom";                
        }
        if(yearTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,1,4) <= :yearTo";                
        }
        if(order.length() > 0 && (order.equals("asc") || order.equals("desc")) ) {
            switch(filter.getSortBy()) {
                case 0:
                    queryString += " order by veloce " + order;
                    break;
                case 1:
                    queryString += " order by distance " + order;
                    break;
                case 3:
                    queryString += " order by date " + order;
                    break;
                case 4:
                    queryString += " order by time " + order;
                    break;
            }
        } else {
            queryString += " order by date desc";
        }
        
        
        System.out.println("-0-CycloBean.getCycloList queryString = "+queryString);
        System.out.println("-0-CycloBean.getCyclo---------------");                
        System.out.println("-0-CycloBean.getCyclo--------userId = " + userId);                        
        Query query = manager.createQuery(queryString);                
        System.out.println("-1-CycloBean.getCyclo--------userId = " + userId);                                
        query.setParameter("userId",userId);                                    
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
        
        System.out.println("-2-CycloBean.getCyclo--------userId = " + userId);                                
        System.out.println("-4-CycloBean.getCyclo---------------");                                    
        System.out.println("-4-CycloBean.getCyclo---query = ------------" + query);                                    
        CycloList cycloList = new CycloList();
        int rows = query.getResultList().size();
        System.out.println("-5-CycloBean.rows = ------------" + rows);                                            
        cycloList.setRows(rows);
        cycloList.setCyloList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
        return cycloList;
    }
//ladder groupovany s userId    
    public Ladder getCyclo(Filter filter, Address address) {
        String queryString = "select avg(c.veloce), avg(c.distance), count(c) from Cyclo as c";
        System.out.println(queryString);        
        Ladder ladder = null;
        int userId = address.getId();
        String track = filter.getTrack();       
        float veloceFrom = filter.getVeloceFrom();
        float veloceTo = filter.getVeloceTo();        
        float distanceFrom = filter.getDistanceFrom();                
        float distanceTo = filter.getDistanceTo();                                
        String yearFrom = filter.getYearFrom();
        String yearTo = filter.getYearTo();
        String monthFrom = filter.getMonthFrom();
        String monthTo = filter.getMonthTo();
        queryString = QueryHelper.getWhereQuery(queryString, false);
        queryString += " c.userId = :userId";        
        if(track != null && track.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.track = :track";        
        }
        if(veloceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.veloce >= :veloceFrom";        
        }
        if(veloceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.veloce < :veloceTo";        
        }
        if(distanceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.distance >= :distanceFrom";        
        }
        if(distanceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.distance < :distanceTo";        
        }
        if(monthTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,6,2) <= :monthTo";        
        }
        if(monthFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,6,2) >= :monthFrom";        
        }
        
        if(yearFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,1,4) >= :yearFrom";                
        }
        if(yearTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,1,4) <= :yearTo";                
        }
        System.out.println(queryString);
        System.out.println("-0-CycloBean.getCyclo---------------");                
        System.out.println("-0-CycloBean.getCyclo--------userId = " + userId);                        
        Query query = manager.createQuery(queryString);                
        System.out.println("-1-CycloBean.getCyclo--------userId = " + userId);                                
        query.setParameter("userId",userId);                                    
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
        System.out.println("-2-CycloBean.getCyclo--------userId = " + userId);                                
        Object[] result = (Object[])query.getSingleResult();
        //Object result = query.getResultList();        
        System.out.println("-3-CycloBean.getCyclo---------------");                        
        result[0] = (result[0] == null ? new Double(1F) : result[0]);        
        result[1] = (result[1] == null ? new Double(1F) : result[1]);                
        result[2] = (result[2] == null ? new Long(1) : result[2]);                        
        System.out.println("-4-CycloBean.getCyclo---------------");                                    
            ladder = new Ladder();
            ladder.setVeloce((Double)result[0]);
            ladder.setDistance((Double)result[1]);
            ladder.setTraining((Long)result[2]);                        
            ladder.setAddress(address);
        System.out.println("-5-CycloBean.getCyclo-result[0] = " + result[0]);                                            
        return ladder;
    }
//ladder groupovany s teamId    
    public Ladder getTeamCyclo(Filter filter, Team team) {
        String queryString = "select avg(c.veloce), avg(c.distance), count(c) from Address a , IN(a.cyclo) c";
        System.out.println(queryString);        
        Ladder ladder = null;
        int teamId = team.getId();
        String track = filter.getTrack();       
        float veloceFrom = filter.getVeloceFrom();
        float veloceTo = filter.getVeloceTo();        
        float distanceFrom = filter.getDistanceFrom();                
        float distanceTo = filter.getDistanceTo();                                
        String yearFrom = filter.getYearFrom();
        String yearTo = filter.getYearTo();        
        String monthFrom = filter.getMonthFrom();
        String monthTo = filter.getMonthTo();        
        queryString = QueryHelper.getWhereQuery(queryString, false);
        queryString += " a.team.id = :teamId";        
        if(track != null && track.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.track = :track";        
        }
        if(veloceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.veloce >= :veloceFrom";        
        }
        if(veloceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.veloce <= :veloceTo";        
        }
        if(distanceFrom > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.distance >= :distanceFrom";        
        }
        if(distanceTo > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " c.distance <= :distanceTo";        
        }
        if(monthFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,6,2) >= :monthFrom";        
        }
        if(monthTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,6,2) <= :monthTo";        
        }
        if(yearFrom.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,1,4) >= :yearFrom";                
        }

        if(yearTo.length() > 0) {          
            queryString = QueryHelper.getWhereQuery(queryString, true);
            queryString += " SUBSTRING(c.date,1,4) <= :yearTo";                
        }
        System.out.println(queryString);
        System.out.println("-0-CycloBean.getTeamCyclo---------------");                
        System.out.println("-0-CycloBean.getTeamCyclo--------teamId = " + teamId);                        
        Query query = manager.createQuery(queryString);                
        System.out.println("-1-CycloBean.getTeamCyclo--------teamId = " + teamId);                                
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
        
        System.out.println("-2-CycloBean.getTeamCyclo--------teamId = " + teamId);                                
        Object[] result = (Object[])query.getSingleResult();
        //Object result = query.getResultList();        
        System.out.println("-3-CycloBean.getTeamCyclo---------------");                        
        result[0] = (result[0] == null ? new Double(0F) : result[0]);        
        result[1] = (result[1] == null ? new Double(0F) : result[1]);                
        result[2] = (result[2] == null ? new Long(0) : result[2]);                        
        System.out.println("-4-CycloBean.getTeamCyclo---------------");                                    
            ladder = new Ladder();
            ladder.setVeloce((Double)result[0]);
            ladder.setDistance((Double)result[1]);
            ladder.setTraining((Long)result[2]);
            ladder.setTeam(team);
        System.out.println("-5-CycloBean.getTeamCyclo-result[0] = " + result[0]);                                            
        System.out.println("-5-CycloBean.getTeamCyclo-result[1] = " + result[1]);                                            
        System.out.println("-5-CycloBean.getTeamCyclo-result[2] = " + result[2]);                                                    
        System.out.println("-5-CycloBean.getTeamCyclo-teamName = " + team.getName());                                                            
        return ladder;
        }
    
    
     public List<String> getTrackList() {
        String queryString = "select distinct c.track from Cyclo as c ";
        System.out.println(queryString);        
        //queryString = QueryHelper.getWhereQuery(queryString, false);
        //queryString += " c.userId = :userId";        
        System.out.println(queryString);
        //System.out.println("-0-CycloBean.getTrackList--------userId = " + userId);                        
        Query query = manager.createQuery(queryString);                
        //System.out.println("-1-CycloBean.getTrackList--------userId = " + userId);                        
        //query.setParameter("userId",userId);                                    
        return query.getResultList();        
         
     }
     
     public int getMaxYear(int userId) {
        String queryString = "select MAX(SUBSTRING(c.date,1,4)) from Cyclo as c ";
        System.out.println(queryString);        
        queryString = QueryHelper.getWhereQuery(queryString, false);
        queryString += " c.userId = :userId";        
        System.out.println(queryString);
        System.out.println("-0-CycloBean.getMaxYear--------userId = " + userId);                        
        Query query = manager.createQuery(queryString);                
        System.out.println("-1-CycloBean.getMaxYear--------userId = " + userId);                        
        query.setParameter("userId",userId);                                    
        Object result = query.getSingleResult();
        int resultInt = 0;
        if(result != null)
            resultInt = Integer.valueOf((String)result).intValue();
        return resultInt;
     }
    
     public int getMinYear(int userId) {
        String queryString = "select MIN(SUBSTRING(c.date,1,4)) from Cyclo as c ";
        System.out.println(queryString);        
        queryString = QueryHelper.getWhereQuery(queryString, false);
        queryString += " c.userId = :userId";        
        System.out.println(queryString);
        System.out.println("-0-CycloBean.getMinYear--------userId = " + userId);                        
        Query query = manager.createQuery(queryString);                
        System.out.println("-1-CycloBean.getMinYear--------userId = " + userId);                        
        query.setParameter("userId",userId);                                    
        Object result = query.getSingleResult();
        int resultInt = 0;
        if(result != null)
            resultInt = Integer.valueOf((String)result).intValue();
        return resultInt;
     }
     
     public int getMaxYear() {
        String queryString = "select MAX(SUBSTRING(c.date,1,4)) from Cyclo as c ";
        System.out.println(queryString);
        Query query = manager.createQuery(queryString);                
        Object result = query.getSingleResult();
        int resultInt = 0;
        if(result != null)
            resultInt = Integer.valueOf((String)result).intValue();
        return resultInt;
     }
    
     public int getMinYear() {
        String queryString = "select MIN(SUBSTRING(c.date,1,4)) from Cyclo as c ";
        System.out.println(queryString);
        Query query = manager.createQuery(queryString);                
        Object result = query.getSingleResult();
        int resultInt = 0;
        if(result != null)
            resultInt = Integer.valueOf((String)result).intValue();
        return resultInt;
     }
     
}
