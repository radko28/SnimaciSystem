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
import sk.syntax.cyclosoft.data.Ladder;
import sk.syntax.cyclosoft.data.LadderList;
import sk.syntax.cyclosoft.data.TeamList;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.helper.DistanceComparator;
import sk.syntax.cyclosoft.helper.Filter;
import sk.syntax.cyclosoft.helper.QueryHelper;
import sk.syntax.cyclosoft.helper.TrainingComparator;
import sk.syntax.cyclosoft.helper.VeloceComparator;

/**
 *
 * @author radko28
 */
@Stateless
public class CycloStatisticsBean implements CycloStatisticsRemote {
    @EJB private AddressRemote addressRemote;
    @EJB private CycloRemote cycloRemote;    
    @PersistenceContext(unitName="CycloSoft")     
    private EntityManager manager;    
    private static final String CYCLO_TABLE = "cyclo";
    
    public double getVeloce(int pKey) {
        String queryString = "select avg(b.veloce) from Address a, IN(a.cyclo) b where a.id = :id";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("id", pKey);
        Object result = query.getSingleResult();
        result = (result == null ? 1 : result);
        return (Double)result;
    }
    
    public double getDistance(int pKey) {
        String queryString = "select avg(b.distance) from Address a, IN(a.cyclo) b where a.id = :id";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("id", pKey);
        Object result = query.getSingleResult();
        result = (result == null ? 1 : result);
        return (Double)result;
    }   
    
     public Long getTraining(int pKey) {
        String queryString = "select count(b.userId) from Address a, IN(a.cyclo) b where a.id = :id";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("id", pKey);
        Object result = query.getSingleResult();
        result = (result == null ? 1F : result);
        return ((Long)result);
     }   
     
