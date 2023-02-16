trigger scoreCardTrigger on Account(before delete) {
  if (Trigger.isBefore && Trigger.isDelete) {
    scoreCardTriggerHandler.delRelScore(Trigger.old, Trigger.oldMap);
  }
}