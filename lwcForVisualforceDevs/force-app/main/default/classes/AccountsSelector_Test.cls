@isTest
private class AccountsSelector_Test {
	
    @isTest
    private static void selectAccounts(){
		// Test data
        Account acct = new Account();
        acct.Description = 'Something cool';
        acct.Name = 'CoolItem';
        acct.AnnualRevenue = 30000;
        insert acct;                 
        // Query (including FieldSet fields)
        AccountsSelector acctSelector = new AccountsSelector();
        List<Account> accts = acctSelector.selectById(new Set<Id> { acct.Id });
        // Assert (FieldSet has been pre-configured to include MyText__c here)
        System.assertEquals('Domain classes rock!', accts[0].Description);    
        System.assertEquals('CoolItem', accts[0].Name);     
        System.assertEquals(30000, accts[0].AnnualRevenue);
    }
}