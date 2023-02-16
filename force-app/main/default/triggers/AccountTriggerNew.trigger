trigger AccountTriggerNew on Account(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    AccountTriggerHandlerNew.updateField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    AccountTriggerHandlerNew.insertRecordToContact(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );

    AccountTriggerHandlerNew.updateDescription(Trigger.newMap.keySet());
  }
  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTriggerHandlerNew.updateRelatedObjectField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );

    AccountTriggerHandlerNew.updateDescriptionOnContact(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}