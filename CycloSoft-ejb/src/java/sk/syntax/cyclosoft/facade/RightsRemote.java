/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import javax.ejb.Remote;
import sk.syntax.cyclosoft.domain.Rights;

/**
 *
 * @author radko28
 */
@Remote
public interface RightsRemote {
    public void add(Rights rights);
    public Rights getRights(int pKey);        
    public int getRights(String rightsName);    
}
