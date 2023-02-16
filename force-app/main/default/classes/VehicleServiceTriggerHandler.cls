public with sharing class VehicleServiceTriggerHandler {
  public static void updateField(
    List<Vehicle_Service__c> vehicleTriggerNew,
    List<Vehicle_Service__c> vehicleTriggerOld,
    Map<Id, Vehicle_Service__c> vehicleTriggerOldMap,
    Map<Id, Vehicle_Service__c> vehicleTriggerNewMap
  ) {
    boolean condition = false;
    for (Vehicle_Service__c eachVehicle : vehicleTriggerNew) {
      if (
        vehicleTriggerOldMap == null &&
        eachVehicle.Vehicle_Service_Type__c == 'Unscheduled'
      ) {
        if (eachVehicle.Service_Department__c != null) {
          condition = true;
        } else {
          eachVehicle.addError('Service_Department__c cannot be empty!..');
        }
      }

      if (vehicleTriggerOldMap != null) {
        if (
          eachVehicle.Service_Department__c !=
          vehicleTriggerNewMap.get(eachVehicle.id).Service_Department__c
        ) {
          if (eachVehicle.Vehicle_Service_Type__c != null) {
            condition = true;
          } else {
            eachVehicle.Vehicle_Service_Type__c.addError(
              'Vehicle_Service_Type__c cannot be empty!..'
            );
          }
        }
      }

      if (condition) {
        eachVehicle.Service_Number__c = 'AZ1223ZW';
      }
    }
  }

  public static void insertRelatedRecord(
    List<Vehicle_Service__c> vehicleTriggerNew,
    List<Vehicle_Service__c> vehicleTriggerOld,
    Map<Id, Vehicle_Service__c> vehicleTriggerOldMap,
    Map<Id, Vehicle_Service__c> vehicleTriggerNewMap
  ) {
    //boolean condition = false;

    List<Regular_Service_Customer__c> customerList = new List<Regular_Service_Customer__c>();
    // Regular_Service_Customer__c obj1 = new Regular_Service_Customer__c();
    for (Vehicle_Service__c eachVehicle : vehicleTriggerNew) {
      // if (obj1.Cutomer_Last_Service_Date__c != null) {
      //   condition = true;
      // } else {
      //   obj1.Cutomer_Last_Service_Date__c.addError(
      //     'Cutomer_Last_Service_Date__c cannot be empty!..'
      //   );
      // }

      // if (condition) {
      Regular_Service_Customer__c obj1 = new Regular_Service_Customer__c();

      obj1.Customer_Name__c = 'Samuel';
      obj1.Customer_Phone__c = '2129321232';
      obj1.Cutomer_Last_Service_Date__c = Date.today();
      obj1.Vehicle_Service__c = eachVehicle.id;
      obj1.Customer_Email__c = 'samuel@gmail.com';

      Regular_Service_Customer__c obj2 = new Regular_Service_Customer__c();

      obj2.Customer_Name__c = 'Ramirez';
      obj2.Customer_Phone__c = '2129321299';
      obj2.Cutomer_Last_Service_Date__c = Date.today();
      obj2.Vehicle_Service__c = eachVehicle.id;
      obj2.Customer_Email__c = 'ramirez@gmail.com';

      customerList.add(obj1);
      customerList.add(obj2);
    }

    if (!customerList.isEmpty()) {
      insert customerList;
    }
  }

  public static void updateRelatedRecordField(
    List<Vehicle_Service__c> vehicleTriggerNew,
    List<Vehicle_Service__c> vehicleTriggerOld,
    Map<Id, Vehicle_Service__c> vehicleTriggerOldMap,
    Map<Id, Vehicle_Service__c> vehicleTriggerNewMap
  ) {
    Set<Id> setVehicleIDs = new Set<Id>();
    for (Vehicle_Service__c eachVehicle : vehicleTriggerNew) {
      setVehicleIDs.add(eachVehicle.id);
    }

    list<Regular_Service_Customer__c> serviceList = [
      SELECT
        id,
        name,
        Customer_Name__c,
        Customer_Phone__c,
        Customer_Email__c,
        Cutomer_Last_Service_Date__c,
        Vehicle_Service__r.id
      FROM Regular_Service_Customer__c
      WHERE Vehicle_Service__r.id IN :setVehicleIDs
    ];
    List<Regular_Service_Customer__c> updatedList = new List<Regular_Service_Customer__c>();

    for (Vehicle_Service__c vehicle : vehicleTriggerNew) {
      for (Regular_Service_Customer__c service : serviceList) {
        if (service.Cutomer_Last_Service_Date__c != null) {
          service.Cutomer_Last_Service_Date__c = vehicle.Last_Service_Date__c;
          updatedList.add(service);
        } else {
          vehicle.addError(
            'You should complete related record filed before updating parent record1...'
          );
        }
      }
    }

    if (!updatedList.isEmpty()) {
      update updatedList;
    }
  }
}