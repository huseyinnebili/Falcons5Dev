public with sharing class ITServicesTriggerHandler {
  public static void updateFieldsValidationRule(
    List<IT_Service__c> serviceTriggerNew,
    List<IT_Service__c> serviceTriggerOld,
    Map<Id, IT_Service__c> serviceTriggerNewMap,
    Map<Id, IT_Service__c> serviceTriggerOldMap
  ) {
    for (IT_Service__c eachService : serviceTriggerNew) {
      boolean condition = false;

      if (
        serviceTriggerOldMap == null &&
        eachService.Ticket_Type__c == 'Printer Issues'
      ) {
        if (eachService.Customer_Name__c == null) {
          eachService.addError('Customer Name Field cannot be kept empty!...');
        } else {
          condition = true;
        }
      }

      if (serviceTriggerOldMap != null) {
        if (
          eachService.Ticket_Type__c == 'Printer Issues' &&
          serviceTriggerOldMap.get(eachService.id).Ticket_Type__c !=
          serviceTriggerNewMap.get(eachService.id).Ticket_Type__c
        ) {
          if (eachService.Customer_Name__c == null) {
            eachService.addError(
              'Customer Name Field cannot be kept empty!...'
            );
          } else {
            condition = true;
          }
        }
      }
      if (condition) {
        eachService.Ticket_Opened_Date__c = Date.today();
        eachService.What_is_your_issue_status__c = 'In Process';
      }
    }
  }
}