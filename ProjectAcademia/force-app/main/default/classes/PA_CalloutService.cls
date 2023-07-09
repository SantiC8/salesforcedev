/** 
* ===================================================================================
* @className        PA_CalloutService
* @description      Clase de servicio para metodos que se pueden reutilizar
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @testClass        PA_CalloutService_Test
* @dateCreated      2023/03/10
* ==============================================================================================================================
*/
public class PA_CalloutService {
    
    /**
     * @description Método que itera sobre el Database Result y retorna los id correctos e 
     * incorrectos
     * @param myResult resultados de la operacion
     * @param successIds
     * @param errores Lista de errores
     * @return void
    */
    public static void proccesDatabaseUpsertResults(Database.UpsertResult[] myResult, Set<Id> successIds,List<String> errores)
    {
        // Iterate through each returned result
        for (Database.UpsertResult sr : myResult) {
            if (!sr.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    errores.add('The following error has occurred. ' + err.getStatusCode() + ': ' + 
                                err.getMessage() + '. ' + 'Fields that affected this error: ' + err.getFields());
                }
            }else{
                successIds.add(sr.getId());
            }
        } 
    }
}