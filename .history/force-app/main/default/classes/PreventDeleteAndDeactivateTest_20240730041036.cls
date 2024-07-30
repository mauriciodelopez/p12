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
        // Créer un contact actif
        Contact activeContact = new Contact(
            LastName = 'Test',
            IsActive__C = true
        );
        insert activeContact;

        // Essayer de supprimer le contact
        try {
            delete activeContact;
            System.assert(false, 'Expected an exception to be thrown');
        } catch (DmlException e) {
            // Afficher le message d'exception réel pour le diagnostic
            System.debug('Exception message: ' + e.getMessage());
            // Vérifier que l'exception est lancée
            System.assert(e.getMessage().contains('Deletion is not allowed. The contact has been deactivated instead.'), 'Unexpected exception message: ' + e.getMessage());
        }

        // Recharger le contact depuis la base de données
        Contact updatedContact = [SELECT IsActive__C FROM Contact WHERE Id = :activeContact.Id];
        
        // Vérifier que le contact est désactivé
        System.assertEquals(true, updatedContact.IsActive__C, 'The contact should be deactivated');
    }
}