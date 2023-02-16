public class RestCalloutMock implements HttpCalloutMock{

    public HttpResponse respond(HttpRequest request){
        
        HttpResponse response=new HttpResponse();
        
        response.setStatusCode(200);
        response.setStatus('OK');
        response.setBody('{"animals": ["majestic badger","fluffy bunny","scary bear","chicken"]}');
        
        return response;
    }
}