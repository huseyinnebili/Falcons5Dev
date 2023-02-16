@isTest
public class RestCalloutTest {

    @isTest
    private static void getAnimalsWithAuthorization(){
        RestCalloutMock mock=new RestCalloutMock();
       Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse response=RestCallout.getAnimalsWithAuthorization();
        System.assertEquals(200, response.getStatusCode());
        System.assertEquals('OK',response.getStatus());
        
        String expected='{"animals": ["majestic badger","fluffy bunny","scary bear","chicken"]}';
        
        System.assertEquals(expected, response.getBody());
        
           
    }
}