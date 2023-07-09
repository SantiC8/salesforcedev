/** 
* ===================================================================================
* @className        PA_CreateDataForTest
* @description      Clase para crear data para test
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @dateCreated      2023/03/11
* ==============================================================================================================================
*/
@isTest
public with sharing class PA_CreateDataForTest {
    
    public static void createCharacters(Integer amount)
    {
        List<Character__c> charactersList = new List<Character__c>();

        for(Integer i = 0; i<amount; i++){
            Character__c character = new Character__c();
            character.ExtId__c = String.valueOf(i);
            character.Gender__c = math.mod(i, 2) == 0 ? 'Male' : 'Female';
            character.Status__c =  math.mod(i, 2) == 0 ? 'Alive' : 'Dead';
            character.Species__c =  math.mod(i, 2) == 0 ? 'Human' : 'Unknown';
            character.Url__c =  'https://test.com';
            character.Name__c = 'Rick and Morty Test ' + i;
            character.ImageUrl__c =  'https://testimage.com';
            charactersList.add(character);
        }

        insert charactersList;
    }
}