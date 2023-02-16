trigger VehicleServiceTriggerNew on Vehicle_Service__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    VehicleServiceTriggerHandler.updateField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    VehicleServiceTriggerHandler.insertRelatedRecord(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
  if (Trigger.isAfter && Trigger.isUpdate) {
    VehicleServiceTriggerHandler.updateRelatedRecordField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
}