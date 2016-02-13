/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.helper;

import java.util.Comparator;
import sk.syntax.cyclosoft.data.CycloRTData;
import sk.syntax.cyclosoft.data.Ladder;

/**
 *
 * @author radko28
 */
public class VeloceComparator implements Comparator<Object> {
    public int compare(Object o1, Object o2) {
        if(o1 instanceof Ladder)
            return -(int)(((Ladder)o1).getVeloce() - ((Ladder)o2).getVeloce()) ;
        else 
            return -(int)(((CycloRTData)o1).getVeloce() - ((CycloRTData)o2).getVeloce()) ;
    }
}
