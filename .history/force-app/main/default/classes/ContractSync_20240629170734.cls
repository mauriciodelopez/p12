/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-29-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class ContractSync {
    @AuraEnabled
    public static void syncContract(String externalId, String contractName, Date startDate, Date endDate, Decimal amount) {
        Contract existingContract = [SELECT Id, ExternalId__c FROM Contract WHERE ExternalId__c = :externalId LIMIT 1];

        if (existingContract != null) {
            // Update existing contract
            existingContract.Name = contractName;
            existingContract.StartDate = startDate;
            existingContract.EndDate = endDate;
            existingContract.Amount__c = amount;
            update existingContract;
        } else {
            // Create new contract
            Contract newContract = new Contract(
                ExternalId__c = externalId,
                Name = contractName,
                StartDate = startDate,
                EndDate = endDate,
                Amount__c = amount
            );
            insert newContract;
            // Return Salesforce Id to CRM AXG
            // Your code to return the ID here
        }
    }
}
