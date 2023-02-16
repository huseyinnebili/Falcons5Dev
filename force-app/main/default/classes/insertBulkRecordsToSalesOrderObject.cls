public with sharing class insertBulkRecordsToSalesOrderObject {
  public static void insertRecords() {
    List<Sales_Order__c> listOfSalesOrderNewRecords = new List<Sales_Order__c>();

    Sales_Order__c obj1 = new Sales_Order__c();

    obj1.Customer_Name__c = 'Lucas';
    obj1.Order_Source__c = 'Regular Store';
    obj1.Product_Unit_Price__c = 109;
    obj1.Sales_Order_Product_Name__c = 'Fire HD 8 Plus tablet, HD display, 32 GB, latest model (2020 release), our best 8" tablet for portable entertainment';

    Sales_Order__c obj2 = new Sales_Order__c();

    obj2.Customer_Name__c = 'Theodore';
    obj2.Order_Source__c = 'Online Store';
    obj2.Product_Unit_Price__c = 39;
    obj2.Sales_Order_Product_Name__c = 'Echo Dot (4th Gen) | Smart speaker with Alexa | Glacier White';

    listOfSalesOrderNewRecords.add(obj1);
    listOfSalesOrderNewRecords.add(obj2);

    insert listOfSalesOrderNewRecords;
  }
}