public class Recap_6_23_22 {
  public static list<integer> calculate() {
    List<integer> numbers = new List<integer>();

    List<integer> randomNums = new List<integer>();

    randomNums.add(2);
    randomNums.add(3);
    randomNums.add(5);
    randomNums.add(8);
    randomNums.add(12);
    randomNums.add(22);
    randomNums.add(31);

    for (integer randomNum : randomNums) {
      integer remainder = Math.mod(randomNum, 2);

      if (remainder == 0) {
        randomNums.add(randomNum);
      }
    }

    System.debug('even numbers of list = ' + randomNums);

    return randomNums;
  }

  public static set<String> myCarMap(Map<String, String> mapOfCars) {
    Set<String> setOfCars = mapOfCars.keySet();

    for (String setOfCar : setOfCars) {
      System.debug('The key of the map = ' + setOfCar);
    }

    List<String> listOfValues = mapOfCars.values();
    for (String listOfValue : listOfValues) {
      System.debug('listOfValue = ' + listOfValue);
    }

    return setOfCars;
  }

  public static set<string> displayCapitalOfCountries() {
    Map<String, String> randomCountriesAndCapitols = new Map<String, String>();

    randomCountriesAndCapitols.put('USA', 'Washington');
    randomCountriesAndCapitols.put('UK', 'London');
    randomCountriesAndCapitols.put('France', 'Paris');
    randomCountriesAndCapitols.put('Germany', 'Berlin');
    randomCountriesAndCapitols.put('Canada', 'Ottowa');
    randomCountriesAndCapitols.put('Italy', 'Rome');

    Set<String> setOfKeys = randomCountriesAndCapitols.keySet();

    for (String setOfKey : setOfKeys) {
      string tempStr = setOfKey.toUpperCase();

      setOfKeys.add(tempStr);
    }

    System.debug('Uppercased keys = ' + setOfKeys);

    List<String> listOfValues = randomCountriesAndCapitols.values();

    for (String listOfValue : listOfValues) {
      System.debug('listOfValues = ' + listOfValue);
    }
    return setOfKeys;
  }
}