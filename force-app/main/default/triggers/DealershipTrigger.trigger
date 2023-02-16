trigger DealershipTrigger on Dealership__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    DealershipTriggerHandler.updateDealershipReviewsField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    DealershipTriggerHandler.insertRelatedRecord(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );

    DealershipTriggerHandler.updateDealerInfo(Trigger.newMap.keySet());
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    DealershipTriggerHandler.insertRelatedRecordDidtheCustomerBuyAVehicleField(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
    DealershipTriggerHandler.updateDealershipReviewsFieldWithFutureMethod(
      Trigger.new,
      Trigger.old,
      Trigger.oldMap,
      Trigger.newMap
    );
  }
}