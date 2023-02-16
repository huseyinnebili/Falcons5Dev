@isTest
public with sharing class HotelTriggerHandlerTest {
  @isTest
  public static void testMethod1() {
    Hotel__c hot1 = new Hotel__c();
    hot1.Hotel_Name__c = 'Hilton Garden Inn Wayne';
    hot1.Star_Number__c = 4;
    hot1.Type_of_The_Hotel__c = '	All-suites';

    Hotel__c hot2 = new Hotel__c();
    hot2.Hotel_Name__c = 'Residence Inn by Marriott Wayne';
    hot2.Star_Number__c = 4;
    hot2.Type_of_The_Hotel__c = 'Inns';

    Hotel__c hot3 = new Hotel__c();
    hot3.Hotel_Name__c = 'Residence Inn by Marriott Wayne';
    hot3.Star_Number__c = 5;
    hot3.Type_of_The_Hotel__c = 'Resorts';

    List<Hotel__c> listHotel = new List<Hotel__c>{ hot1, hot2, hot3 };

    insert listHotel;

    for (Hotel__c eachHotel : listHotel) {
      eachHotel.Hotel_Name__c = 'Residence Inn';
      eachHotel.Did_the_Guest_Check_In__c = true;
    }

    update listHotel;

    list<Hotel__c> updatedHotel = [
      SELECT Did_the_Guest_Check_In__c, id, name
      FROM Hotel__c
    ];

    system.assertEquals(true, updatedHotel[0].Did_the_Guest_Check_In__c);
  }

  @isTest
  public static void testMethodFuture() {
    Hotel__c hot1 = new Hotel__c();
    hot1.Hotel_Name__c = 'Hilton Garden Inn Wayne';
    hot1.Star_Number__c = 4;
    hot1.Type_of_The_Hotel__c = '	All-suites';
    // hot1.Hotel_Reviews__c = 'Nice well maintained older hotel';

    Hotel__c hot2 = new Hotel__c();
    hot2.Hotel_Name__c = 'Residence Inn by Marriott Wayne';
    hot2.Star_Number__c = 4;
    hot2.Type_of_The_Hotel__c = 'Inns';
    hot2.Hotel_Reviews__c = 'Nice well maintained older hotel';

    Hotel__c hot3 = new Hotel__c();
    hot3.Hotel_Name__c = 'Residence Inn by Marriott Wayne';
    hot3.Star_Number__c = 5;
    hot3.Type_of_The_Hotel__c = 'Resorts';
    // hot3.Hotel_Reviews__c = 'Nice well maintained older hotel';

    List<Hotel__c> listHotel = new List<Hotel__c>{ hot1, hot2, hot3 };

    insert listHotel;

    for (Hotel__c eachHot : listHotel) {
      eachHot.Hotel_Reviews__c = 'Nice well maintained older hotel';
    }

    update listHotel;
    set<id> setHotelIDs = new Set<id>{ hot1.id, hot2.id, hot3.id };

    Test.startTest();

    HotelTriggerHandler.updateHotelReviews(setHotelIDs);
    Test.stopTest();

    List<Hotel__c> listHotelTwo = [
      SELECT id, name, Hotel_Reviews__c
      FROM Hotel__c
    ];

    system.assert(listHotelTwo[0].Hotel_Reviews__c.contains('maintained'));
  }
}