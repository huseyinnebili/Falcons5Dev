public with sharing class RandomUserCallout {
  public static HttpResponse getUsers() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://randomuser.me/api/');
    request.setMethod('GET');

    Http http = new Http();

    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();
      system.debug('jsonString = ' + jsonString);
    } else {
      system.debug('Some error has occurred!...');
    }

    return response;
  }
}