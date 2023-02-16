public class Recap_6_28_22 {
  public static void fetchRecordsFromCustomerOfDealershipObject() {
    List<Customer_of_Dealership__c> listOfCDRecords = [
      SELECT
        Customer_Name__c,
        Customer_Phone__c,
        Dealership_Name__c,
        Dealership__r.Dealership_Deparments__c,
        Dealership__r.Dealership_Type_of_Financial_Operations__c
      FROM Customer_of_Dealership__c
    ];

    for (Customer_of_Dealership__c listOfCDRecord : listOfCDRecords) {
      System.debug(
        'The records from Customer of Delarship = ' + listOfCDRecord
      );

      String delarshipDepartments = listOfCDRecord.Dealership__r.Dealership_Deparments__c;
      System.debug('delarshipDepartments = ' + delarshipDepartments);
    }
  }

  public static void fetchRecordsFromDealershipsObject() {
    List<Dealership__c> lisOfDealershipRecords = [
      SELECT
        Delearship_Name__c,
        name,
        id,
        Dealership_City__c,
        (
          SELECT Customer_Name__c, Current_Inventory__c, VIN__c
          FROM Customer_of_Dealerships__r
        )
      FROM Dealership__c
    ];

    for (Dealership__c lisOfDealershipRecord : lisOfDealershipRecords) {
      System.debug('lisOfDealershipRecord = ' + lisOfDealershipRecord);

      for (
        Customer_of_Dealership__c listOfCustomerDealershipRecords : lisOfDealershipRecord.Customer_of_Dealerships__r
      ) {
        System.debug(
          'listOfCustomerDealershipRecords = ' + listOfCustomerDealershipRecords
        );
      }
    }
  }
  public static void insertRecordToDealershipObject() {
    Dealership__c dealershipObj = new Dealership__c();

    dealershipObj.Delearship_Name__c = 'Hudson Toyota';
    dealershipObj.Dealership_URL__c = 'https://www.hudsontoyota.com/?utm_source=google&utm_medium=organic&utm_campaign=gmbsales';

    insert dealershipObj;
  }
  public static void updateExistingRecordOnDealershipObject() {
    Dealership__c recordReturned = [
      SELECT
        Delearship_Name__c,
        name,
        id,
        Dealership_City__c,
        (
          SELECT Customer_Name__c, Current_Inventory__c, VIN__c
          FROM Customer_of_Dealerships__r
        )
      FROM Dealership__c
      LIMIT 1
    ];

    recordReturned.Dealership_Opening_Hour__c = Time.newInstance(8, 30, 0, 0);

    update recordReturned;
  }

  public static void insertBulkRecordsToDealershipObject() {
    List<Dealership__c> listOfRecordsInserted = new List<Dealership__c>();

    Dealership__c obj1 = new Dealership__c();
    obj1.Delearship_Name__c = 'Prestige Toyota of Ramsey';
    obj1.Dealership_URL__c = 'https://www.prestigetoyota.com/';
    obj1.Dealership_Opening_Hour__c = Time.newInstance(8, 15, 0, 0);
    obj1.Dealership_City__c = 'Ramsey';

    Dealership__c obj2 = new Dealership__c();
    obj2.Delearship_Name__c = 'Toyota of Manhattan';
    obj2.Dealership_URL__c = 'https://www.toyotaofmanhattan.com/';
    obj2.Dealership_Opening_Hour__c = Time.newInstance(8, 30, 0, 0);
    obj2.Dealership_City__c = 'New York City';

    listOfRecordsInserted.add(obj1);
    listOfRecordsInserted.add(obj2);

    insert listOfRecordsInserted;
  }

  public static void updateExistingBulkRecordsOnDealershipObject() {
    list<Dealership__c> listOfDelaershipRecords = [
      SELECT
        Delearship_Name__c,
        name,
        id,
        Dealership_City__c,
        Dealership_Closing_Hour__c
      FROM Dealership__c
      WHERE Dealership_Closing_Hour__c = NULL
    ];

    List<Dealership__c> listOfUpdatedRecords = new List<Dealership__c>();
    for (Dealership__c listOfDealershipRecord : listOfDelaershipRecords) {
      listOfDealershipRecord.Dealership_Closing_Hour__c = Time.newInstance(
        18,
        30,
        0,
        0
      );

      listOfUpdatedRecords.add(listOfDealershipRecord);

      update listOfUpdatedRecords;
    }
  }

  public static void insertRecordToCustomerOfDealershipObject() {
    Dealership__c dealershipReturnedRecord = [
      SELECT
        Delearship_Name__c,
        name,
        id,
        Dealership_City__c,
        Dealership_Closing_Hour__c
      FROM Dealership__c
      WHERE Delearship_Name__c = 'Toyota of Manhattan'
      LIMIT 1
    ];

    Customer_of_Dealership__c objCDR = new Customer_of_Dealership__c();

    objCDR.Customer_Name__c = 'Elijah';
    objCDR.Customer_Phone__c = '2912342134';
    objCDR.Dealership__c = dealershipReturnedRecord.id;
    objCDR.Inventory_for_the_Customer__c = 'Cars';
    objCDR.VIN__c = 'WA1LAAF70HD012779';

    insert objCDR;
  }

  public static void insertBulkRecordsToCustomerOfDealershipObject() {
    Dealership__c dealershipReturnedRecord = [
      SELECT
        Delearship_Name__c,
        name,
        id,
        Dealership_City__c,
        Dealership_Closing_Hour__c
      FROM Dealership__c
      WHERE Delearship_Name__c = 'Toyota of Manhattan'
      LIMIT 1
    ];

    List<Customer_of_Dealership__c> listOfRecordsInserted = new List<Customer_of_Dealership__c>();

    Customer_of_Dealership__c obj1 = new Customer_of_Dealership__c();

    obj1.Customer_Name__c = 'James';
    obj1.Customer_Phone__c = '2912349150';
    obj1.Dealership__c = dealershipReturnedRecord.id;
    obj1.Inventory_for_the_Customer__c = 'Cars';
    obj1.VIN__c = '1FM5K8GT6KGA44167';

    Customer_of_Dealership__c obj2 = new Customer_of_Dealership__c();

    obj2.Customer_Name__c = 'Evelyn';
    obj2.Customer_Phone__c = '2912342109';
    obj2.Dealership__c = dealershipReturnedRecord.id;
    obj2.Inventory_for_the_Customer__c = 'Crossovers';
    obj2.VIN__c = 'JTDS4MCE3NJ089298';

    listOfRecordsInserted.add(obj1);
    listOfRecordsInserted.add(obj2);

    insert listOfRecordsInserted;
  }
}