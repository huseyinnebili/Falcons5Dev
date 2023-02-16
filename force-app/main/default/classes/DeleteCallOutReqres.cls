public with sharing class DeleteCallOutReqres {
  public static HttpResponse deleteUsers() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://reqres.in/api/users/2');
    request.setMethod('DELETE');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatusCode() != 204) {
      System.debug('Some error occurred!..');
    }

    return response;
  }
}