public with sharing class insertUpdateBulkRecordsToDealership {
  public static void insertRecordsToDealership() {
    Dealership__c obj1 = new Dealership__c();

    obj1.Delearship_Name__c = 'City World Toyota';
    obj1.Dealership_City__c = 'Bronx,New York';
    obj1.Dealership_URL__c = 'https://www.cityworldtoyota.com/';
    obj1.Dealership_Opening_Hour__c = Time.newInstance(8, 0, 0, 0);
    obj1.Dealership_Closing_Hour__c = Time.newInstance(19, 30, 0, 0);
    obj1.Dealership_Type_of_Financial_Operations__c = 'Loan,Lease;Re-Finance';
    obj1.Dealership_Agent_Name__c = 'Diana';

    Dealership__c obj2 = new Dealership__c();

    obj2.Delearship_Name__c = 'Westchester Toyota';
    obj2.Dealership_City__c = 'Yonkers,New York';
    obj2.Dealership_URL__c = 'https://www.westchestertoyota.com/';
    obj2.Dealership_Opening_Hour__c = Time.newInstance(8, 0, 0, 0);
    obj2.Dealership_Closing_Hour__c = Time.newInstance(19, 30, 0, 0);
    obj2.Dealership_Type_of_Financial_Operations__c = 'Loan,Lease;Re-Finance';
    obj2.Dealership_Agent_Name__c = 'Natalie';

    List<Dealership__c> listDealership = new List<Dealership__c>{ obj1, obj2 };

    insert listDealership;
  }

  public static void updateRecordsToDealership() {
    List<Dealership__c> listDealership = [
      SELECT
        id,
        name,
        Delearship_Name__c,
        Will_The_Customer_Buy_Any_Vehicles__c,
        Dealership_Agent_Name__c
      FROM Dealership__c
      WHERE Will_The_Customer_Buy_Any_Vehicles__c = NULL
    ];

    for (Dealership__c eachDealership : listDealership) {
      eachDealership.Delearship_Name__c = 'Towne Toyota';
      eachDealership.Dealership_URL__c = 'Dealership_URL__c';
      eachDealership.Dealership_Agent_Name__c = 'Brittany';
      eachDealership.Dealership_Reviews__c = 'Excellent sales and service great price on car all credit excepted';
    }

    update listDealership;
  }

  public static void insertRelatedRecords() {
    List<Dealership__c> listDealerReturned = [
      SELECT id, name, Delearship_Name__c
      FROM Dealership__c
      WHERE Delearship_Name__c = 'Towne Toyota'
    ];

    List<Customer_of_Dealership__c> listDCustomer = new List<Customer_of_Dealership__c>();
    for (Dealership__c eachDealer : listDealerReturned) {
      Customer_of_Dealership__c obj1 = new Customer_of_Dealership__c();
      obj1.Customer_Name__c = 'Doris';
      obj1.Customer_Phone__c = '2102312313';
      obj1.VIN__c = 'WP0AD2A92HS162354';
      obj1.Dealership__c = eachDealer.id;

      Customer_of_Dealership__c obj2 = new Customer_of_Dealership__c();
      obj2.Customer_Name__c = 'Marilyn';
      obj2.Customer_Phone__c = '2102312387';
      obj2.VIN__c = 'WP0AD2A92HS162370';
      obj2.Dealership__c = eachDealer.id;

      listDCustomer.add(obj1);
      listDCustomer.add(obj2);
    }

    if (!listDCustomer.isEmpty()) {
      insert listDCustomer;
    }
  }
}