@isTest
private class AccountProcessorTest {

    @isTest
    static void countContactsTest(){
        // Load Test Data
        List<Account> accounts = new List<Account>();
        for(integer i = 0; i<300; i++){
            accounts.add(new Account(Name ='TestAccount' + i));
		}
        insert accounts;
        
        List<Contact> contacts = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        for(Account acct: accounts){
            contacts.add(new Contact(FirstName=acct.Name, LastName='TestContact', AccountId=acct.Id));
            accountIds.add(acct.Id);
		}
        insert contacts;
        
        // Do the test
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        
        // Check result
        List<Account> accts = [SELECT Id, Number_of_Contacts__c FROM Account];
        for (Account a : accts){
            System.assertEquals(1, a.Number_of_Contacts__c);
        }
    }
}