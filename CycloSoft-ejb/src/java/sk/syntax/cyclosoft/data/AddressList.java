/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.data;

import java.io.Serializable;
import java.util.List;
import sk.syntax.cyclosoft.domain.Address;
import sk.syntax.cyclosoft.helper.Paging;

/**
 *
 * @author ext5201m
 */
public class AddressList extends Paging implements Serializable {
    private static final long serialVersionUID = 7L;
    private List<Address> addressList;

    public List<Address> getAddressList() {
        return addressList;
    }

    public void setAddressList(List<Address> addressList) {
        this.addressList = addressList;
    }
}
