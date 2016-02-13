/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.helper;

import java.io.Serializable;

/**
 *
 * @author radko28
 */
public class Paging implements Serializable {
    private int row;
    private int rowsPerPage;    
    private int rows;

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getRowsPerPage() {
        return rowsPerPage;
    }

    public void setRowsPerPage(int rowsPerPage) {
        this.rowsPerPage = rowsPerPage;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }
    
    public int getRowFrom() {
        return row;
    } 
    
    public int getRowTo() {
        int rowTo = row + rowsPerPage - 1;
        rowTo = (rowTo > rows)?rows:rowTo;
        return rowTo;       
    } 

}
