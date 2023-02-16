@isTest
public with sharing class HotelTriggerTest {
  @isTest
  public static void testMethod1() {
    Hotel__c hot1 = new Hotel__c();
    hot1.Hotel_Name__c = 'Hilton';
    hot1.Star_Number__c = 4;
    hot1.Type_of_The_Hotel__c = '	All-suites';

    Hotel__c hot2 = new Hotel__c();
    hot2.Hotel_Name__c = 'Baltimore';
    hot2.Star_Number__c = 4;
    hot2.Type_of_The_Hotel__c = 'Inns';

    List<Hotel__c> listHotel = new List<Hotel__c>{ hot1, hot2 };

    insert listHotel;

    for (Hotel__c eachHotel : listHotel) {
      eachHotel.Type_of_The_Hotel__c = 'Resorts';
    }

    update listHotel;
  }
}