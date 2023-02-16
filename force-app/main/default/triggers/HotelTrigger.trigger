trigger HotelTrigger on Hotel__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    HotelTriggerHandler.updateField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    HotelTriggerHandler.insertRelatedRecord(Trigger.new);
    // Set<Id> setHotelIDs = Trigger.newMap.keySet();
    //   System.debug('setHotelIDs = ' + setHotelIDs);
    //HotelTriggerHandler.updateHotelReviews(Trigger.newMap.keySet());
    // HotelTriggerHandler.updateGuestHotelReviewField(Trigger.newMap.keySet());
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    HotelTriggerHandler.updateRelatedRecordField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
    HotelTriggerHandler.updateHotelReviewsField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}