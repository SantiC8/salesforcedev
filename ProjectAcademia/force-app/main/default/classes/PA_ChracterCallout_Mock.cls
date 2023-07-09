/** 
* ===================================================================================
* @className        PA_CharacterCallout
* @description      Clase mock para callput
* @author           Curetti Santiago
* @email            santiago.curetti@capgemini.com
* @version          V0.1
* @dateCreated      2023/03/10
* ==============================================================================================================================
*/
@isTest
public with sharing class PA_ChracterCallout_Mock implements HttpCalloutMock{

    private String externalId;
    private Integer statusCode;

    public PA_ChracterCallout_Mock(String externalId, Integer statusCode){
        this.externalId = externalId;
        this.statusCode = statusCode;
    }

    public HttpResponse respond(HttpRequest req){

        String response = '{"id":\''+ externalId +'\',"image":"https://testimage.com","name":"Rick","url":"https://test.com","species":"Human","status":"Alive","gender":"Male"}';
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(response);
        res.setStatusCode(this.statusCode);
        return res;
    }
}