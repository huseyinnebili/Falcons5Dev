public with sharing class PostCallOutDummy {
  private static final String POSTCredentials = 'postCredentials';
  private static final String HTTP_METHOD = 'POST';
  public static HttpResponse postCredentials() {
    HttpRequest request = new HttpRequest();

    request.setEndpoint(CustomMetaDataHelper.getEndpoint(POSTCredentials));
    request.setMethod(HTTP_METHOD);

    Employee__c emp = [SELECT Name__c, Salary__c, Age__c FROM Employee__c];

    requestDummy rd = new requestDummy();

    emp.Name__c = rd.name;
    emp.Salary__c = rd.salary;
    emp.Age__c = rd.age;

    String jsonString = JSON.serialize(rd);
    request.setBody(jsonString);
    request.setHeader('Content-Type', 'application/json');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatus() == 'success') {
      emp.Is_Updated__c = true;

      update emp;
    } else {
      System.debug('Some error occured!..');
    }

    return response;
  }

  public class requestDummy {
    public String name;
    public String salary;
    public Integer age;
  }
}