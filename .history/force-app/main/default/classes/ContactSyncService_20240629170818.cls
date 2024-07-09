/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-29-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/syncContact/*')
global with sharing class ContactSyncService {
    @HttpPost
    global static void doPost(RestRequest req, RestResponse res) {
        // Parse the JSON request
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
        String email = (String) params.get('email');
        String firstName = (String) params.get('firstName');
        String lastName = (String) params.get('lastName');
        String phone = (String) params.get('phone');
        Boolean isDeleted = (Boolean) params.get('isDeleted');

        ContactSync.syncContact(email, firstName, lastName, phone, isDeleted);
    }
}
