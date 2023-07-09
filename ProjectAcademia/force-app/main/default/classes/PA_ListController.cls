/** 
* ===================================================================================
* @className        PA_ListController
* @description      Controller class para lwc charactersList
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @testClass        PA_ListController_Test
* @dateCreated      2023/11/03
* ==============================================================================================================================
*/
public with sharing class PA_ListController {
    
    @AuraEnabled(cacheable=true)
    public static List<Character__c> getData(){
        return [SELECT Id, Name__c, Species__c, Gender__c, Status__c, ExtId__c FROM Character__c WHERE Name__c != null];
    }
}