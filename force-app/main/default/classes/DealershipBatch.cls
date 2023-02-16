public with sharing class DealershipBatch implements Database.Batchable<sObject>, database.stateful {
  public integer count = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [
        SELECT id, name, Compare_Price_Via_URL__c, Dealership_Agent_Name__c
        FROM Dealership__c
        LIMIT 200
      ]
    );

    return ql;
  }

  public void execute(Database.BatchableContext bc, list<Dealership__c> scope) {
    list<Dealership__c> listUpdateDealer = new List<Dealership__c>();

    for (Dealership__c eachDealer : scope) {
      eachDealer.Compare_Price_Via_URL__c = 'https://www.carfax.com';

      listUpdateDealer.add(eachDealer);

      count++;
    }

    update listUpdateDealer;
  }

  public void finish(Database.BatchableContext bc) {
    if (!Test.isRunningTest()) {
      System.debug('done with updating all the accounts!...');
      System.debug('# of records updated: ' + count);
    }
  }
}