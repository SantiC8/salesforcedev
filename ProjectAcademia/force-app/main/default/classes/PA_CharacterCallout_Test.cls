/** 
* ===================================================================================
* @className        PA_CharacterCallout_Test
* @description      Clase test para PA_CharacterCallout
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @dateCreated      2023/03/11
* ==============================================================================================================================
*/
@isTest
public with sharing class PA_CharacterCallout_Test {
    
    @isTest
    private static void testCalloutRickAndMortyApi(){

        Map<String, Character__c> charactersMap = new Map<String, Character__c>();

        List<PA_CharacterCallout> actions = new List<PA_CharacterCallout>();
        for(Integer i = 1;i <=10; i++)
        {
            String externalId = String.valueOf(i);
            Character__c c = new Character__c();
            c.ExtId__c = externalId;
            charactersMap.put(externalId, c);
            actions.add(new PA_CharacterCallout(externalId, charactersMap)); 
        }

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PA_ChracterCallout_Mock('1', 200));

        for(PA_CharacterCallout action : actions)
        {
            charactersMap = action.processCallout();
        }

        Test.stopTest();

        Assert.areEqual('Rick', charactersMap.get('1').Name__c);
    }
}