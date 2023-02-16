public class ChildToParentAndParentToChild {
  public static void fetchChildToParentSupportTicketObjectRecords() {
    List<Support_Ticket__c> listOfSupportTicketObjRecords = [
      SELECT
        Customer_Name__c,
        Product_Name__c,
        Device_ID__r.Product_Code__c,
        Device_ID__r.Product_Name__c
      FROM Support_Ticket__c
    ];

    for (
      Support_Ticket__c listOfSupportTicketObjRecord : listOfSupportTicketObjRecords
    ) {
      System.debug(
        'listOfSupportTicketObjRecord = ' + listOfSupportTicketObjRecord
      );

      String deviceNames = listOfSupportTicketObjRecord.Device_ID__r.Product_Name__c;

      System.debug('deviceNames = ' + deviceNames);
    }
  }

  public static void fetchParentToChildDeviceObjRecords() {
    List<Device__c> listOfDeviceObjRecords = [
      SELECT
        Product_Code__c,
        Product_Name__c,
        (
          SELECT Product_Name__c, Product_Repair_Time__c, Email__c
          FROM Support_Tickets__r
        )
      FROM Device__c
      LIMIT 1
    ];

    for (Device__c listOfDeviceObjRecord : listOfDeviceObjRecords) {
      System.debug('listOfDeviceObjRecord = ' + listOfDeviceObjRecord);

      for (
        Support_Ticket__c supportTicketRecord : listOfDeviceObjRecord.Support_Tickets__r
      ) {
        System.debug(
          'The related records of the Device Object = ' + supportTicketRecord
        );
      }
      System.debug(
        'size of related obj = ' +
        listOfDeviceObjRecord.Support_Tickets__r.size()
      );
    }
  }

  public static void insertRecordToDeviceObjectViaDML() {
    Device__c obj = new Device__c();

    obj.Product_Name__c = 'Wyze Cam v3 with Color Night Vision, Wired 1080p HD Indoor/Outdoor Video Camera';
    obj.Product_Code__c = 'B08R59YH7W';

    insert obj;
  }

  public static void updateAnExistingRecordOfDeviceObjectViaDML() {
    Device__c obj = [
      SELECT Product_Code__c, Product_Name__c, Name
      FROM Device__c
      WHERE Product_Code__c = 'B08R59YH7W'
      LIMIT 1
    ];

    obj.Product_Name__c = 'Cams ';

    update obj;
  }

  public static void insertRecordSupportTicketObjectViaDML() {
    Device__c obj = [
      SELECT Product_Code__c, Product_Name__c, Name, id
      FROM Device__c
      WHERE Product_Code__c = 'B08R59YH7W'
      LIMIT 1
    ];

    Support_Ticket__c obj_SupTic = new Support_Ticket__c();

    obj_SupTic.Product__c = 'WINEES 1080P Indoor Camera with Audio and Night Vision';
    obj_SupTic.Product_Repair_Time__c = Date.newInstance(2022, 7, 12);
    obj_SupTic.Customer_Name__c = 'Charlotte';
    obj_SupTic.Phone__c = '2015453212';
    obj_SupTic.Device_ID__c = obj.id;

    insert obj_SupTic;
  }

  public static void insertBulkRecordsToSupportTicketObject() {
    Device__c objDevice = [
      SELECT Product_Code__c, Product_Name__c, Name, id
      FROM Device__c
      WHERE Product_Code__c = 'B08R59YH7W'
      LIMIT 1
    ];

    List<Support_Ticket__c> listOfSTO = new List<Support_Ticket__c>();

    Support_Ticket__c obj_SupTic = new Support_Ticket__c();

    obj_SupTic.Product__c = 'Blink Outdoor – 2 camera kit with Blink Mini';
    obj_SupTic.Product_Repair_Time__c = Date.newInstance(2022, 7, 15);
    obj_SupTic.Customer_Name__c = 'Olivia';
    obj_SupTic.Phone__c = '2015453412';
    obj_SupTic.Device_ID__c = objDevice.id;

    Support_Ticket__c obj_SupTic2 = new Support_Ticket__c();

    obj_SupTic2.Product__c = 'Blink Outdoor – wireless, weather-resistant HD security camera with two-year battery life and motion detection';
    obj_SupTic2.Product_Repair_Time__c = Date.newInstance(2022, 7, 17);
    obj_SupTic2.Customer_Name__c = 'Amelia';
    obj_SupTic2.Phone__c = '2015453662';
    obj_SupTic2.Device_ID__c = objDevice.id;

    listOfSTO.add(obj_SupTic);
    listOfSTO.add(obj_SupTic2);

    insert listOfSTO;
  }

  public static void insertBulkRecordsToBranchObjectViaForLoop() {
    List<Branch__c> listOfBranchObj = new List<Branch__c>();

    Branch__c branchOBJ = new Branch__c();

    branchOBJ.Branch_Name__c = 'Math';
    branchOBJ.Branch_Registration_Due_Date__c = Date.newInstance(2022, 7, 12);
    branchOBJ.HOD_Phone__c = '2013212312';
    branchOBJ.HOD_Name__c = 'Harper';

    listOfBranchObj.add(branchOBJ);

    for (integer i = 0; i < 10; i++) {
      Branch__c branchOBJ2 = new Branch__c();

      branchOBJ2.Branch_Name__c = 'Math' + i;
      branchOBJ2.Branch_Registration_Due_Date__c =
        Date.newInstance(2022, 7, 12) + i;
      branchOBJ2.HOD_Phone__c = '2013212312' + i;
      branchOBJ2.HOD_Name__c = 'Harper' + i;

      listOfBranchObj.add(branchOBJ2);
    }

    System.debug('size of list = ' + listOfBranchObj.size());

    if (!listOfBranchObj.isEmpty()) {
      insert listOfBranchObj;
    }
  }

  public static void insertBulkRecordsToDeviceObjectViaForLoop() {
    List<Device__c> listOfDeviceRecords = new List<Device__c>();

    Device__c deviceObj = new Device__c();

    deviceObj.Product_Code__c = 'B08R59YH8W';
    deviceObj.Product_Name__c = 'Laptop';

    listOfDeviceRecords.add(deviceObj);

    for (integer i = 0; i < 6; i++) {
      Device__c deviceObj2 = new Device__c();

      deviceObj2.Product_Code__c = 'B08R59YH8W' + i;
      deviceObj2.Product_Name__c = 'Laptop' + i;

      listOfDeviceRecords.add(deviceObj2);
    }

    if (!listOfDeviceRecords.isEmpty()) {
      insert listOfDeviceRecords;
    }
  }

  public static void updateBulkRecordsOnDeviceObjects() {
    List<Device__c> listOfDeviceRecords = [
      SELECT Product_Code__c, Product_Name__c, Name, id
      FROM Device__c
      WHERE Product_Name__c = 'Laptop'
    ];

    List<Device__c> listOfWillUpdateRecords = new List<Device__c>();

    for (Device__c listOfDeviceRecord : listOfDeviceRecords) {
      listOfDeviceRecord.Product_Name__c = 'Window Air Conditioner';

      listOfWillUpdateRecords.add(listOfDeviceRecord);
    }

    if (!listOfWillUpdateRecords.isEmpty()) {
      update listOfWillUpdateRecords;
    }
  }
  public static void updateBulkRecordsOnBranchObjects() {
    List<Branch__c> listOfCurrentBranchObjectRecords = [
      SELECT HOD_Name__c, id, Branch_Name__c
      FROM Branch__c
      WHERE Branch_Name__c = 'Physician'
    ];

    List<Branch__c> listOfWillBeUpdatedBranchObjRecords = new List<Branch__c>();

    for (
      Branch__c listOfCurrentBranchObjectRecord : listOfCurrentBranchObjectRecords
    ) {
      listOfCurrentBranchObjectRecord.Branch_Name__c = 'Videos and Media';

      listOfWillBeUpdatedBranchObjRecords.add(listOfCurrentBranchObjectRecord);
    }

    if (!listOfCurrentBranchObjectRecords.isEmpty()) {
      update listOfWillBeUpdatedBranchObjRecords;
    }
  }

  public static void deleteBulkExistingRecordsOnBranchObject() {
    List<Branch__c> deletedRecords = [
      SELECT HOD_Name__c, id, Branch_Name__c
      FROM Branch__c
      WHERE Branch_Name__c LIKE 'Math%'
    ];

    delete deletedRecords;
  }

  public static void childToParentSOQL() {
    List<Support_Ticket__c> ticketList = [
      SELECT
        id,
        name,
        Customer_Name__c,
        Device_ID__r.name,
        Device_ID__r.Product_Name__c
      FROM Support_Ticket__c
      WHERE Device_ID__r.Product_Name__c = 'Dell Desktop'
    ];

    for (Support_Ticket__c eachTicket : ticketList) {
      System.debug('Customer_Name__c : ' + eachTicket.Customer_Name__c);
    }
  }
}