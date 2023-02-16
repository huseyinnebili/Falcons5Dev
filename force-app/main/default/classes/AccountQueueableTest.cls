@isTest
public with sharing class AccountQueueableTest {
  @TestSetup
  static void setup() {
    List<Account> listAcc = new List<Account>();

    for (integer i = 0; i < 100; i++) {
      Account acc = new Account();
      acc.name = 'Test Account' + i;

      listAcc.add(acc);
    }

    insert listAcc;
  }

  @isTest
  public static void queueableTest() {
    List<Account> listAccount = [
      SELECT id, name
      FROM account
      WHERE name LIKE 'Test Account%'
    ];

    AccountQueueable obj = new AccountQueueable(listAccount);

    Test.startTest();

    System.enqueueJob(obj);

    Test.stopTest();

    integer count = [SELECT COUNT() FROM account WHERE name LIKE '%SI'];

    system.assertEquals(100, count);
  }
}