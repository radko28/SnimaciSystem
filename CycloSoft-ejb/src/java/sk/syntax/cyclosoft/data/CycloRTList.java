/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.data;

import java.io.Serializable;
import java.util.List;
import sk.syntax.cyclosoft.helper.Paging;

/**
 *
 * @author radko28
 */

public class CycloRTList extends Paging implements Serializable {
    private static final long serialVersionUID = 9L;
    private List<CycloRTData> cycloRTList;

    public List<CycloRTData> getCycloRTList() {
        return cycloRTList;
    }

    public void setCycloRTList(List<CycloRTData> cycloRTList) {
        this.cycloRTList = cycloRTList;
    }
}

