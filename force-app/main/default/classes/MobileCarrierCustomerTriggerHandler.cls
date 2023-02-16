public with sharing class MobileCarrierCustomerTriggerHandler {
  public static void updateFields(
    List<Mobile_Carier_Customer__c> mobileTriggerNew,
    List<Mobile_Carier_Customer__c> mobileTriggerOld,
    Map<Id, Mobile_Carier_Customer__c> mobileTriggerOldMap,
    Map<Id, Mobile_Carier_Customer__c> mobileTriggerNewMap
  ) {
    for (Mobile_Carier_Customer__c eachMobile : mobileTriggerNew) {
      boolean condition = false;

      //insert record
      if (
        mobileTriggerOld == null &&
        eachMobile.Provider_Companies__c == 'Mint'
      ) {
        if (
          eachMobile.Plan_Starting_Date__c != null &&
          eachMobile.Plan_Starting_Date__c.month() >= 7
        ) {
          condition = true;
        } else {
          eachMobile.Plan_Starting_Date__c.addError(
            'The value of the month of Plan Starting Date cannot be kept empty and less than July!..'
          );
        }
      }

      //update existing record
      if (mobileTriggerOldMap != null) {
        if (
          eachMobile.Provider_Companies__c == 'Mint' &&
          mobileTriggerNewMap.get(eachMobile.id).Provider_Companies__c !=
          mobileTriggerOldMap.get(eachMobile.id).Provider_Companies__c
        ) {
          if (
            eachMobile.Plan_Starting_Date__c != null &
            eachMobile.Plan_Starting_Date__c.month() >= 7
          ) {
            condition = true;
          } else {
            eachMobile.Plan_Starting_Date__c.addError(
              'The value of the month of Plan Starting Date cannot be kept empty and less than July!..'
            );
          }
        }
      }

      if (condition) {
        eachMobile.Service_Type__c = 'Mobile';
        eachMobile.Carrier_Plans_Provided__c = 'Eligible plan for a qualifying smartwatch, tablet, or hotspot;Fun games across all Apple devices;Unlimited talk & text';
        eachMobile.Do_you_switch_your_plan_or_carrier__c = true;
      }
    }
  }
}