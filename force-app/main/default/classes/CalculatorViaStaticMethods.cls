public class CalculatorViaStaticMethods {
  public static void welcomeMessage() {
    System.debug('Welcome Guys!...');
  }

  public static void printNewMessage(String message) {
  }

  public static integer add(integer a, integer b) {
    integer sum = a + b;

    System.debug('sum of a and b => ' + sum + '!...');

    return sum;
  }

  public static integer add(integer a, integer b, integer c) {
    integer sum = a + b + c;

    System.debug('sum of a, b, and c => ' + sum + '!...');

    return sum;
  }
}