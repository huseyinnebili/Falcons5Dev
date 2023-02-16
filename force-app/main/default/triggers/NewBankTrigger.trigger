trigger NewBankTrigger on New_Bank__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    NewBankTriggerHandler.updateField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    NewBankTriggerHandler.insertRelatedRecord(Trigger.new, Trigger.newMap);
    NewBankTriggerHandler.updateRelatedRecordFieldViaFutureMethod(
      Trigger.newMap.keySet()
    );
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    NewBankTriggerHandler.updateRelatedRecordField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}