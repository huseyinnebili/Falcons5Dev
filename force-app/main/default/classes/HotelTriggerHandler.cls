public with sharing class HotelTriggerHandler {
  public static void updateField(
    List<Hotel__c> hotelTriggerNew,
    List<Hotel__c> hotelTriggerOld,
    Map<Id, Hotel__c> hotelTriggerOldMap,
    Map<Id, Hotel__c> hotelTriggerNewMap
  ) {
    for (Hotel__c eachHotel : hotelTriggerNew) {
      boolean condition = false;

      String DescriptionOfHotel1 = '*Amenities typically include gourmet dining, luxury spas, and full-service health clubs with lavish locker rooms.';
      String DescriptionOfHotel2 = '*Fresh flowers, original art, and luxurious furnishings often adorn the lobbies.';

      //insert record(trigger.before && trigger.insert)
      if (hotelTriggerOldMap == null && eachHotel.Star_Number__c >= 4) {
        if (eachHotel.Type_of_The_Hotel__c != null) {
          condition = true;
        } else {
          eachHotel.Type_of_The_Hotel__c.addError(
            'Type_of_The_Hotel__c field cannot be empty!...'
          );
        }
      }

      //update a record(trigger.before && trigger.update)

      if (hotelTriggerOldMap != null) {
        if (
          eachHotel.Hotel_Name__c !=
          hotelTriggerOldMap.get(eachHotel.id).Hotel_Name__c &&
          eachHotel.Star_Number__c >= 4
        ) {
          if (eachHotel.Type_of_The_Hotel__c != null) {
            condition = true;
          } else {
            eachHotel.Type_of_The_Hotel__c.addError(
              'Type_of_The_Hotel__c field cannot be empty!...'
            );
          }
        }
      }

      if (condition) {
        if (eachHotel.Star_Number__c == 4) {
          eachHotel.Description_of_the_Hotel__c = DescriptionOfHotel2;
        } else if (eachHotel.Star_Number__c == 5) {
          eachHotel.Description_of_the_Hotel__c = DescriptionOfHotel1;
        }
      }
    }
  }

  //insert related record(trigger.after && trigger.insert)
  public static void insertRelatedRecord(List<Hotel__c> guestTriggerNew) {
    List<Hotel_Guest__c> listGuests = new List<Hotel_Guest__c>();
    for (Hotel__c eachHotel : guestTriggerNew) {
      Hotel_Guest__c obj1 = new Hotel_Guest__c();

      obj1.Type_of_Rooms__c = 'Deluxe Room';
      obj1.Hotel_Types__c = 'Boutique Hotel';
      obj1.Guest_Name__c = 'Carol';
      obj1.Hotel_Daily_Fee__c = 189.99;
      obj1.Hotel__c = eachHotel.id;
      obj1.Guest_Preferences__c = 'Room Service;Breakfast;Launch;Dinner;Spa;Massage Theraphy';
      obj1.Guest_Check_In_Date_Time__c = Date.today();
      obj1.Guest_Hotel_Review__c = 'very clean, retaurants very good with character, staff were very friendly';

      Hotel_Guest__c obj2 = new Hotel_Guest__c();

      obj2.Type_of_Rooms__c = 'Standard Room';
      obj2.Hotel_Types__c = 'Resort';
      obj2.Guest_Name__c = 'Dorothy';
      obj2.Hotel_Daily_Fee__c = 179.99;
      obj2.Hotel__c = eachHotel.id;
      obj2.Guest_Preferences__c = 'Room Service;Breakfast;Launch;Dinner;Spa;Massage Theraphy';
      obj2.Guest_Check_In_Date_Time__c = Date.today();
      obj2.Guest_Hotel_Review__c = 'The Hotel was clean, retaurants very good with character, staff were very friendly';

      listGuests.add(obj1);
      listGuests.add(obj2);
    }

    if (!listGuests.isEmpty()) {
      insert listGuests;
    }
  }

  //updated related record field(trigger.after && trigger.update)
  public static void updateRelatedRecordField(
    List<Hotel__c> hotelTriggerNew,
    List<Hotel__c> hotelTriggerOld,
    Map<Id, Hotel__c> hotelTriggerOldMap,
    Map<Id, Hotel__c> hotelTriggerNewMap
  ) {
    Set<Id> setOfHotelIDs = new Set<Id>();

    for (Hotel__c eachHotel : hotelTriggerNew) {
      setOfHotelIDs.add(eachHotel.id);
    }

    List<Hotel_Guest__c> listGuests = [
      SELECT
        id,
        name,
        Did_You_Check_In__c,
        Guest_Check_In_Date_Time__c,
        Hotel__r.id
      FROM Hotel_Guest__c
      WHERE Hotel__r.id IN :setOfHotelIDs
    ];

    for (Hotel__c eachHt : hotelTriggerNew) {
      for (Hotel_Guest__c eachGuest : listGuests) {
        if (eachGuest.Guest_Check_In_Date_Time__c != null) {
          boolean guestCheckIn = hotelTriggerNewMap.get(eachGuest.Hotel__r.id)
            .Did_the_Guest_Check_In__c;

          eachGuest.Did_You_Check_In__c = guestCheckIn;
        } else {
          eachHt.addError('Guest_Check_In_Date_Time__c cannot be empty!...');
        }
      }
    }
    if (!listGuests.isEmpty()) {
      update listGuests;
    }
  }

  @future
  public static void updateHotelReviews(set<id> setHotelIDs) {
    List<Hotel__c> listHotel = [
      SELECT id, name, Hotel_Name__c, Hotel_Reviews__c
      FROM Hotel__c
      WHERE id IN :setHotelIDs
    ];

    System.debug('hotel reviews = ' + listHotel);
    for (Hotel__c eachHotel : listHotel) {
      eachHotel.Hotel_Reviews__c = 'Nice well maintained older hotel';
    }

    update listHotel;
  }
  public static void updateHotelReviewsField(
    List<Hotel__c> hotelTriggerNew,
    List<Hotel__c> hotelTriggerOld,
    Map<Id, Hotel__c> hotelTriggerOldMap,
    Map<Id, Hotel__c> hotelTriggerNewMap
  ) {
    Set<Id> setHotelIDs = new Set<Id>();

    for (Hotel__c eachHotel : hotelTriggerNew) {
      if (
        eachHotel.Hotel_Reviews__c != null &&
        hotelTriggerOldMap.get(eachHotel.id).Hotel_Reviews__c == null
      ) {
        setHotelIDs.add(eachHotel.id);
      }
    }

    if (!setHotelIDs.isEmpty()) {
      updateGuestHotelReviewField(setHotelIDs);
    }
  }

  @future
  public static void updateGuestHotelReviewField(set<id> setHotelIDs) {
    list<Hotel_Guest__c> listHotel = [
      SELECT id, name, Guest_Hotel_Review__c, Hotel__r.id
      FROM Hotel_Guest__c
      WHERE Hotel__r.id IN :setHotelIDs
    ];

    for (Hotel_Guest__c eachGuest : listHotel) {
      eachGuest.Guest_Hotel_Review__c = 'Excellent!..';
      eachGuest.Guest_Phone__c = '2017574312';
    }

    update listHotel;
  }
}