/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.helper;

/**
 *
 * @author ext5201m
 */
public class RoundNumber {
    public static double round(float number) {
        return Math.ceil(number*100)/100;
    }
}
