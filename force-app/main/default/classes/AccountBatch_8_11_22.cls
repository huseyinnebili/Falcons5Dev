public with sharing class AccountBatch_8_11_22 implements Database.Batchable<SObject>, Database.stateful {
  public static integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator q = database.getQueryLocator(
      [SELECT id, name, YearStarted FROM Account LIMIT 200]
    );

    return q;
  }

  public void execute(Database.BatchableContext bc, List<Account> scope) {
    List<Account> listAccUpdate = new List<Account>();
    for (Account eachAcc : scope) {
      eachAcc.YearStarted = '1988';

      listAccUpdate.add(eachAcc);

      count++;
    }

    update listAccUpdate;
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('done with updating all the accounts!...');
    System.debug('# of records updated: ' + count);
  }
}