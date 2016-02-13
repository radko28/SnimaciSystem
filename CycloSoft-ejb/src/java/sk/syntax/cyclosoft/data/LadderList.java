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
 * @author EXT5201M
 */
public class LadderList extends Paging implements Serializable {
    private static final long serialVersionUID = 6L;
    private List<Ladder> ladderList;

    public List<Ladder> getLadderList() {
        return ladderList;
    }

    public void setLadderList(List<Ladder> ladderList) {
        this.ladderList = ladderList;
    }
}
