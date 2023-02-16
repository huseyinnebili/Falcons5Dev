public with sharing class AccountBatchApexCopado implements Database.Batchable<SObject>, Database.stateful {
  public static Integer count = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator q = database.getQueryLocator(
      [
        SELECT id, Name, AnnualRevenue, Description, Phone
        FROM Account
        WHERE Phone = NULL
        LIMIT 200
      ]
    );

    return q;
  }

  public void execute(Database.BatchableContext bc, List<Account> scope) {
    List<Account> listAccUpdate = new List<Account>();

    for (Account eachAcc : scope) {
      eachAcc.Description = 'This description was created by Batch Apex!..';

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