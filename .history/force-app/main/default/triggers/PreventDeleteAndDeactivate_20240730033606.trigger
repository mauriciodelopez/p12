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
            // Desactivar el contacto antes de eliminar
            c.IsActive__C = false;
            // Añadir error para prevenir la eliminación
            c.addError('Deletion is not allowed. The contact has been deactivated instead.');
        }
    }
}
