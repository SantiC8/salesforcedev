/** 
* ===================================================================================
* @className        PA_SchedulableCharacters
* @description      Clase batch para realizar los callouts y no llegar a los limites
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @testClass        PA_SchedulableCharacters_Test
* @dateCreated      2023/03/10
* bonus PA_SchedulableCharacters sch = new PA_SchedulableCharacters();
*       String cronexpression = '0 0 19 ? * 2-6'; Dias de semana a las 19
*       System.schedule('PA_SchedulableCharacters', cronexpression, sch); 1:20hrs hasta punto 2.3
* ==============================================================================================================================
*/ 
public with sharing class PA_SchedulableCharacters implements Schedulable
{
    public void execute(SchedulableContext sc)
    {
        PA_BatchCarga bc = new PA_BatchCarga();
        Database.executeBatch(bc, 100);
    }
}