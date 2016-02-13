/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import java.util.List;
import javax.ejb.Remote;
import sk.syntax.cyclosoft.data.TeamList;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
@Remote
public interface TeamRemote {
    public void add(Team team);
    public void modify(Team team);    
    public void remove(int pKey);        
    public Team getTeam(int pKey);    
    public int getTeam(byte[] name) throws Exception; 
    public TeamList getTeamList(Filter filter);
    public List getTeamList();
}
