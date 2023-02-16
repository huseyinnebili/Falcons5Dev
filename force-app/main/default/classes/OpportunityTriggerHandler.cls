public with sharing class OpportunityTriggerHandler {
  public static void updateFieldOnOppObj(
    List<Opportunity> oppTriggerNew,
    Map<Id, Opportunity> oppTriggerOldMap
  ) {
    //we fetch list custom setting key and values
    Map<String, OpportunityCustomSettings__c> oppMap = OpportunityCustomSettings__c.getAll();

    boolean condition = false;
    for (Opportunity eachOpp : oppTriggerNew) {
      if (oppTriggerOldMap == null) {
        condition = true;
      } else if (
        eachOpp.StageName != oppTriggerOldMap.get(eachOpp.id).StageName
      ) {
        condition = true;
      }

      if (condition) {
        OpportunityCustomSettings__c ocs = oppMap.get(eachOpp.StageName);

        eachOpp.Points__c = ocs.Points__c;
      }
    }
  }
}