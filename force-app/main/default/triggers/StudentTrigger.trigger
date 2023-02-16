trigger StudentTrigger on Student__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    StudentTriggerHandler.updateFieldsOnStudentObj(Trigger.new, Trigger.oldMap);
  }
}