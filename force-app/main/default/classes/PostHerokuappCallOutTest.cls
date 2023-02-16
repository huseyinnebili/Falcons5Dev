@isTest
public class PostHerokuappCallOutTest {
@isTest
    private static void postAuthenticate(){
        RestCalloutMock mock=new RestCalloutMock();
       Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse response=PostHerokuappCallOut.postAuthenticate();
        System.assertEquals(200, response.getStatusCode());
        System.assertEquals('OK',response.getStatus());
        
        String expected='{"username": "admin","password": "password123"}';
        
        System.assertEquals(expected, response.getBody());
        
           
    }
}