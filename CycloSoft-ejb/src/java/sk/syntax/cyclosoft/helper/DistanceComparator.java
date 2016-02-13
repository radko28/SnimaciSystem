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
public class DistanceComparator implements Comparator<Object> {
    public int compare(Object o1, Object o2) {
        if(o1 instanceof Ladder)
            return -(int)(((Ladder)o1).getDistance() - ((Ladder)o2).getDistance()) ;
        else 
            return -(int)(((CycloRTData)o1).getDistance() - ((CycloRTData)o2).getDistance()) ;
    }
    
}
