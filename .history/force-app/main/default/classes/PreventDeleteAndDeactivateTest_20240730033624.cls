/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class PreventDeleteAndDeactivateTest {
    @isTest
    static void testPreventDeleteAndDeactivate() {
        // Crear un contacto activo
        Contact activeContact = new Contact(
            LastName = 'Test',
            IsActive__C = true
        );
        insert activeContact;

        // Intentar eliminar el contacto
        try {
            delete activeContact;
            System.assert(false, 'Se esperaba que se lanzara una excepción');
        } catch (DmlException e) {
            // Mostrar el mensaje de excepción real para el diagnóstico
            System.debug('Mensaje de excepción: ' + e.getMessage());
            // Verificar que la excepción se lance con el mensaje esperado
            System.assert(e.getMessage().contains('Deletion is not allowed. The contact has been deactivated instead.'), 'Mensaje de excepción inesperado: ' + e.getMessage());
        }

        // Recargar el contacto desde la base de datos
        Contact updatedContact = [SELECT IsActive__C FROM Contact WHERE Id = :activeContact.Id];

        // Verificar que el contacto esté desactivado
        System.assertEquals(false, updatedContact.IsActive__C, 'El contacto debería estar desactivado');
    }
}
