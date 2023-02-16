trigger AccountTriggerCopadoTwo on Account(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    AccountTriggerHandlerCopadoTwo.updateAccountField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    AccountTriggerHandlerCopadoTwo.insertRecordToCase(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTriggerHandlerCopadoTwo.updateCaseFieldRespectToAccountField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
}