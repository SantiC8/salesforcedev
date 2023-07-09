/** 
* ===================================================================================
* @className        PA_BatchCarga
* @description      Clase batch para realizar los callouts y no llegar a los limites
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @testClass        PA_BatchCarga_Test
* @dateCreated      2023/03/10
* ==============================================================================================================================
*/
public class PA_BatchCarga implements Database.Batchable<Object>, Database.AllowsCallouts,  Database.Stateful
{
    private Map<String, Character__c> charactersMap;

    public PA_BatchCarga(){
        charactersMap = new Map<String, Character__c>();
    }

    public Iterable<Object> start(Database.BatchableContext bc)
    {   
        List<PA_CharacterCallout> actions = new List<PA_CharacterCallout>();
        for(Integer i = 1;i <=826; i++) // Refactorizar harcodeado
        {
            String externalId = String.valueOf(i);
            Character__c c = new Character__c();
            c.ExtId__c = externalId;
            charactersMap.put(externalId, c);
            actions.add(new PA_CharacterCallout(externalId, charactersMap)); 
        }
        return (Iterable<Object>)actions;
    }
 
    public void execute(Database.BatchableContext bc, List<Object> scope)
    {
        
        for(PA_CharacterCallout action : (List<PA_CharacterCallout>)scope)
        {
            charactersMap = action.processCallout();
        }
    }

    public void finish(Database.BatchableContext bc)
    {
        Set<Id> successCharactersId = new Set<Id>();
        List<String> errors = new List<String>();

        Schema.SObjectField ftoken = Character__c.Fields.ExtId__c;
        Database.UpsertResult[] resultCharacters = Database.upsert(charactersMap.values(), ftoken,false);
        PA_CalloutService.proccesDatabaseUpsertResults(resultCharacters, successCharactersId, errors);
        System.debug('Las Errores en Establecimientos fueron: ' + errors);
        System.debug('Los Establecimientos correctos: ' + successCharactersId);
    }
}