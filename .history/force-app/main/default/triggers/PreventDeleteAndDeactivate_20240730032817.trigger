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
            // Clonar el contacto sin el ID y luego establecer el ID del original
            Contact contactToUpdate = c.clone(false, true, true, true);
            contactToUpdate.Id = c.Id; // Establecer el ID del contacto original

            // Verificar que el ID está correctamente establecido
            if (contactToUpdate.Id != null) {
                contactToUpdate.IsActive__C = false;
                contactsToUpdate.add(contactToUpdate);
            } else {
                System.debug('Error: el ID del contacto clonado no se estableció correctamente.');
            }
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
