/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.syntax.cyclosoft.web.helper;

import sk.syntax.cyclosoft.domain.CycloRT;
import sk.syntax.cyclosoft.web.data.CycloRTValueObject;

/**
 *
 * @author radko28
 */
public class ServletHelper {
    
    public static CycloRT cycloRTValueObjectToCycloRT(CycloRTValueObject cycloRTValueObject) {
        CycloRT result = new CycloRT();
        result.setId(cycloRTValueObject.getId());
        result.setUserId(cycloRTValueObject.getUserId());
        result.setVeloce(cycloRTValueObject.getVeloce());
        result.setDistance(cycloRTValueObject.getDistance());
        return result;
    }

}
