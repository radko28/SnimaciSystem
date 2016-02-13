/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import javax.ejb.Remote;
import sk.syntax.cyclosoft.data.CycloRTList;
import sk.syntax.cyclosoft.domain.CycloRT;
import sk.syntax.cyclosoft.helper.Filter;

/**
 *
 * @author radko28
 */
@Remote
public interface CycloRTRemote {
/**
 * Pridanie do CycloRT. 
 */    
    public void add(CycloRT cycloRT);
/**
 *Prepis CycloRT. 
 */
    public void modify(CycloRT cycloRT);    
/**
 * Kopirovanie do Cyclo.
 */    
    public void end(int userId);        
/**
 * zoznam RT cyklistov
 * @return
 */
    public CycloRTList getCycloList(Filter filter) throws Exception ;
/**
 * detail RT cyklistu
 * @param pKey
 * @return
 */    
    public CycloRT getCyclo(int userId);        
    
    
    
}
