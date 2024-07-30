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

        // Obtener el ID del contacto a desactivar de la URL
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        // Obtener el contacto a desactivar y establecer el campo IsActive__c a "false"
        try {
            Contact thisContact = [SELECT Id, IsActive__c FROM Contact WHERE Id = :contactId LIMIT 1];
            
            if(thisContact != null) {
                thisContact.IsActive__c = false;
                
                // Mettre à jour le contact et retourner un message pour confirmer la désactivation
                update thisContact;
                return 'Contact is deactivated';
            } else {
                return 'Contact not found';
            }
        } catch (Exception e) {
            // Gestion des exceptions en cas d'erreur
            return 'Error deactivating contact: ' + e.getMessage();
        }
    }
}
