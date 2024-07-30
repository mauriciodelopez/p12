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
            // Clonar el contacto y asignar el ID
            Contact contactToUpdate = new Contact(Id = c.Id, IsActive__C = false);
            contactsToUpdate.add(contactToUpdate);

            // Añadir un error para prevenir la eliminación
            c.addError('Deletion is not allowed. The contact has been deactivated instead.');
        }
    }

    if (!contactsToUpdate.isEmpty()) {
        try {
            update contactsToUpdate;
        } catch (DmlException e) {
            System.debug('Error al actualizar los contactos: ' + e.getMessage());
        }
    }
}
