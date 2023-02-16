@isTest
public with sharing class ExchangerApiViaFutureMethodTest {
  @isTest
  public static void MethodTest() {
    Test.startTest();

    ExchangerApiViaFutureMethod.exchangerApi(100);

    Test.stopTest();
  }
}