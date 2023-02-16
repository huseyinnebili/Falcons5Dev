@isTest
public with sharing class DealershipQueueableTest {
  @TestSetup
  static void setup() {
    List<Dealership__c> listDealer = new List<Dealership__c>();

    for (integer i = 0; i < 1000; i++) {
      Dealership__c obj = new Dealership__c();

      obj.Delearship_Name__c = 'Toyota Universe' + i;
      obj.Dealership_URL__c = 'www.toyotauniverse.com';

      listDealer.add(obj);
    }

    insert listDealer;
  }

  @isTest
  public static void test() {
    List<Dealership__c> listDealership = [
      SELECT id, name, Delearship_Name__c, Dealership_URL__c
      FROM Dealership__c
      WHERE Delearship_Name__c LIKE 'Toyota Universe%'
    ];

    DealershipQueueable obj = new DealershipQueueable(listDealership);

    Test.startTest();
    System.enqueueJob(obj);
    Test.stopTest();

    for (Dealership__c eachDealer : listDealership) {
      system.assert(eachDealer.Delearship_Name__c.contains('Toyota Universe'));
    }
  }
}