@isTest
public with sharing class DmlHotelGuestObjectTest {
  @isTest
  public static void insertRecordTest() {
    Hotel__c hotel = new Hotel__c();
    hotel.Hotel_Name__c = 'Cambria Hotel West Orange';

    insert hotel;

    DmlHotelGuestObject.insertRecord();

    List<Hotel_Guest__c> hotelList = [
      SELECT Type_of_Rooms__c, Hotel_Types__c, Guest_Name__c, Hotel_Daily_Fee__c
      FROM Hotel_Guest__c
    ];

    system.assertEquals('Deluxe Room', hotelList[0].Type_of_Rooms__c);
    system.assertEquals(4, hotelList.size());
  }

  @isTest
  public static void updateRecordTest() {
    Hotel__c hotel = new Hotel__c();
    hotel.Hotel_Name__c = 'Cambria Hotel West Orange';
    insert hotel;
    DmlHotelGuestObject.updateRecord();

    List<Hotel_Guest__c> hotelList = [
      SELECT Type_of_Rooms__c, Hotel_Types__c, Guest_Name__c, Hotel_Daily_Fee__c
      FROM Hotel_Guest__c
    ];

    system.assertEquals('Ramirez', hotelList[0].Guest_Name__c);
    system.assertEquals(2, hotelList.size());
  }
}