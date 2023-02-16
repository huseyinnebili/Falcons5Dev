public with sharing class usersCallout {
  public static void fetchAllUsers() {
    //request
    HttpRequest request = new HttpRequest();
    request.setEndPoint('https://gorest.co.in/public/v2/users');
    request.setMethod('GET');

    //Http Protocol
    Http httpInstance = new Http();

    //response
    HttpResponse response = httpInstance.send(request);
    System.debug(response.getBody());
    System.debug('Status = ' + response.getStatus());
    System.debug('Status Code = ' + response.getStatusCode());
  }
}