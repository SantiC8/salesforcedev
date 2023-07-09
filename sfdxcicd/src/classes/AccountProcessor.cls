public without sharing class AccountProcessor {
	
    @future
    public static void countContacts(List<Id> accountIds){
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN
                                  :accountIds ];
        for (Account acct: accounts){
            acct.Number_of_Contacts__c = acct.Contacts.size();
        }
        
        update accounts;
    }
    
}