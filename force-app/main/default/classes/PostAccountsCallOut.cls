public with sharing class PostAccountsCallOut {
  //All the accounts created in our sytsem have to be sent to client's inhouse system.

  public static HttpResponse postAccounts() {
    //1.prepare the request
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://softinnovas.com/post/accounts');
    request.setMethod('POST');
    List<Account> accounts = [
      SELECT Name, Type, Industry, AnnualRevenue
      FROM Account
      WHERE Valid_Customer__c = FALSE
    ];

    String jsonString = JSON.serialize(accounts);
    request.setBody(jsonString);
    request.setHeader('Content-Type', 'application/json');

    //2.prepare http
    Http http = new Http();

    //3.send the request over the internet and receive the response
    HttpResponse response = http.send(request);
    //4.process the response
    if (response.getStatusCode() == 201) {
      for (Account acc : accounts) {
        acc.Valid_Customer__c = true;
      }

      update accounts;
    } else {
      System.debug('Something went wrong!...');
    }

    return response;
  }
}