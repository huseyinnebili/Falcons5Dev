public with sharing class PostCallOutReqres {
  public static HttpResponse postCredentials() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://reqres.in/api/users');
    request.setMethod('POST');

    Contact conn = [SELECT Name, Department FROM Contact LIMIT 1];

    contactRequest cr = new contactRequest();
    cr.name = conn.Name;
    cr.job = conn.Department;

    String jsonString = JSON.serialize(cr);

    request.setBody(jsonString);
    request.setHeader('Content-Type', 'application/json');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 201) {
      conn.Data_Send_On__c = Datetime.now();

      update conn;
    } else {
      System.debug('Some error occurred!..');
    }

    return response;
  }

  //wrapper class
  public class contactRequest {
    public String name;
    public String job;
  }
}