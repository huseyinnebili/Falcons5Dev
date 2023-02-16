public with sharing class PostCallOut {
  public static HttpResponse postAnimals() {
    //1.prepare request
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
    request.setMethod('POST');
    String body = '{"animal":"tiger"}';
    request.setBody(body);
    request.setHeader('Content-Type', 'application/json');

    //2.prepare http
    Http http = new Http();

    //3.send request over http and receive response
    HttpResponse response = http.send(request);

    //4.procees the response

    if (response.getStatusCode() == 201) {
    } else {
      System.debug('Some error occurred!..');
    }

    return response;
  }
}