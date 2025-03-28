public class AccountTriggerHelper {
     /*
    * Question 1
    * Account Trigger
    * When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
    * Trigger should only fire on insert.
    */
    public static void setDefaultValues(List<Account> accounts) {
        for (Account prospectAccount : accounts) {
            if (String.isEmpty(prospectAccount.Type)) {
                prospectAccount.Type = 'Prospect';
            }
    /*
    * Question 2
    * Account Trigger
    * When an account is inserted copy the shipping address to the billing address.
    * BONUS: Check if the shipping fields are empty before copying.
    * Trigger should only fire on insert.
    */           
    if (!String.isEmpty(prospectAccount.ShippingStreet) || 
        !String.isEmpty(prospectAccount.ShippingCity) || 
        !String.isEmpty(prospectAccount.ShippingState) || 
        !String.isEmpty(prospectAccount.ShippingPostalCode) || 
        !String.isEmpty(prospectAccount.ShippingCountry)){

                prospectAccount.BillingStreet     = prospectAccount.ShippingStreet;
                prospectAccount.BillingCity       = prospectAccount.ShippingCity;
                prospectAccount.BillingState      = prospectAccount.ShippingState;
                prospectAccount.BillingPostalCode = prospectAccount.ShippingPostalCode;
                prospectAccount.BillingCountry    = prospectAccount.ShippingCountry;
            }
    /*
    * Question 3
    * Account Trigger
	* When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
    * Trigger should only fire on insert.
    */            
            if (!String.isEmpty(prospectAccount.Phone) && !String.isEmpty(prospectAccount.Website) && !String.isEmpty(prospectAccount.Fax)) {
                prospectAccount.Rating = 'Hot';
            }
        }
    }
    /*
    * Question 4
    * Account Trigger
    * When an account is inserted create a contact related to the account with the following default values:
    * LastName = 'DefaultContact'
    * Email = 'default@email.com'
    * Trigger should only fire on insert.
    */
    public static void createDefaultContacts(List<Account> accounts) {
        List<Contact> contactsToInsert = new List<Contact>();
        for (Account prospectAccount : accounts) {
            contactsToInsert.add(new Contact(
                LastName = 'DefaultContact',
                Email = 'default@email.com',
                AccountId = prospectAccount.Id
            ));
        }
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}