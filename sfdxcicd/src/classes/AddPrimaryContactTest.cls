@isTest
private class AddPrimaryContactTest {

    @isTest
    private static void testQueuableClass(){
        
        // Load test data
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0; i<500; i++){
            Account a = new Account(Name='Test Account');
            if(i<250){
                a.BillingState = 'NY';
            } else {
                a.BillingState = 'CA';
            }
            accounts.add(a);
        }
        insert accounts;
        
        Contact contact = new Contact(FirstName='Simon', LastName='Connock');
        insert contact;
        
        // Perform the test
        Test.startTest();
        Id jobId = System.enqueueJob(new AddPrimaryContact(contact, 'CA'));
        Test.stopTest();
        
        // Check the result
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(200, contacts.size());
    }
}