@isTest
public with sharing class ExchangeRateApiTest {
  @isTest
  public static void Test() {
    Test.setMock(HttpCalloutMock.class, new ExchangeRateApiMock());

    Test.startTest();

    ExchangerApiViaFutureMethod.exchangerApi(100);

    Test.stopTest();
  }
}