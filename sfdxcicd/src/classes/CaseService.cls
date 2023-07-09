public with sharing class CaseService {
   public static void closeCases(Set<Id> caseIds, String closeReason) {
       
        // Validate parameters
        if(caseIds==null || caseIds.size()==0)
            throw new CaseServiceException('Case not specified.');
       
        if(closeReason==null)
            throw new CaseServiceException('Invalid closeReason to apply.');
       
        // Query Opportunities and Lines (SOQL inlined for this example, see Selector pattern in later module)
        List<Case> cases = [select Status, Reason from Case where Id in :caseIds];
        for(Case c : cases) {
            c.Status = 'Closed';
            c.Reason = closeReason;
        }
        // Update the database
        SavePoint sp = Database.setSavePoint();
        try {
            update cases;
        } catch (Exception e) {
            // Rollback
            Database.rollback(sp);
            // Throw exception on to caller
            throw e;
        }       
    }
    // Custom exception
    public class CaseServiceException extends Exception {} 
}