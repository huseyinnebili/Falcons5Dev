public class Cars {
  public Cars() {
    System.debug('Default constructor!...');
  }
  String carMake = '';
  String carModel = '';
  String carColor = '';
  integer carYear = 0;

  public Cars(
    String carMake,
    String carModel,
    String carColor,
    integer carYear
  ) {
    this.carMake = carMake;
    this.carModel = carModel;
    this.carColor = carColor;
    this.carYear = carYear;
  }

  public static void myFavoriteCars() {
    Cars myFirstFavCar = new Cars('Volswagen', 'Golf', 'White', 2022);
    Cars mySecondFavCar = new Cars('Toyota', 'Sienna', 'Blue', 2020);
    Cars myThirdFavCar = new Cars('Mercedes', 'CLK', 'Black', 2021);
    Cars myFourthFavCar = new Cars('Audi', 'A6', 'Dark Red', 2022);

    List<Cars> listOfFavCars = new List<Cars>();

    listOfFavCars.add(myFirstFavCar);
    listOfFavCars.add(mySecondFavCar);
    listOfFavCars.add(myThirdFavCar);
    listOfFavCars.add(myFourthFavCar);

    for (Cars listOfFavCar : listOfFavCars) {
      System.debug('listOfFavCar = ' + listOfFavCar);
    }
  }

  public void displaySnacks() {
    Set<String> setOfSnacks = new Set<String>();

    setOfSnacks.add('Walnut');
    setOfSnacks.add('Peanut');
    setOfSnacks.add('Hazelnut');
    setOfSnacks.add('Almond');
    setOfSnacks.add('Walnut');

    for (String setOfSnack : setOfSnacks) {
      System.debug('setOfSnack = ' + setOfSnack);
    }
  }

  public set<string> convertingFromListToSet(list<String> listOfCars) {
    Set<String> setOfCars = new Set<String>();

    setOfCars.addAll(listOfCars);

    return setOfCars;
  }

  public static list<integer> showNumbers(set<integer> setOfNumbers) {
    List<Integer> listOfNumbers = new List<Integer>();

    listOfNumbers.addAll(setOfNumbers);

    return listOfNumbers;
  }
}