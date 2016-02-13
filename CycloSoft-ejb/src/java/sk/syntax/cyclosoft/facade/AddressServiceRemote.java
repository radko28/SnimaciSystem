/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import javax.ejb.Remote;

/**
 *
 * @author radko28
 */
@Remote
public interface AddressServiceRemote {
    public boolean forgetPassword(String email) throws Exception;
    public boolean registerUser(String email) throws Exception;
    public boolean changePassword(String email) throws Exception;
}
