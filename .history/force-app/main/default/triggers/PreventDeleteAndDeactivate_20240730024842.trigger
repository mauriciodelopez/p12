/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger PreventDeleteAndDeactivate on Contact (before delete) {
    List<Contact> contactsToUpdate = new List<Contact>();

    for (Contact c : Trigger.old) {
        if (c.IsActive__C) {
            c.IsActive__C = false;
            contactsToUpdate.add(c);
        }
    }

    if (!contactsToUpdate.isEmpty()) {
        // Mettre à jour les contacts pour décocher IsActive__C
        update contactsToUpdate;
        // Lancer une exception pour empêcher la suppression
        for (Contact c : contactsToUpdate) {
            c.addError('Deletion is not allowed. The contact has been deactivated instead.');
        }
    }
}