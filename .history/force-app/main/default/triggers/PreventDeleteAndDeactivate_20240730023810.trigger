/**
 * @description       : Prevents deletion and deactivation of contacts by setting IsActive__C to false before insert
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger PreventDeleteAndDeactivate on Contact (before insert) {
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
}