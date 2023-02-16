trigger scoreCardHandlerShortTrigger on Account (before delete) {

    if (Trigger.isBefore && Trigger.isDelete) {
    
      scoreCardTriggerHandlerShort.preventDeletionAcc(Trigger.old);
  }
}