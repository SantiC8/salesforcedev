/** 
* ===================================================================================
* @className        PA_BatchCarga_Test
* @description      Clase test para PA_BatchCarga
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @dateCreated      2023/03/11
* ==============================================================================================================================
*/
@isTest
public with sharing class PA_BatchCarga_Test {

    @isTest
    private static void testBatchCarga(){

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PA_ChracterCallout_Mock('1', 200));
        PA_BatchCarga bc = new PA_BatchCarga();
        Database.executeBatch(bc, 100);
        Test.stopTest();

        List<Character__c> charactersList = [SELECT Id, Name__c FROM Character__c WHERE ExtId__c = '1'];
        Assert.areEqual('Rick', charactersList[0].Name__c);
    }
}