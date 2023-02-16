trigger HotelGuestTrigger on Hotel_Guest__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    HotelGuestTriggerHandler.updateField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}