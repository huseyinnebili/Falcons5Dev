public with sharing class NewBankBatch implements Database.Batchable<sObject>, database.stateful {
  public integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [
        SELECT id, name, Bank_Name__c, Bank_State__c
        FROM New_Bank__c
        WHERE Bank_State__c = NULL
      ]
    );

    return ql;
  }

  public void execute(Database.BatchableContext bc, List<New_Bank__c> scope) {
    List<New_Bank__c> listBank = new List<New_Bank__c>();

    for (New_Bank__c eachBank : scope) {
      eachBank.Bank_State__c = 'NJ';

      listBank.add(eachBank);

      count++;
    }

    update listBank;
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('done with updating all the accounts!...');
    System.debug('# of records updated: ' + count);
  }
}