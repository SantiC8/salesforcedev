/** 
* ===================================================================================
* @className        PA_CharacterCallout
* @description      Clase para hacer Consulta de Personaje a la api
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @testClass        PA_CharacterCallout_Test
* @dateCreated      2023/03/10
* ==============================================================================================================================
*/
public class PA_CharacterCallout
{
    public String ExtId;
    private Map<String, Character__c> charactersMap;

    public PA_CharacterCallout(String ExtId, Map<String, Character__c> charactersMap)
    {
        this.ExtId = ExtId;
        this.charactersMap = charactersMap;
    }

    public Map<String, Character__c> processCallout() {

        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest(); 
            req.setEndpoint('callout:Rick_and_Morty/character/' + ExtId);
            req.setMethod('GET');
            
            HTTPResponse res = new HTTPResponse();
            res = http.send(req);
            
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201)
            {
                // Refactor procesar respuesa en clase de servicio
                Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                System.debug('Mapa de response: ' + response);
                charactersMap.get(ExtId).Gender__c = (String)response.get('gender');
                charactersMap.get(ExtId).Status__c =  (String)response.get('status');
                charactersMap.get(ExtId).Species__c =  (String)response.get('species');
                charactersMap.get(ExtId).Url__c =  (String)response.get('url');
                charactersMap.get(ExtId).Name = (String)response.get('name');
                charactersMap.get(ExtId).Name__c = (String)response.get('name');
                charactersMap.get(ExtId).ImageUrl__c =  (String)response.get('image');
            }else{
                System.debug('Error: ' + res);
            }  
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
        
        return charactersMap;    
    }
}