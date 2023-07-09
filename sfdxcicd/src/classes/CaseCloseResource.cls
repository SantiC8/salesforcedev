@RestResource(urlMapping='/case/*/close/')
global class CaseCloseResource {
    @HttpPost
    global static String closeCase(String closeReason) {
        // Parse context
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        // Call the service
        CaseService.closeCases(
            new Set<Id> { caseId }, closeReason);
        return 'ok';
    }
}