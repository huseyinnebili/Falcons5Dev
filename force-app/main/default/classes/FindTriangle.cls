public with sharing class FindTriangle {
  // Function to check if the triangle
  // is equilateral or isosceles or scalene
  public static void checkTriangle(Integer x, Integer y, Integer z) {
    // Check for equilateral triangle
    if (x == y && y == z) {
      System.debug('Equilateral Triangle');
    } else if (x == y || y == z || z == x)
      // Check for isosceles triangle
      System.debug('Isosceles Triangle');
    else
      // Otherwise scalene triangle
      System.debug('Scalene Triangle');
  }

  public static void checkTriangleViaSwitch(Integer x, Integer y, Integer z) {
    Integer condition;

    if (x == y && y == z) {
      condition = 1;
    } else if (x == y || y == z || z == x) {
      condition = 2;
    } else {
      condition = 3;
    }

    switch on condition {
      when 1 {
        system.debug('Equilateral Triangle');
      }
      when 2 {
        system.debug('Isosceles Triangle');
      }
      when 3 {
        system.debug('Neither isosceles, nor equilateral');
      }
    }
  }
}