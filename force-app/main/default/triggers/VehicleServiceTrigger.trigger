trigger VehicleServiceTrigger on Vehicle_Service__c(
  before insert,
  after insert,
  before update,
  after update
) {
  List<Vehicle_Service__c> listOfReturnedNewRecords = Trigger.new;
  List<Vehicle_Service__c> listOfOldReturnedRecords = Trigger.old;

  if (Trigger.isBefore && Trigger.isInsert) {
    for (
      Vehicle_Service__c listOfReturnedNewRecord : listOfReturnedNewRecords
    ) {
      String serviceDepartment = listOfReturnedNewRecord.Service_Department__c;
      System.debug('serviceDepartment = ' + serviceDepartment);
    }
    System.debug('size of trigger = ' + listOfReturnedNewRecords.size());
  }
  if (Trigger.isAfter && Trigger.isInsert) {
    for (
      Vehicle_Service__c listOfReturnedNewRecord : listOfReturnedNewRecords
    ) {
      String serviceType = listOfReturnedNewRecord.Vehicle_Service_Type__c;
      System.debug('serviceType = ' + serviceType);
    }
  }

  if (Trigger.isBefore && Trigger.isUpdate) {
    //new service numbers
    for (
      Vehicle_Service__c listOfReturnedNewRecord : listOfReturnedNewRecords
    ) {
      String newServiceNumbers = listOfReturnedNewRecord.Service_Number__c;
      System.debug(
        'before update trigger called new Service Numbers= ' + newServiceNumbers
      );
    }

    //Old service numbers
    for (
      Vehicle_Service__c listOfOldReturnedRecord : listOfOldReturnedRecords
    ) {
      string oldServiceNumbers = listOfOldReturnedRecord.Service_Number__c;

      System.debug(
        'before update trigger called old Service Numbers= ' + oldServiceNumbers
      );
    }

    //print ID via Set

    Set<Id> setOfIDs = new Set<Id>();
    for (
      Vehicle_Service__c listOfReturnedNewRecord : listOfReturnedNewRecords
    ) {
      setOfIDs.add(listOfReturnedNewRecord.id);
    }

    System.debug('set of IDs = ' + setOfIDs);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    for (
      Vehicle_Service__c listOfReturnedNewRecord : listOfReturnedNewRecords
    ) {
      String serviceDepartment = listOfReturnedNewRecord.Service_Department__c;
      System.debug(
        'serviceDepartment when after update trigger called = ' +
        serviceDepartment
      );
    }
  }

}