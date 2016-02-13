/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.domain;

import java.io.Serializable;
import java.util.List;
import sk.syntax.cyclosoft.helper.Paging;

/**
 *
 * @author radko28
 */
public class CycloList extends Paging implements Serializable {
    private static final long serialVersionUID = 5L;
    private List<Cyclo> cyloList;

    public List<Cyclo> getCyloList() {
        return cyloList;
    }

    public void setCyloList(List<Cyclo> cyloList) {
        this.cyloList = cyloList;
    }
}
