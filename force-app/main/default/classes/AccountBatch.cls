public with sharing class AccountBatch implements Database.Batchable<SObject>, database.stateful {
  public integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [SELECT id, YearStarted, Active__c FROM account LIMIT 200]
    );
    return ql;
  }

  public void execute(Database.BatchableContext bc, list<account> scope) {
    List<account> listAccUpdate = new List<account>();

    for (Account eachAcc : scope) {
      eachAcc.YearStarted = '2010';

      listAccUpdate.add(eachAcc);

      count++;
    }
    if (!listAccUpdate.isEmpty()) {
      update listAccUpdate;
    }
  }
  public void finish(Database.BatchableContext bc) {
    System.debug('done with updating all the accounts!...');
    System.debug('# of records updated: ' + count);
  }
}