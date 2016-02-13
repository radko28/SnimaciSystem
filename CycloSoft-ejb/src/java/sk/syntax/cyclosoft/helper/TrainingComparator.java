/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.helper;

import java.util.Comparator;
import sk.syntax.cyclosoft.data.Ladder;

/**
 *
 * @author radko28
 */
public class TrainingComparator implements Comparator<Ladder> {
    public int compare(Ladder o1, Ladder o2) {
        return -(int)(o1.getTraining() - o2.getTraining()) ;
    }
}   
