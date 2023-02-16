public with sharing class ExchangeRateApiMock implements HttpCalloutMock {
  public static HttpResponse respond(HttpRequest request) {
    HttpResponse response = new HttpResponse();

    String body = '{"success": "true","timestamp": "1519296206","base": "USD","date": "2021-03-17","rates": {"GBP": "0.72007","JPY": "107.346001","EUR": "0.813399"}}';

    response.setBody(body);
    response.setStatusCode(200);
    response.setHeader('Content-Type', 'application/json');

    return response;
  }
}