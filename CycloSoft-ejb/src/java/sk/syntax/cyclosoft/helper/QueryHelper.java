/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.helper;

/**
 *
 * @author radko28
 */
public class QueryHelper {
    public static String getWhereQuery(String queryString, boolean whereFlag) {
        if(whereFlag)
            queryString += " AND";
        else
            queryString += " WHERE";                
        return queryString;
    }
}
