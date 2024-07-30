/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/Contact/*')
global with sharing class ContactService {
    
    @HttpDelete
    global static String deactivateContact() {
        RestRequest request = RestContext.request;

        // Obtenir l'ID du contact à désactiver à partir de l'URL
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        // Obtenir le contact à désactiver et définir le champ Inactive__c à "true"
        try {
            Contact thisContact = [SELECT Id, IsActive__c FROM Contact WHERE Id = :contactId];
            thisContact.IsActive__c = false;

            // Mettre à jour le contact et retourner un message pour confirmer la désactivation
            update thisContact;
            return 'Contact is deactivated';
        } catch (Exception e) {
            // Gestion des exceptions en cas d'erreur
            return 'Error deactivating contact: ' + e.getMessage();
        }
    }
}
