/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
/**
 * @description       : Test class for ContactService
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class ContactServiceTest {
    @isTest
    static void testDeactivateContact() {
        // Créer un contact de test
        Contact testContact = new Contact(
            LastName = 'Test',
            Inactive__c = false
        );
        insert testContact;

        // Exécuter une requête HTTP DELETE simulée
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/Contact/' + testContact.Id;
        req.httpMethod = 'DELETE';
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        String response = ContactService.deactivateContact();
        Test.stopTest();

        // Vérifier la réponse
        System.assertEquals('Contact is deactivated', response, 'Le contact aurait dû être désactivé');

        // Vérifier que le contact est désactivé
        Contact updatedContact = [SELECT Inactive__c FROM Contact WHERE Id = :testContact.Id];
        System.assertEquals(true, updatedContact.Inactive__c, 'Le contact devrait être désactivé');
    }
}