trigger UpdateContactFieldTrigger on Account (before insert,
  before update,
  after insert,
  after update) {
if (Trigger.isAfter && Trigger.isUpdate) {
    UpdateContactFieldHandler.updateContactField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );

    UpdateContactFieldHandler.updateContactFieldRegardingToAccount(
      Trigger.newMap.keySet()
    );
  }
}