public with sharing class ExchangerApiViaFutureMethod {
  @future(callout=true)
  public static void exchangerApi(Decimal USD) {
    Decimal yen = 0.0;

    HttpRequest request = new HttpRequest();

    request.setEndpoint(
      'https://api.apilayer.com/exchangerates_data/latest?apikey=us5KtTxj32UEwADPSi3Ze0KFHCxCIBkl'
    );
    request.setMethod('GET');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();

      Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        jsonString
      );

      System.debug(result);

      Map<String, Object> rates = (Map<String, Object>) result.get('rates');

      Decimal yenRate = (Decimal) rates.get('JPY');

      yen = USD * yenRate;

      System.debug('yen = ' + yen);
    }
  }
}