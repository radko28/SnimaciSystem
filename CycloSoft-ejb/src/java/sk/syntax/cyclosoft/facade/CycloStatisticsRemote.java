/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import java.util.ArrayList;
import javax.ejb.Remote;
import sk.syntax.cyclosoft.data.Ladder;
import sk.syntax.cyclosoft.data.LadderList;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
@Remote
public interface CycloStatisticsRemote {
    public double getVeloce(int pKey);
    public double getDistance(int pKey);
    public Long getTraining(int pKey);             
    public double getVeloce(int pKey,Filter filter);
    public double getDistance(int pKey,Filter filter);
    public Long getTraining(int pKey,Filter filter);
/**
 *Rebrik cyklistov samostatne
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getCycloLadder(Filter filter) throws Exception ;
/**
 *Rebrik cyklistov v time
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getTeamLadder(Filter filter) throws Exception;
    
    
/**
 *Rebrik timov
 * podla rychlosti, vzdialenosti a poctu treningov.
 * 
 */    
    public LadderList getTeamsLadder(Filter filter);
    
}
