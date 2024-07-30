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
            Contact contactToUpdate = c.clone(false, true, true, true); // Clonación sin ID y con valores originales
            contactToUpdate.Id = c.Id; // Asegúrate de que el ID está establecido
            contactToUpdate.IsActive__C = false;
            contactsToUpdate.add(contactToUpdate);
        }
    }

    if (!contactsToUpdate.isEmpty()) {
        try {
            update contactsToUpdate;
        } catch (DmlException e) {
            System.debug('Error al actualizar los contactos: ' + e.getMessage());
            // Manejar la excepción si es necesario
        }

        for (Contact c : Trigger.old) {
            c.addError('Deletion is not allowed. The contact has been deactivated instead.');
        }
    }
}
