@isTest
public with sharing class HotelBatchTest {
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

    for (integer i = 0; i < 9000; i++) {
      Hotel__c obj = new Hotel__c();

      obj.Hotel_Name__c = 'Residence Inn by Marriott Wayne' + i;
      obj.Type_of_The_Hotel__c = 'Inns';
      obj.Star_Number__c = 4;

      listHotel.add(obj);
    }

    insert listHotel;

    Test.startTest();

    HotelBatch hb = new HotelBatch();

    id hotelIDS = Database.executeBatch(hb, 200);

    Test.stopTest();

    //     list<Hotel__c> listHt = [
    //       SELECT id, name, Type_of_The_Hotel__c, Hotel_Name__c
    //       FROM Hotel__c
    //     ];

    //     system.assert(listHt[0].Hotel_Name__c.contains('Residence'));
    //   }
  }
}