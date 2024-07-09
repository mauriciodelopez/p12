/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-04-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping = '/MigrateContacts')
global with sharing class MigrateContacts {
    @HttpPost
    global static Map<String, String> migrateContact(String FirstName, String LastName, String Phone, String Email) {
        Map<String, String> response = new Map<String, String>();
        
        try {
            // Busca el contacto en Salesforce por el correo electrónico
            List<Contact> existingContacts = [SELECT Id, Email FROM Contact WHERE Email = :Email LIMIT 1];
            
            if (!existingContacts.isEmpty()) {
                // El contacto ya existe en Salesforce
                Contact existingContact = existingContacts[0];
                response.put('SalesforceId', existingContact.Id);
                response.put('Message', 'Contact already exists in Salesforce. CRM should be updated with this ID.');
            } else {
                // El contacto no existe, crear uno nuevo
                Contact newContact = new Contact(
                    FirstName = FirstName,
                    LastName = LastName,
                    Phone = Phone,
                    Email = Email
                );
                insert newContact;
                response.put('SalesforceId', newContact.Id);
                response.put('Message', "New contact created in Salesforce.");
            }
            
            response.put("StatusCode", "200");
        } catch (Exception e) {
            response.put("Error", e.getMessage());
            response.put("StatusCode", "500");
        }
        
        return response;
    }
}