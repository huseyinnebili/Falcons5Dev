public class RecapDMLAndSOQL {
  public static void fetchRecordsFromRegularServiceCustomerObject() {
    List<Regular_Service_Customer__c> listOfRecordsRSC = [
      SELECT
        Customer_Name__c,
        Customer_Next_Service_Date__c,
        Service_Department__c,
        Vehicle_Service__r.Vehicle_Service_Type__c,
        Vehicle_Service__r.Service_Department__c
      FROM Regular_Service_Customer__c
      WHERE Customer_Name__c != NULL
    ];

    for (Regular_Service_Customer__c listOfRecordRSC : listOfRecordsRSC) {
      System.debug('listOfRecordRSC = ' + listOfRecordRSC);

      String vehicleServiceType = listOfRecordRSC.Vehicle_Service__r.Vehicle_Service_Type__c;
      System.debug('vehicleServiceType = ' + vehicleServiceType);

      String serviceDepartment = listOfRecordRSC.Vehicle_Service__r.Service_Department__c;
      System.debug('serviceDepartment = ' + serviceDepartment);
    }
  }

  public static void fetchRecordsFromVehicleServiceObject() {
    List<Vehicle_Service__c> listOfVCRecords = [
      SELECT
        Vehicle_Service_Type__c,
        Service_Department__c,
        (
          SELECT
            Customer_Name__c,
            Customer_Next_Service_Date__c,
            Service_Department__c
          FROM Regular_Service_Customers__r
        )
      FROM Vehicle_Service__c
    ];

    for (Vehicle_Service__c listOfVCRecord : listOfVCRecords) {
      System.debug('listOfVCRecord = ' + listOfVCRecord);

      for (
        Regular_Service_Customer__c listOfRSCObjects : listOfVCRecord.Regular_Service_Customers__r
      ) {
        System.debug('listOfRSCObjects = ' + listOfRSCObjects);
      }
    }
  }

  public static void insertRecordToVehicleServiceObject() {
    Vehicle_Service__c vehicleObj = new Vehicle_Service__c();

    vehicleObj.Service_Department__c = 'Mechanic Department';
    vehicleObj.Vehicle_Service_Type__c = 'Unscheduled';

    insert vehicleObj;
  }

  public static void updateRecordToVehicleServiceObject() {
    Vehicle_Service__c vehicleObj = [
      SELECT Vehicle_Service_Type__c, Service_Department__c, Name
      FROM Vehicle_Service__c
      WHERE Vehicle_Service_Type__c = 'Unscheduled'
      LIMIT 1
    ];

    vehicleObj.Vehicle_Service_Type__c = 'Scheduled';

    update vehicleObj;
  }

  public static void insertBulkRecordToVehicleServiceObject() {
    List<Vehicle_Service__c> listOfVSORecords = new List<Vehicle_Service__c>();

    Vehicle_Service__c vehicleObj = new Vehicle_Service__c();

    vehicleObj.Service_Department__c = 'Mechanic Department';
    vehicleObj.Vehicle_Service_Type__c = 'Scheduled';
    vehicleObj.Service_Number__c = 'BWR21201334';

    Vehicle_Service__c vehicleObj2 = new Vehicle_Service__c();

    vehicleObj2.Service_Department__c = 'Mechanic Department';
    vehicleObj2.Vehicle_Service_Type__c = 'Either';
    vehicleObj2.Service_Number__c = 'AWR21201334';

    listOfVSORecords.add(vehicleObj);
    listOfVSORecords.add(vehicleObj2);

    insert listOfVSORecords;
  }

  public static void insertBulkRecordToVehicleServiceObjectViaForLoop() {
    List<Vehicle_Service__c> listOfVSORecords = new List<Vehicle_Service__c>();

    Vehicle_Service__c vehicleObj = new Vehicle_Service__c();

    vehicleObj.Service_Department__c = 'Electrical Repair';
    vehicleObj.Vehicle_Service_Type__c = 'Scheduled';
    vehicleObj.Service_Number__c = 'ZWR21201334';

    listOfVSORecords.add(vehicleObj);

    for (integer i = 0; i < 6; i++) {
      Vehicle_Service__c vehicleObj2 = new Vehicle_Service__c();

      vehicleObj2.Service_Department__c = 'Electrical Repair' + i;
      vehicleObj2.Vehicle_Service_Type__c = 'Scheduled' + i;
      vehicleObj2.Service_Number__c = 'ZWR21201334' + i;

      listOfVSORecords.add(vehicleObj2);
    }

    if (!listOfVSORecords.isEmpty()) {
      insert listOfVSORecords;
    }
  }

  public static void deleteExistingRecordsOnVehicleServiceObject() {
    list<Vehicle_Service__c> listOfVSORecords = [
      SELECT Vehicle_Service_Type__c, Service_Department__c, Name
      FROM Vehicle_Service__c
      WHERE Service_Department__c LIKE 'Electrical Repair%'
    ];

    delete listOfVSORecords;
  }

  public static void updateRecordToVehicleServiceObjectViaForEachLoop() {
    List<Vehicle_Service__c> listOfVORecords = [
      SELECT
        Vehicle_Service_Type__c,
        Service_Department__c,
        Name,
        Service_Number__c
      FROM Vehicle_Service__c
      WHERE Service_Number__c = NULL
    ];

    List<Vehicle_Service__c> listOfWillBeUpdatedRecords = new List<Vehicle_Service__c>();

    for (Vehicle_Service__c listOfVORecord : listOfVORecords) {
      listOfVORecord.Service_Number__c = 'KL13112394';

      listOfWillBeUpdatedRecords.add(listOfVORecord);
    }

    if (!listOfWillBeUpdatedRecords.isEmpty()) {
      update listOfWillBeUpdatedRecords;
    }
  }

  public static void insertRecordRegularServiceCustomerObject() {
    Vehicle_Service__c vehicleServiceRecord = [
      SELECT
        Vehicle_Service_Type__c,
        Service_Department__c,
        Name,
        Service_Number__c,
        id
      FROM Vehicle_Service__c
      WHERE Service_Department__c = 'Mechanic Department'
      LIMIT 1
    ];

    Regular_Service_Customer__c regularSCRecord = new Regular_Service_Customer__c();

    regularSCRecord.Customer_Name__c = 'Benjamin';
    regularSCRecord.Cutomer_Last_Service_Date__c = Date.newInstance(
      2022,
      1,
      12
    );
    regularSCRecord.Customer_Phone__c = '2019873212';
    regularSCRecord.Customer_Email__c = 'benjamin@gmail.com';
    regularSCRecord.Vehicle_Service__c = vehicleServiceRecord.id;

    insert regularSCRecord;
  }

  public static void updateRecordRegularServiceCustomerObject() {
    Vehicle_Service__c vehicleServiceRecord = [
      SELECT
        Vehicle_Service_Type__c,
        Service_Department__c,
        Name,
        Service_Number__c,
        id,
        (SELECT Customer_Phone__c FROM Regular_Service_Customers__r)
      FROM Vehicle_Service__c
      WHERE Service_Department__c = 'Mechanic Department'
      LIMIT 1
    ];

    Regular_Service_Customer__c obj = new Regular_Service_Customer__c();

    obj.Customer_Phone__c = '2019873299';

    obj.Vehicle_Service__c = vehicleServiceRecord.id;
    update obj;
  }
}