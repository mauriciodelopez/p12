/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-29-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContactSync {
    @AuraEnabled
    public static void syncContact(String email, String firstName, String lastName, String phone, Boolean isDeleted) {
        Contact existingContact = [SELECT Id, Email FROM Contact WHERE Email = :email LIMIT 1];

        if (isDeleted) {
            if (existingContact != null) {
                existingContact.IsActive__c = false;
                update existingContact;
            }
            return;
        }

        if (existingContact != null) {
            // Update existing contact
            existingContact.FirstName = firstName;
            existingContact.LastName = lastName;
            existingContact.Phone = phone;
            update existingContact;
            // Return Salesforce Id to CRM AXG
            // Your code to return the ID here
        } else {
            // Create new contact
            Contact newContact = new Contact(
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                Phone = phone,
                IsActive__c = true
            );
            insert newContact;
            // Return Salesforce Id to CRM AXG
            // Your code to return the ID here
        }
    }
}
