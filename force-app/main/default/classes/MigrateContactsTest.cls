/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-10-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class MigrateContactsTest {
    @isTest static void testMigrateContactNew() {
        // Préparer les données de test
        String testEmail = 'test@example.com';
        String testFirstName = 'Test';
        String testLastName = 'Example';
        String testPhone = '1234567890';

        // Appeler la méthode à tester
        Test.startTest();
        Map<String, String> response = MigrateContacts.migrateContact(testFirstName, testLastName, testPhone, testEmail);
        Test.stopTest();

        // Vérifier les résultats pour un nouveau contact
        System.assertEquals('200', response.get('StatusCode'), 'Status code should be 200');
        System.assertEquals('New contact created in Salesforce.', response.get('Message'), 'Message should indicate creation of new contact');
        System.assertNotEquals(null, response.get('SalesforceId'), 'SalesforceId should not be null for new contact');
    }

    @isTest static void testMigrateContactExisting() {
        // Créer un contact existant
        Contact existingContact = new Contact(Email = 'existing@example.com', FirstName = 'Existing', LastName = 'Contact', Phone = '0987654321');
        insert existingContact;

        // Appeler la méthode à tester avec les mêmes informations
        Test.startTest();
        Map<String, String> response = MigrateContacts.migrateContact('Existing', 'Contact', '0987654321', 'existing@example.com');
        Test.stopTest();

        // Vérifier les résultats pour un contact existant
        System.assertEquals('200', response.get('StatusCode'), 'Status code should be 200');
        System.assertEquals('Contact already exists in Salesforce. CRM should be updated with this ID.', response.get('Message'), 'Message should indicate existing contact');
        System.assertEquals(existingContact.Id, response.get('SalesforceId'), 'SalesforceId should match existing contact');
    }
}