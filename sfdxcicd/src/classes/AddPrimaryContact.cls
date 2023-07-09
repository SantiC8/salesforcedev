public class AddPrimaryContact implements Queueable{
    
    private Contact ct;
    private String st;
	
    public AddPrimaryContact(Contact ct, String st){
        this.ct = ct;
        this.st = st;
    }
    
    public void execute(QueueableContext context){
        
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState=:st LIMIT 200];
        
        List<Contact> contacts = new List<Contact>();
        
        for(Account acct : accounts){
            Contact contactClone = ct.clone();
            contactClone.AccountId = acct.Id;
            contacts.add(contactClone);
        }
        insert contacts;
    }
}