/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.helper;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author radko28
 */
public class Validation {
    public static boolean validateRegex(String input, String regex) {
        boolean result = false;
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(input);
        result = m.matches();
        return result;
    }

}
