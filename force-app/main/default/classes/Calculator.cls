public with sharing class Calculator {
  public static void calculatorViaSwitch(double a, double b, String operation) {
    switch on operation {
      when 'addition' {
        double addition = a + b;

        System.debug('addition = ' + addition);
      }
      when 'substraction' {
        double substraction = a - b;

        System.debug('substraction = ' + substraction);
      }
      when 'multiplication' {
        double multiplication = a * b;

        System.debug('multiplication = ' + multiplication);
      }
      when 'division' {
        double division = a / b;

        System.debug('division = ' + division);
      }
    }
  }
}