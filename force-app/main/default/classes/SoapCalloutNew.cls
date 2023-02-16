public with sharing class SoapCalloutNew {
  public static Integer calculatorDiv(Integer intA, Integer intB) {
    TempuriOrgTwo.CalculatorSoap calculation = new TempuriOrgTwo.CalculatorSoap();
    Integer divResult = calculation.Divide(intA, intB);

    System.debug('divResult =>' + divResult);
    return divResult;
  }

  public static Integer calculatorAdd(Integer intA, Integer intB) {
    TempuriOrgTwo.CalculatorSoap calculation = new TempuriOrgTwo.CalculatorSoap();
    Integer addResult = calculation.Add(intA, intB);

    System.debug('addResult =>' + addResult);
    return addResult;
  }

  public static Integer calculatorMult(Integer intA, Integer intB) {
    TempuriOrgTwo.CalculatorSoap calculation = new TempuriOrgTwo.CalculatorSoap();
    Integer multResult = calculation.Multiply(intA, intB);

    System.debug('multResult =>' + multResult);
    return multResult;
  }

  public static Integer calculatorSub(Integer intA, Integer intB) {
    TempuriOrgTwo.CalculatorSoap calculation = new TempuriOrgTwo.CalculatorSoap();
    Integer subResult = calculation.Subtract(intA, intB);

    System.debug('subResult=>' + subResult);
    return subResult;
  }
}