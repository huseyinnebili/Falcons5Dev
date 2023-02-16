public with sharing class Map_Recap {
  public void display() {
    system.debug('Hello');
  }

  public static void show() {
    List<String> cars = new List<String>();

    cars.add('Toyota');
    cars.add('Honda');

    for (String car : cars) {
      system.debug(car);
    }
  }
}