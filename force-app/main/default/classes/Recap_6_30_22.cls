public class Recap_6_30_22 {
  public static void fetchRecordsChildToParent() {
    List<Mobile_Carier_Customer__c> listOfMCCRecords = [
      SELECT
        Customer_Name__c,
        Customer_Phone__c,
        Plan_Fee__c,
        Provider_Companies__c,
        Plan_Starting_Date__c,
        Mobile_Carrier__r.Service_Name__c,
        Mobile_Carrier__r.Country__c
      FROM Mobile_Carier_Customer__c
      WHERE Provider_Companies__c = NULL
    ];

    for (Mobile_Carier_Customer__c listOfMCCRecord : listOfMCCRecords) {
      System.debug('listOfMCCRecord = ' + listOfMCCRecord);

      String serviceName = listOfMCCRecord.Mobile_Carrier__r.Service_Name__c;
      System.debug('serviceName = ' + serviceName);
    }
  }

  public static void fetchRecordsParentToChild() {
    List<Mobile_Carrier__c> listOfMCRecords = [
      SELECT
        Service_Name__c,
        Carrier_Plans_Provided__c,
        Country__c,
        id,
        (
          SELECT Customer_Name__c, Service_Type__c, Provider_Companies__c
          FROM Mobile_Carrier_Customers__r
        )
      FROM Mobile_Carrier__c
      WHERE Carrier_Plans_Provided__c != NULL
    ];

    for (Mobile_Carrier__c listOfMCRecord : listOfMCRecords) {
      System.debug('listOfMCRecord = ' + listOfMCRecord);

      for (
        Mobile_Carier_Customer__c mobileCarrierCRecord : listOfMCRecord.Mobile_Carrier_Customers__r
      ) {
        System.debug('mobileCarrierCRecord = ' + mobileCarrierCRecord);
      }
    }
  }

  public static void insertBulkRecordToParentObject() {
    List<Mobile_Carrier__c> listOfInsertedRecords = new List<Mobile_Carrier__c>();

    Mobile_Carrier__c obj1 = new Mobile_Carrier__c();

    obj1.Service_Name__c = 'Talk Talk';
    obj1.Carrier_Plans_Provided__c = 'Free Apple Music';
    obj1.Country__c = 'Canada';
    obj1.Provider_Companies__c = 'Talk Talk';
    obj1.Service_Fee__c = 39.99;

    Mobile_Carrier__c obj2 = new Mobile_Carrier__c();

    obj2.Service_Name__c = 'Viasat';
    obj2.Carrier_Plans_Provided__c = 'TravelPass;Unlimited talk & text';
    obj2.Country__c = 'UK';
    obj2.Provider_Companies__c = 'Viasat';
    obj2.Service_Fee__c = 59.99;

    listOfInsertedRecords.add(obj1);
    listOfInsertedRecords.add(obj2);

    if (!listOfInsertedRecords.isEmpty()) {
      insert listOfInsertedRecords;
    }
  }

  public static void insertBulkRecordsToRelatedObject() {
    Mobile_Carrier__c mobileCarrierRecord = [
      SELECT
        Service_Name__c,
        Carrier_Plans_Provided__c,
        Country__c,
        id,
        (
          SELECT Customer_Name__c, Service_Type__c, Provider_Companies__c
          FROM Mobile_Carrier_Customers__r
        )
      FROM Mobile_Carrier__c
      WHERE Service_Name__c = 'Viasat'
    ];

    Mobile_Carier_Customer__c obj1 = new Mobile_Carier_Customer__c();

    obj1.Customer_Name__c = 'Alfonso';
    obj1.Customer_Phone__c = '2013232312';
    obj1.Service_Type__c = 'Mobile';
    obj1.Plan_Starting_Date__c = Date.newInstance(2022, 7, 1);
    obj1.Provider_Companies__c = 'Viasat';
    obj1.Service_Country__c = 'Other';
    obj1.Mobile_Carrier__c = mobileCarrierRecord.id;

    Mobile_Carier_Customer__c obj2 = new Mobile_Carier_Customer__c();

    obj2.Customer_Name__c = 'Rafeal';
    obj2.Customer_Phone__c = '2013232432';
    obj2.Service_Type__c = 'Mobile';
    obj2.Plan_Starting_Date__c = Date.newInstance(2022, 7, 15);
    obj2.Provider_Companies__c = 'Viasat';
    obj2.Service_Country__c = 'Other';
    obj2.Mobile_Carrier__c = mobileCarrierRecord.id;

    List<Mobile_Carier_Customer__c> listOfChildRecords = new List<Mobile_Carier_Customer__c>();

    listOfChildRecords.add(obj1);
    listOfChildRecords.add(obj2);

    if (!listOfChildRecords.isEmpty()) {
      insert listOfChildRecords;
    }
  }

  public static void updateBulkExistingRecordsOnPArentObject() {
    List<Mobile_Carrier__c> listOfReturnedRecords = [
      SELECT
        Service_Name__c,
        Carrier_Plans_Provided__c,
        Country__c,
        id,
        name,
        (
          SELECT Customer_Name__c, Service_Type__c, Provider_Companies__c
          FROM Mobile_Carrier_Customers__r
        )
      FROM Mobile_Carrier__c
      WHERE Country__c = NULL
    ];

    List<Mobile_Carrier__c> listOfUpdatedRecords = new List<Mobile_Carrier__c>();

    for (Mobile_Carrier__c listOfReturnedRecord : listOfReturnedRecords) {
      listOfReturnedRecord.Country__c = 'USA';

      listOfUpdatedRecords.add(listOfReturnedRecord);
    }

    if (!listOfUpdatedRecords.isEmpty()) {
      update listOfUpdatedRecords;
    }
  }
}