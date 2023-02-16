trigger OpportunityTrigger on Opportunity(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    OpportunityTriggerHandler.updateFieldOnOppObj(Trigger.new, Trigger.oldMap);
  }
}