trigger AccountTrigger_8_23_22 on Account(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    AccountTriggerHandler_8_23_22.updateAccountField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    AccountTriggerHandler_8_23_22.insertRelatedObjectRecords(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTriggerHandler_8_23_22.updateRelatedObjectFieldRespectToAccounts(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

}