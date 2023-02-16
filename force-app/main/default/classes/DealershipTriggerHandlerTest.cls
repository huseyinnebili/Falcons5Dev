@isTest
public with sharing class DealershipTriggerHandlerTest {
  @isTest
  public static void handlerTest() {
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

    for (Dealership__c eachDealership : listDealership) {
      eachDealership.Dealership_Closing_Hour__c = Time.newInstance(
        19,
        45,
        0,
        0
      );
      eachDealership.Delearship_Name__c = 'Toyota of Hakensack';
    }

    update listDealership;
  }
}