trigger BranchTrigger on Branch__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    BranchTriggerHandler.updateBranchRegistrationDueDate(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    BranchTriggerHandler.createStudentRecord(Trigger.new);
    BranchTriggerHandler.updateBranchReviewField(Trigger.newMap.keySet());
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    BranchTriggerHandler.updateRelatedRecordsField(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );

    BranchTriggerHandler.updateRegistrationConfirmationStatusAndDescriptionFields(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }

}