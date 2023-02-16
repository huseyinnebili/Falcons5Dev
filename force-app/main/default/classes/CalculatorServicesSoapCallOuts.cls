public with sharing class CalculatorServicesSoapCallOuts {
  public static Double division(Double num1, Double num2) {
    CalculatorServices.CalculatorImplPort getrResults = new CalculatorServices.CalculatorImplPort();
    Double results = getrResults.doDivide(num1, num2);

    System.debug(results);
    return results;
  }

  public static Double substraction(Double num1, Double num2) {
    CalculatorServices.CalculatorImplPort getResults = new CalculatorServices.CalculatorImplPort();
    Double results = getResults.doSubtract(num1, num2);

    System.debug(results);
    return results;
  }
}