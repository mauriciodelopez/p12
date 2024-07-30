/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger PreventDeleteAndDeactivate on Contact (before delete) {
    for (Contact c : Trigger.old) {
        if (c.IsActive__C) {
            c.IsActive__C = false;
            c.addError('Deletion is not allowed. The contact has been deactivated instead.');
        }
    }
}