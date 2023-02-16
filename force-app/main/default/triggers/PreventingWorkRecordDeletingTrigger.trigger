trigger PreventingWorkRecordDeletingTrigger on Account(before delete) {
  if (Trigger.isBefore && Trigger.isDelete) {
    //PreventingWorkRecordDeletingHandler.preventingWorkRecordDeleted( Trigger.old);
    
      scoreCardTriggerHandlerShort.preventDeletionAcc(Trigger.old);
  }
}