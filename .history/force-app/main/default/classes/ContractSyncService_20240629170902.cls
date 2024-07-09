/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-29-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/syncContract/*')
global with sharing class ContractSyncService {
    @HttpPost
    global static void doPost(RestRequest req, RestResponse res) {
        // Parse the JSON request
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
        String externalId = (String) params.get('externalId');
        String contractName = (String) params.get('contractName');
        Date startDate = (Date) params.get('startDate');
        Date endDate = (Date) params.get('endDate');
        Decimal amount = (Decimal) params.get('amount');

        ContractSync.syncContract(externalId, contractName, startDate, endDate, amount);
    }
}
