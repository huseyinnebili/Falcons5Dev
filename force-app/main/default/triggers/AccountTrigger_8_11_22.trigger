trigger AccountTrigger_8_11_22 on Account(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    AccountTrigerHandler_8_11_22.updateAccountFields(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    AccountTrigerHandler_8_11_22.insertRecordToRelatedObjectOnAccount(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );

    // AccountTrigerHandler_8_11_22.updateRelatedObjectRecordFieldViaFutureMethod(
    //   Trigger.newMap.keySet()
    // );
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTrigerHandler_8_11_22.updateRecordToRelatedObjectOnAccount(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}