@isTest
private class DailyLeadProcessorTest {
    
    private static String CRON_EXP = '0 0 0 ? * * *';

    @isTest
    static void testSchedulableClass(){
        
        // Load test data
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<500; i++){
            if(i<250){
                leads.add(new Lead(LastName='Connock', Company='Salesforce'));
            } else {
                leads.add(new Lead(LastName='Connock', Company='Salesforce', LeadSource='Other'));
            }
        }
            insert leads;
            
            // Perform the test
            Test.startTest();
            String jobId = System.schedule('Process Leads', CRON_EXP, new DailyLeadProcessor());
            Test.stopTest();
            
            // Check the result
            List<Lead> updateLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
            System.assertEquals(200, updateLeads.size());
            
        }
}