@isTest
public with sharing class DealershipBatchTest {
  @isTest
  public static void batchTest() {
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

    //DML up to 10000 records!...(insert/update)
    for (integer i = 0; i < 9900; i++) {
      Dealership__c obj = new Dealership__c();

      obj.Delearship_Name__c = 'Westchester Toyota' + i;
      obj.Dealership_City__c = 'Yonkers,New York';
      obj.Dealership_URL__c = 'https://www.westchestertoyota.com/';
      obj.Dealership_Agent_Name__c = 'Natalie';

      listDealership.add(obj);
    }

    insert listDealership;

    Test.startTest();

    DealershipBatch obj = new DealershipBatch();

    Id dealerIDs = database.executeBatch(obj, 10000000);

    Test.stopTest();

    list<Dealership__c> listDealershipReturned = [
      SELECT id, name, Compare_Price_Via_URL__c, Dealership_Agent_Name__c
      FROM Dealership__c
    ];
    for (Dealership__c eachDeal : listDealershipReturned) {
      //  system.assert(eachDeal.Dealership_Closing_Hour__c.contains('www'));
    }
  }
}