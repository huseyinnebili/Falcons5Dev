trigger MobileCarrierTrigger on Mobile_Carrier__c(
  before insert,
  after insert,
  before update,
  after update
) {
  //we will create or update the same(parent) records!...
  if (Trigger.isBefore) {
    MobileCarrierTriggerHandler.updateField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  //we will create or update related(child) records!...
  if (Trigger.isAfter && Trigger.isInsert) {
    MobileCarrierTriggerHandler.createRelatedRecordOnMobileCarrierRecord(
      Trigger.new
    );
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    MobileCarrierTriggerHandler.updateRelatedRecords(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
}