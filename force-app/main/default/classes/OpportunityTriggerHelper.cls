public class OpportunityTriggerHelper {
    /*
    * Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */
    public static void validateAmount(List<Opportunity> opportunities) {
        for (Opportunity validateOpportunityAmount : opportunities) {
            if (validateOpportunityAmount.Amount < 5000) {
                validateOpportunityAmount.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
    /*
     * Question 6
	 * Opportunity Trigger
	 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
	 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
	 * Trigger should only fire on delete.
	 */
    public static void preventDeletion(List<Opportunity> opportunities) {
        // Collect all Account IDs from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity preventOpportunityDeletion : opportunities) {
            if (preventOpportunityDeletion.AccountId != null) {
                accountIds.add(preventOpportunityDeletion.AccountId);
            }
        }
        // Query Accounts to get their Industry values
        Map<Id, Account> accountMap = new Map<Id, Account>(
            [SELECT Id, Industry 
            FROM Account 
            WHERE Id IN :accountIds]
        );

        // Prevent deletion if criteria are met
        for (Opportunity deleteOpportunity : opportunities) {
            Account relatedAccount = accountMap.get(deleteOpportunity.AccountId);
            if (relatedAccount != null && deleteOpportunity.StageName == 'Closed Won' && relatedAccount.Industry == 'Banking') {
                deleteOpportunity.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
    /*
    * Question 7
    * Opportunity Trigger
    * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
    * Trigger should only fire on update.
    */
    public static void setPrimaryContact(List<Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity setPrimaryContactOnOpportunity : opportunities) {
            if (setPrimaryContactOnOpportunity.AccountId != null) {
                accountIds.add(setPrimaryContactOnOpportunity.AccountId);
            }
        }
        if (!accountIds.isEmpty()) {
            Map<Id, Contact> ceoContacts = new Map<Id, Contact>();
            for (Contact ceoContact : [
                                        SELECT Id, AccountId 
                                        FROM Contact 
                                        WHERE AccountId IN :accountIds AND Title = 'CEO']) {
                ceoContacts.put(ceoContact.AccountId, ceoContact);
            }
            for (Opportunity ceoOpportunity : opportunities) {
                if (ceoContacts.containsKey(ceoOpportunity.AccountId)) {
                    ceoOpportunity.Primary_Contact__c = ceoContacts.get(ceoOpportunity.AccountId).Id;
                }
            }
        }
    }
}
