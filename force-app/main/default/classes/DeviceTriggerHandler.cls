public with sharing class DeviceTriggerHandler {
  public static void updateRelatedRecordField(
    List<Device__c> deviceTriggerNew,
    List<Device__c> deviceTriggerOld,
    Map<Id, Device__c> deviceTriggerNewMap,
    Map<Id, Device__c> deviceTriggerOldMap
  ) {
    Set<Id> setDeviceIDs = new Set<Id>();

    for (Device__c eachDevice : deviceTriggerNew) {
      setDeviceIDs.add(eachDevice.id);
    }

    List<Support_Ticket__c> supTicketList = [
      SELECT id, name, Assistant_Name__c, Device_ID__r.id
      FROM Support_Ticket__c
      WHERE Device_ID__r.id IN :setDeviceIDs
    ];

    List<Support_Ticket__c> ticketList = new List<Support_Ticket__c>();

    for (Device__c device : deviceTriggerNew) {
      for (Support_Ticket__c ticket : supTicketList) {
        if (ticket.Assistant_Name__c != null) {
          ticket.Assistant_Name__c = device.Assistant_Name__c;

          ticketList.add(ticket);
        } else {
          device.addError(
            'You should complete related record filed before updating parent record1...'
          );
        }
      }
    }

    update ticketList;
  }
}