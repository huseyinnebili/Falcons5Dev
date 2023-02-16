public class Recap_All_Topics_6_22_22 {
  public void manipulateStrings() {
    String str = 'Today is Apex coding day!..';

    system.debug('the orginal string = ' + str);

    String upperCasedStr = str.toUpperCase();
    system.debug('upperCasedStr = ' + upperCasedStr);

    String lowerCasedStr = str.toLowerCase();
    System.debug('lowerCasedStr = ' + lowerCasedStr);

    system.debug(lowerCasedStr.equals(upperCasedStr));

    String strNew = 'Salesforce';

    integer lenghtOfStr = strNew.length();
    system.debug('lenghtOfStr = ' + lenghtOfStr);

    system.debug('the last character of the str= ' + strNew.endsWith('e'));

    system.debug('Does str contain Apex = ' + str.contains('Apex'));

    system.debug('Does str contain ApeX = ' + str.containsIgnoreCase('ApeX'));
  }

  public void manipulateDate() {
    Time newTime = Time.newInstance(12, 30, 35, 45);
    system.debug('newTime = ' + newTime);

    system.debug('The hour of the newTime = ' + newTime.hour());

    Time addedHours = newTime.addHours(10);
    System.debug('addedHours = ' + addedHours);

    Date newDate = Date.newInstance(1981, 7, 29);
    system.debug('newDate = ' + newDate);

    integer yearOfDate = newDate.year();
    system.debug('yearOfDate = ' + yearOfDate);

    Date addedDays = newDate.addDays(100);
    system.debug('addedDays = ' + addedDays);

    Datetime newDT = Datetime.newInstance(1981, 7, 29, 12, 23, 30);
    system.debug('newDT = ' + newDT);

    Date dateOfDT = newDT.date();
    system.debug('dateOfDT = ' + dateOfDT);

    Date addedYersToDateOfDT = dateOfDT.addYears(12);
    system.debug('addedYersToDateOfDT= ' + addedYersToDateOfDT);

    Date dateOne = Date.newInstance(1981, 7, 29);
    Date dateTwo = Date.newInstance(2022, 6, 22);
    integer betweenDate = dateOne.daysBetween(dateTwo);
    system.debug('betweenDate = ' + betweenDate);
  }

  public void calculate(integer a, integer b) {
    integer sum = a + b;
    integer sub = a - b;
    integer mul = a * b;
    integer div = a / b;
    integer mod = Math.mod(a, b);

    system.debug('sum = ' + sum);
    system.debug('sub = ' + sub);
    system.debug('mul = ' + mul);
    system.debug('div = ' + div);
    system.debug('mod = ' + mod);
  }

  public boolean findLeapYear(date dt) {
    integer yearOfDate = dt.year();
    boolean isLeapYear = date.isLeapYear(yearOfDate);

    system.debug('isLeapYear = ' + isLeapYear);

    return isLeapYear;
  }

  private String make = 'Toyota';
  public String model = 'Sienna';
  public integer mileage = 90000;

  public void myCar() {
    system.debug(
      'My car is ' +
      make +
      ' ,and model is ' +
      model +
      'It has ' +
      mileage +
      ' mileage!..'
    );
  }

  public integer logicalOperations(integer a, integer b, integer c) {
    // integer a=12;
    // integer b=13;
    // integer c=14;

    if (a > b && b > c) {
      system.debug('a is the greatest number!..');
    } else if (a < b && b < c) {
      system.debug('a is the smallest number!...');
    } else if (a == b && b == c) {
      system.debug('all numbers are equal!..');
    } else if (a > b || b < c) {
      system.debug('We cannot say for sure with the numbers!..');
    }

    return a;
  }

  public string displayDays(integer nums) {
    String day = ' ';
    switch on nums {
      when 1 {
        day = 'Monday';
      }
      when 2 {
        day = 'Tuesday';
      }
      when 3 {
        day = 'Wednesday';
      }
      when 4 {
        day = 'Thursday';
      }
      when 5 {
        day = 'Friday';
      }
      when else {
        day = 'Unknown day!..';
      }
    }

    return day;
  }

  public string display(String str) {
    integer count = 0;

    while (count < 10) {
      system.debug(str);

      count++;
    }

    return str;
  }

  public integer addition(integer num) {
    integer sum = 0;

    for (integer i = 0; i < num; i++) {
      sum = sum + i;
    }

    system.debug('sum = ' + sum);

    return sum;
  }

  public integer findEvenAndOddNumbers(integer n) {
    for (integer i = 0; i < n; i++) {
      integer remainder = Math.mod(i, 2);

      if (remainder == 0) {
        System.debug('The even numbers from list = ' + i);
      } else if (remainder != 0) {
        System.debug('The odd numbers from list = ' + i);
      }
    }

    return n;
  }

  public static integer calculateNum(integer a, integer b, integer c) {
    integer sum = a + b + c;

    System.debug('sum = ' + sum);

    return sum;
  }

  public static String city = '';
  public String state = '';
  public integer zipcode = 0;

  public void myAddress() {
    System.debug('My city : ' + city);
    System.debug('My state : ' + state);
    System.debug('My zipcode : ' + zipcode);
  }

  public Recap_All_Topics_6_22_22() {
    System.debug('I am a default constructor!..');
  }

  String name = '';
  integer age = 0;

  public Recap_All_Topics_6_22_22(String name, integer age) {
    this.name = name;
    this.age = age;

    displayInfo();
  }

  public void displayInfo() {
    System.debug(
      'My name is ' +
      name +
      ' ,and I am ' +
      age +
      ' age years old!...'
    );
  }

  public static List<String> myCarList() {
    List<String> listOfCars = new List<String>();

    listOfCars.add('Toyota');
    listOfCars.add('Honda');
    listOfCars.add('Volswagen');
    listOfCars.add('Nissan');
    listOfCars.add('Nissan');

    for (String listOfCar : listOfCars) {
      System.debug('My cars = ' + listOfCar);
    }

    return listOfCars;
  }

  public static integer addition(list<integer> listOfNumbers) {
    integer sum = 0;

    for (Integer listOfNumber : listOfNumbers) {
      sum = sum + listOfNumber;
    }
    return sum;
  }

  String carMake = '';
  String carModel = '';
  String carColor = '';
  integer carYear = 0;

  public Recap_All_Topics_6_22_22(
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

  public static void myFavouriteCars() {
    Recap_All_Topics_6_22_22 myFirstFavCar = new Recap_All_Topics_6_22_22(
      'Volswagen',
      'Golf',
      'White',
      2022
    );
    Recap_All_Topics_6_22_22 mySecondFavCar = new Recap_All_Topics_6_22_22(
      'Toyota',
      'Sienna',
      'Blue',
      2020
    );
    Recap_All_Topics_6_22_22 myThirdFavCar = new Recap_All_Topics_6_22_22(
      'Mercedes',
      'CLK',
      'Black',
      2021
    );
    Recap_All_Topics_6_22_22 myFourthFavCar = new Recap_All_Topics_6_22_22(
      'Audi',
      'A6',
      'Dark Red',
      2022
    );

    List<Recap_All_Topics_6_22_22> listOfFavCars = new List<Recap_All_Topics_6_22_22>();

    listOfFavCars.add(myFirstFavCar);
    listOfFavCars.add(mySecondFavCar);
    listOfFavCars.add(myThirdFavCar);
    listOfFavCars.add(myFourthFavCar);

    for (Recap_All_Topics_6_22_22 listOfFavCar : listOfFavCars) {
      System.debug('listOfFavCar = ' + listOfFavCar);
    }
  }
}