public with sharing class PostHerokuappCallOut {
  private static final String POST_Authenticate = 'postAuthenticate';
  private static final String HTTP_METHOD = 'POST';

  public static HttpResponse postAuthenticate() {
    HttpRequest request = new HttpRequest();

    request.setEndpoint(CustomMetaDataHelper.getEndpoint(POST_Authenticate));
   // request.setEndpoint('callout:herokuappCom');
    request.setMethod(HTTP_METHOD);
    String body = '{"username": "admin","password": "password123"}';
     request.setBody(body);
    request.setHeader('Content-Type', 'application/json');

    Http http = new Http();
    HttpResponse response = http.send(request);
    if (response.getStatusCode() == 200) {
      System.debug(response.getBody());
    } else {
      System.debug('Some error occurred!..');
    }

    return response;
  }
}