    public double getVeloce(int pKey,Filter filter) {
        String queryString = "select avg(b.veloce) from Address a, IN(a.cyclo) b where a.id = :id";        
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
        
        
        boolean whereFlag = true;
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
        
        Query query = manager.createQuery(queryString);    
        
        query.setParameter("id", pKey);
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

        query.setParameter("id", pKey);
        Object result = query.getSingleResult();
        result = (result == null ? 1 : result);
        return (Double)result;
        
    }
    public double getDistance(int pKey,Filter filter) {
        String queryString = "select avg(b.distance) from Address a, IN(a.cyclo) b where a.id = :id";        
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
        
        
        boolean whereFlag = true;
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
        
        Query query = manager.createQuery(queryString);    
        
        query.setParameter("id", pKey);
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

        query.setParameter("id", pKey);
        Object result = query.getSingleResult();
        result = (result == null ? 1 : result);
        return (Double)result;
        
    }
    public Long getTraining(int pKey,Filter filter) {
        String queryString = "select count(b.userId) from Address a, IN(a.cyclo) b where a.id = :id";        
        
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
        
        
        boolean whereFlag = true;
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
        
        Query query = manager.createQuery(queryString);    
        
        query.setParameter("id", pKey);
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
        
        Object result = query.getSingleResult();
        result = (result == null ? 1F : result);
        System.out.println("-0-------CycloStatisticsBean.query = " +queryString);        
        System.out.println("-1-------CycloStatisticsBean.trainings = " +result);        
        return ((Long)result);
    }


    
/**
 * Rebrik cyklistov samostatne 
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getCycloLadder(Filter filter) throws Exception {
        System.out.println("-0-------CycloStatisticsBean---------------------------");
        LadderList ladderList = new LadderList();
        List<Ladder> ladder = new ArrayList<Ladder>();
        AddressList addressList = addressRemote.getAddressList(filter,CYCLO_TABLE);
        System.out.println("-1-------CycloStatisticsBean---------size = " +addressList.getAddressList().size());        
        Ladder ladderData = null;
        System.out.println("-2-------CycloStatisticsBean---------------------------");        
        for(Address address : addressList.getAddressList()) {
            System.out.println("-3-------CycloStatisticsBean---------------------------");            
            ladderData = new Ladder();
            ladderData.setAddress(address);
            ladderData.setTeam(address.getTeam());
            ladderData.setVeloce((double)getVeloce(address.getId(),filter));
            ladderData.setDistance((double)getDistance(address.getId(),filter));
            ladderData.setTraining(getTraining(address.getId(),filter));
            ladder.add(ladderData);
        }
        System.out.println("-4-------CycloStatisticsBean---------------------------");        
//sort
        switch(filter.getSortBy()) {
            case 0:
                Collections.sort(ladder, new VeloceComparator());                                
                break;
            case 1:
                Collections.sort(ladder, new DistanceComparator());                
                break;
            case 2:
                Collections.sort(ladder, new TrainingComparator());                                
                break;
            default:
                break;
        }
        ladderList.setLadderList(ladder);
        if(addressList != null) {
//rowsPerPage
            ladderList.setRowsPerPage(filter.getRowsPerPage());
//rows
            ladderList.setRows(addressList.getRows());
        }
        return ladderList;
    }
    
    /**
     *   Poradie cyklistov v time
     */
    public LadderList  getTeamLadder(Filter filter) throws Exception{
        System.out.println("-0---------------------");
        LadderList ladderList = new LadderList();
        List<Ladder> ladder = new ArrayList<Ladder>();
        System.out.println("-1---------------------");
        AddressList addressList = addressRemote.getAddressList(filter,CYCLO_TABLE);
        System.out.println("-2---------------------");
        Ladder ladderData = null;
        System.out.println("-3---------------------");
        for(Address address : addressList.getAddressList()) {
            System.out.println("-5---------------------");                        
            ladderData = cycloRemote.getCyclo(filter, address);
            System.out.println("-6---------------------");                                    
            if(ladderData != null && ladderData.getTraining() > 0) {
                ladder.add(ladderData);
            }
            System.out.println("-7---------------------");                                    
        }
//sort
        switch(filter.getSortBy()) {
            case 0:
                Collections.sort(ladder, new VeloceComparator());                                
                break;
            case 1:
                Collections.sort(ladder, new DistanceComparator());                
                break;
            case 2:
                Collections.sort(ladder, new TrainingComparator());                                
                break;
            default:
                break;
        }
        ladderList.setLadderList(ladder);
        if(addressList != null) {
//rowsPerPage
            ladderList.setRowsPerPage(filter.getRowsPerPage());
//rows
            ladderList.setRows(addressList.getRows());
        }
        return ladderList;
    }
    
    /**
     *Poradie timov podla veloce/distance/training.
     */
    public LadderList getTeamsLadder(Filter filter) {
        System.out.println("-0-getTeamsLadder--------------------");
        LadderList ladderList = new LadderList();
        ArrayList<Ladder> ladder = new ArrayList<Ladder>();
        System.out.println("-1-getTeamsLadder--------------------");
//zoznam team kde je userId        
        TeamList teamList = addressRemote.getTeamList(filter);
        System.out.println("-2---------------------teamList = " + teamList);
        Ladder ladderData = null;
        System.out.println("-3---------------------");
      for(Team team : teamList.getTeamList()) {
        System.out.println("-4---------------------");
            ladderData = cycloRemote.getTeamCyclo(filter, team);
            if(ladderData != null && ladderData.getTraining() > 0) {    
                ladder.add(ladderData);
            }
        }
//sort Ladder
        switch(filter.getSortBy()) {
            case 0:
                Collections.sort(ladder, new VeloceComparator());                                
                break;
            case 1:
                Collections.sort(ladder, new DistanceComparator());                
                break;
            case 2:
                Collections.sort(ladder, new TrainingComparator());                                
                break;
            default:
                break;
        }
        ladderList.setLadderList(ladder);
        if(teamList != null) {
//rowsPerPage
            ladderList.setRowsPerPage(filter.getRowsPerPage());
//rows
            ladderList.setRows(teamList.getRows());
        }
        return ladderList;
    }
    
}
