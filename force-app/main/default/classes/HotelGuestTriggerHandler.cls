public with sharing class HotelGuestTriggerHandler {
  public static void updateField(
    List<Hotel_Guest__c> guestTriggerNew,
    List<Hotel_Guest__c> guestTriggerOld,
    Map<Id, Hotel_Guest__c> guestTriggerNewMap,
    Map<Id, Hotel_Guest__c> guestTriggerOldMap
  ) {
    for (Hotel_Guest__c eachGuest : guestTriggerNew) {
      boolean condition = false;
      //insert record
      if (
        guestTriggerOldMap == null &&
        eachGuest.Type_of_Rooms__c == 'Deluxe Room'
      ) {
        //validation rule
        if (eachGuest.Hotel_Types__c != null) {
          condition = true;
        } else {
          eachGuest.Hotel_Types__c.addError(
            'Hotel_Types__c cannot be kept empty!...'
          );
        }
      }

      //update record

      if (guestTriggerOldMap != null) {
        if (
          eachGuest.Type_of_Rooms__c == 'Deluxe Room' &&
          guestTriggerNewMap.get(eachGuest.id).Guest_Name__c !=
          guestTriggerOldMap.get(eachGuest.id).Guest_Name__c
        ) {
          if (eachGuest.Hotel_Types__c != null) {
            condition = true;
          } else {
            eachGuest.Hotel_Types__c.addError(
              'Hotel_Types__c cannot be kept empty!...'
            );
          }
        }
      }

      if (condition) {
        eachGuest.Guest_Preferences__c = 'Room Service;Breakfast;Launch;Dinner;Spa;Massage Theraphy';
      }
    }
  }
}