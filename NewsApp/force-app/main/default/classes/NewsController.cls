public with sharing class NewsController {
    
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> retriveNews(){

        HttpRequest httpReq = new HttpRequest();
        // Seria mejor obtenerla de algun lado
        httpReq.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d34cc033304e4eda993192828ae87045');
        httpReq.setMethod('GET');

        Map<String, Object> newsJsonData = new Map<String, Object>();
        String response;

        try {
            Http httpCall = new Http();
            HttpResponse httpRes = httpCall.send(httpReq);

            if (httpRes.getStatusCode() == 200) {
                response = httpRes.getBody();
            } else {
                throw new CalloutException(httpRes.getBody());
            }

        } catch (Exception ex) {
            throw ex;
        }

        if(!String.isBlank(response)){
            newsJsonData = (Map<String, Object>)JSON.deserializeUntyped(response);
        }

        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        } else{
            return null;
        }
    }
}
