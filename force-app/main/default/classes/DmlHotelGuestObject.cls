public with sharing class DmlHotelGuestObject {
  public static void insertRecord() {
    Hotel__c hotel = [
      SELECT id, name, Hotel_Name__c
      FROM Hotel__c
      WHERE Hotel_Name__c = 'Cambria Hotel West Orange'
      LIMIT 1
    ];

    List<Hotel_Guest__c> listGuest = new List<Hotel_Guest__c>();

    Hotel_Guest__c obj1 = new Hotel_Guest__c();

    obj1.Type_of_Rooms__c = 'Deluxe Room';
    obj1.Hotel_Types__c = 'Boutique Hotel';
    obj1.Guest_Name__c = 'Tomas';
    obj1.Hotel_Daily_Fee__c = 115.99;
    obj1.Hotel__c = hotel.id;

    Hotel_Guest__c obj2 = new Hotel_Guest__c();

    obj2.Type_of_Rooms__c = 'Standard Room';
    obj2.Hotel_Types__c = 'Motel';
    obj2.Guest_Name__c = 'Carlos';
    obj2.Hotel_Daily_Fee__c = 59.99;
    obj2.Hotel__c = hotel.id;

    listGuest.add(obj1);
    listGuest.add(obj2);

    if (!listGuest.isEmpty()) {
      insert listGuest;
    }
  }

  public static void updateRecord() {
    Hotel__c hotelTwo = [
      SELECT id, name, (SELECT Guest_Name__c FROM Hotel_Guests__r)
      FROM Hotel__c
      LIMIT 1
    ];

    List<Hotel_Guest__c> listOfReturnedGuestRecords = new List<Hotel_Guest__c>();

    for (Hotel_Guest__c guest : hotelTwo.Hotel_Guests__r) {
      guest.Guest_Name__c = 'Ramirez';
      guest.Type_of_Rooms__c = 'Deluxe Room';

      listOfReturnedGuestRecords.add(guest);
    }

    if (!listOfReturnedGuestRecords.isEmpty()) {
      update listOfReturnedGuestRecords;
    }
  }
}