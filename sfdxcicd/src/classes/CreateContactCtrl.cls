global class CreateContactCtrl {
	private ApexPages.StandardController stdCtr;
    public Contact contacto {get;set;}
    global Boolean chkBoxAgree{get;set;}

    public CreateContactCtrl(ApexPages.StandardController stdController) {
        System.debug('Iniciando constructor clase CreateContactCtrl');
        this.stdCtr = stdController;
        this.contacto = (Contact)stdCtr.getRecord();
       
        contacto = new Contact();
        User usuario = [SELECT id FROM user WHERE id = :userInfo.getUserId()];
        contacto.ownerid = usuario.id;
        chkBoxAgree = false;
    }

    public pagereference saveUpdate() {
        
        if(chkBoxAgree){
            contacto.Email = 'notiene@notiene.com';
        }
        insert contacto;
        Contact auxContact = [SELECT id, firstname, lastname, email FROM contact WHERE id = :contacto.id];
        if (auxContact != null) {
            contacto.firstname = auxContact.firstname;
            System.debug('Contacto actualizado: ' + auxContact.id);
            contacto = auxContact;
            System.debug('contacto: '+contacto);
            System.debug('Nombre de contacto: ' + contacto.firstname);
            
            pagereference pg = new pagereference('/' + contacto.Id);
            
        	SendEmail(auxContact.email, contacto.Id);
            pg.setRedirect(true);
            return pg;
            
        }else {
            System.debug('Contacto no se actualizo');
            System.debug('No se ha actualizado el contacto');
        }
        return null;
    }
    
    private void SendEmail(String emailAddressToSend, id contactId)
     {
        String subject = 'Verification Email';
        
        string sfURL= System.URL.getSalesforceBaseUrl().getHost();
        string myURL= 'https://'+sfUrl+'/apex/VerifyEmail?objectName=contact&recordId=' + contactId;

        
        String body = 'This is testing for your email is valid, the link will be expired in 3 minutes. ' + myURL;
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        // Now sets the below paramaters of the email object
        email.setSubject( subject );
        // Here I am accessing current user email id to whom we are sending email
        email.setToAddresses( new String[] {emailAddressToSend} );
        email.setPlainTextBody( body );
        // Sends the email
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});  
      }

    public PageReference cancelar(){
        String retID = ApexPages.currentPage().getParameters().get('retID');
        PageReference pr = new PageReference('/' + retID);
        pr.setRedirect(true);
        return pr;
    }
    
     global void suministroCheck(){
        chkBoxAgree = !chkBoxAgree;
     }
}