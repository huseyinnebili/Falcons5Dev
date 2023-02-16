trigger MobileCarrierCustomerTrigger on Mobile_Carier_Customer__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    MobileCarrierCustomerTriggerHandler.updateFields(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
}