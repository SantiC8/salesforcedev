public class VerifyEmailCtrl {
    public Id contactId;
	public Contact contacto;
    public Boolean modificado{get;set;}
    
    
    public VerifyEmailCtrl(ApexPages.StandardController stdController){
        contactId = ApexPages.currentPage().getParameters().get('recordId');
        system.debug('contactid: ' + contactId);
        contacto = [SELECT id, EmailVerified__c FROM Contact WHERE id =:contactId];
    }
    
    public void doSomeDMLStuff(){
        contacto.EmailVerified__c = true;
        update contacto;
        modificado = true;
    }
}