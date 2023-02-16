trigger UpdateCaseFieldsViaFutureTrigger on Account(
  after insert,
  after update
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert || Trigger.isUpdate) {
      UpdateCaseFieldsViaFuture.updateCaseField(
        Trigger.new,
        Trigger.old,
        Trigger.oldMap
      );
      UpdateCaseFieldsViaFuture.updateCaseFieldsViaFuture(
        Trigger.newMap.keySet()
      );
    }
  }

}