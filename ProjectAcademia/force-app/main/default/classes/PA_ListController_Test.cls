/** 
* ===================================================================================
* @className        PA_ListController_Test
* @description      Clase test para PA_ListController
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @dateCreated      2023/03/11
* ==============================================================================================================================
*/
@isTest
public with sharing class PA_ListController_Test {

    @TestSetup
    static void makeData(){
        PA_CreateDataForTest.createCharacters(10);
    }

    @isTest
    private static void testGetData(){

        List<Character__c> charactersList = PA_ListController.getData();

        Assert.areEqual(10, charactersList.size(), 'Datos retornados correctamente');
    }
}