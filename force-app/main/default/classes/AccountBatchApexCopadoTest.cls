@isTest
public with sharing class AccountBatchApexCopadoTest {
  @isTest
  public static void batchTest() {
    Account acc = new Account();
    acc.Name = 'Apple';
    acc.Description = 'This account was created in Batch Apex.';

    Account acc1 = new Account();
    acc1.Name = 'Target';
    acc1.Description = 'This account was created in Batch Apex.';

    List<Account> listAcc = new List<Account>{ acc, acc1 };

    for (Integer i = 0; i < 9998; i++) {
      Account ac = new Account();
      ac.Name = 'Microsoft' + i;
      ac.Description = 'This account was created in Batch Apex.';

      listAcc.add(ac);
    }

    insert listAcc;

    Test.startTest();
    AccountBatchApexCopado obj = new AccountBatchApexCopado();

    Id jobID = Database.executeBatch(obj, 200);

    Test.stopTest();
  }
}