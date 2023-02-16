trigger SportClubTrigger on Sport_Club__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    SportClubTriggerHandle.updateClubReviewFieldOnSportClub(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    SportClubTriggerHandle.insertRelatedRecords(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );

    SportClubTriggerHandle.updateRelatedRecordFieldViaFutureMethod(
      Trigger.newMap.keySet()
    );
    //  SportClubTriggerHandle.createAttendeeReviewForClubAttendee(Trigger.new);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    SportClubTriggerHandle.updateRelatedRecordField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

}