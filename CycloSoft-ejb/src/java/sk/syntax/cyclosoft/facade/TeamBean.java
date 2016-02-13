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
import sk.syntax.cyclosoft.data.TeamList;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
@Stateless
public class TeamBean implements TeamRemote {
    @PersistenceContext(unitName="CycloSoft") 
    private EntityManager manager;
    
    public void add(Team team) {
        manager.persist(team);
    }
    public void modify(Team team) {
        manager.merge(team);
    }    
    public void remove(int pKey) {
        Team team = manager.find(Team.class, pKey);
        manager.remove(team);
    }        
    public Team getTeam(int pKey) {
        return manager.find(Team.class, pKey);
    }   
    
    public int getTeam(byte[] name) throws Exception {
        String queryString = "select id from Team where name = :name";        
        Query query = manager.createQuery(queryString);            
        query.setParameter("name",name);                
        System.out.println("name = " + name);
        int result = 0;
        try {
            result = (Integer)query.getSingleResult();
        } catch(Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return result;
        }
    }
    
    public TeamList getTeamList(Filter filter) {
        int rowFrom = filter.getRowFrom();
        int rowsPerPage = filter.getRowsPerPage();
        System.out.println("getteamList.rowFrom = " + rowFrom);
        System.out.println("getTeamList.rowsPerPage = " + rowsPerPage);
        String queryString = "from Team";
        Query query = manager.createQuery(queryString);
        TeamList teamList = new TeamList();
        System.out.println("-1--TeamBean-------------------------");
        int rows = query.getResultList().size();
        System.out.println("-2-TeamBean.rows = ------------" + rows);
        teamList.setRows(rows);
        teamList.setLadderList(query.setMaxResults(rowsPerPage).setFirstResult(rowFrom).getResultList());
        System.out.println("-3--AddressBean-------------------------");
        return teamList;
    }

    public List getTeamList() {
        String queryString = "from Team";
        Query query = manager.createQuery(queryString);
        System.out.println("-1--TeamBean-------------------------");
        return query.getResultList();
    }
    
    

}
