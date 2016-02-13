/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;


import java.util.List;
import javax.ejb.Remote;
import sk.syntax.cyclosoft.data.Ladder;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.domain.Cyclo;
import sk.syntax.cyclosoft.domain.CycloList;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
@Remote
public interface CycloRemote {
    public void add(Cyclo cyclo, int userId);
    public void modify(Cyclo cyclo);    
    public void remove(int pKey);        
    public void removeAll(int userId);
    public Cyclo getCyclo(int pKey);
    public CycloList getCycloList(Filter filter);         
    public Ladder getCyclo(Filter filter, Address address);
    public Ladder getTeamCyclo(Filter filter, Team team);    
    public List<String> getTrackList();
    public int getMaxYear(int userId);
    public int getMinYear(int userId);
    public int getMaxYear();
    public int getMinYear();
    
}
