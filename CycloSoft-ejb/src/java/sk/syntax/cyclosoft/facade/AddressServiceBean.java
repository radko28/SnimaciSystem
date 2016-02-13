/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.facade;

import javax.ejb.Stateless;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.helper.AddressEmail;
import javax.ejb.EJB;
import javax.ejb.Stateless;



/**
 *
 * @author radko28
 */
@Stateless
public class AddressServiceBean implements AddressServiceRemote {
    @EJB private AddressRemote addressRemote;    

    public boolean forgetPassword(String email) throws Exception {
        Address address = addressRemote.getAddress(email);
        String body = "Hello,";
        body += "\n\nthank you that you use CycloSoft http://212.67.19.12:8080/CycloSoft.";
        body += "\nYour login is    : " + email + ".";
        body += "\nYour password is : " + address.getPassword() + ".";
        body += "\n\nSyntax";
        body += "\ndesign & development software ";
        body += "\nEmail: radoslav.kuzma@elson.sk";
        body += "\nMobil: +421911760775";
        body += "\nAdresa:";
        body += "\nTerany 27";
        body += "\n962 68";        
        body += "\nSlovakia";                        
                
        boolean result = AddressEmail.send("mail.elson.sk", 25, "radoslav.kuzma@elson.sk", email,
                 "CycleSoft: forget password", body);
        return result;
    }    
    
    public boolean registerUser(String email) throws Exception {
        Address address = addressRemote.getAddress(email);
        String body = "Hello,";
        body += "\n\nthank you for your registration in CycloSoft http://212.67.19.12:8080/CycloSoft.";
        body += "\nYour login is    : " + email + ".";
        body += "\nYour password is : " + address.getPassword() + ".";
        body += "\n\nSyntax";
        body += "\ndesign & development software";
        body += "\nEmail: radoslav.kuzma@elson.sk";
        body += "\nMobil: +421911760775";
        body += "\nAdresa:";
        body += "\nTerany 27";
        body += "\n962 68";        
        body += "\nSlovakia";                        
        
                
        boolean result = AddressEmail.send("mail.elson.sk", 25, "radoslav.kuzma@elson.sk", email,
                 "CycleSoft: registration", body);
        return result;
    }    
    
    public boolean changePassword(String email) throws Exception {
        Address address = addressRemote.getAddress(email);
        String body = "Hello,";
        body += "\n\nthank you that you use CycloSoft http://212.67.19.12:8080/CycloSoft.";
        body += "\nYour login is    : " + email + ".";
        body += "\nYour password is : " + address.getPassword() + ".";
        body += "\n\nSyntax";
        body += "\ndesign & development software";
        body += "\nEmail: radoslav.kuzma@elson.sk";
        body += "\nMobil: +421911760775";
        body += "\nAdresa:";
        body += "\nTerany 27";
        body += "\n962 68";        
        body += "\nSlovakia";                        
        
                
        boolean result = AddressEmail.send("mail.elson.sk", 25, "radoslav.kuzma@elson.sk", email,
                 "CycleSoft: change password", body);
        return result;
    }    
    
}
