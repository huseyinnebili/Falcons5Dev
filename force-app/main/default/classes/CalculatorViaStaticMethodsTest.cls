@isTest
public with sharing class CalculatorViaStaticMethodsTest {
  @isTest
  public static void testMessage() {
    CalculatorViaStaticMethods.welcomeMessage();
    CalculatorViaStaticMethods.printNewMessage(
      'This is from a test method!...'
    );
  }

  @isTest
  public static void addTest1() {
    integer a = 12;
    integer b = 13;
    integer calcAdd = CalculatorViaStaticMethods.add(a, b);

    system.assertEquals(25, calcAdd);
  }

  @isTest
  public static void addTest2() {
    integer a = 12;
    integer b = 13;
    integer c = 25;

    integer sum = CalculatorViaStaticMethods.add(a, b, c);

    system.assertEquals(50, sum);
  }
}