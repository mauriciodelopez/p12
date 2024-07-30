/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger PreventDeleteAndDeactivate on SOBJECT (before insert) {
    List<Contact> contactsToUpdate = new List<Contact>();

    for (Contact c : Trigger.old) {
        if (c.IsActive__C) {
            c.IsActive__C = false;
            contactsToUpdate.add(c);
        }
    }

    if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }

    // Add an error to prevent the delete operation
    for (Contact c : Trigger.old) {
        c.addError('Contacts cannot be deleted. The contact has been marked as inactive instead.');
    }

}