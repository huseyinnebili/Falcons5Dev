public class Demo_6_23_22 {
  public static list<integer> show(set<integer> setOfNumbers) {
    List<integer> listOfNums = new List<integer>();

    listOfNums.addAll(setOfNumbers);

    return listOfNums;
  }

  public static set<integer> showTwo(list<integer> listOfNumbers) {
    Set<integer> setOfNums = new Set<integer>();

    setOfNums.addAll(listOfNumbers);

    return setOfNums;
  }

  public static void setDisplay() {
    Set<integer> setNums = new Set<integer>();

    setNums.add(10);
    setNums.add(20);
    setNums.add(30);
    setNums.add(40);
    setNums.add(50);
    setNums.add(60);
    setNums.add(60);

    System.debug('setNums = ' + setNums);
    // for (integer setNum : setNums) {
    //   System.debug('setNum = ' + setNum);
    // }

    List<Integer> listNums = new List<Integer>();

    listNums.addAll(setNums);
    System.debug('listNums = ' + listNums);

    // for (integer listNum : listNums) {
    //   System.debug('listNum = ' + listNum);
    // }
  }

  public static set<String> printCountries(Set<String> setOfCountries) {
    Set<String> countries = new Set<String>();

    for (String setOfCountry : setOfCountries) {
      string tempStr = setOfCountry.toUpperCase();

      countries.add(tempStr);
    }

    return countries;
  }

  public static list<integer> powerOfNumbers(list<integer> listOfNumbers) {
    List<integer> numbers = new List<integer>();

    for (integer listOfNumber : listOfNumbers) {
      integer poweredNums = listOfNumber * listOfNumber;

      numbers.add(poweredNums);
    }

    return numbers;
  }
}