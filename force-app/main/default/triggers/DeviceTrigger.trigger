trigger DeviceTrigger on Device__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    DeviceTriggerHandler.updateRelatedRecordField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}