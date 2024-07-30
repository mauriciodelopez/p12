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
            Contact contactToUpdate = c.clone(false, true, false, false); // Clone sans ID, en lecture-écriture
            contactToUpdate.Id = c.Id; // Réassigner l'ID
            contactToUpdate.IsActive__C = false;
            contactsToUpdate.add(contactToUpdate);
        }
    }

    if (!contactsToUpdate.isEmpty()) {
        // Mettre à jour les contacts pour décocher IsActive__C
        update contactsToUpdate;
        // Lancer une exception pour empêcher la suppression
        for (Contact c : Trigger.old) {
            c.addError('Deletion is not allowed. The contact has been deactivated instead.');
        }
    }
}