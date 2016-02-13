/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.data;

import java.io.Serializable;
import java.util.List;
import sk.syntax.cyclosoft.domain.Team;
import sk.syntax.cyclosoft.helper.Paging;

/**
 *
 * @author ext5201m
 */
public class TeamList extends Paging implements Serializable {
    private static final long serialVersionUID = 8L;
    private List<Team> teamList;

    public List<Team> getTeamList() {
        return teamList;
    }

    public void setLadderList(List<Team> teamList) {
        this.teamList = teamList;
    }
}
