trigger ITServiceTrigger on IT_Service__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    ITServicesTriggerHandler.updateFieldsValidationRule(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
}