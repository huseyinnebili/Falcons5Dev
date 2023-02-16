@isTest
public with sharing class AccountTriggerTest {
  @isTest
  public static void testMethod1() {
    Account acc1 = new Account();
    acc1.name = 'abc';
    acc1.Industry = 'Energy';

    Account acc2 = new Account();
    acc2.name = 'efg';
    acc2.Industry = 'Banking';

    Account acc3 = new Account();
    acc3.name = 'lmn';
    acc3.Industry = 'Energy';

    List<Account> listAcc = new List<Account>{ acc1, acc2, acc3 };

    insert listAcc;

    for (Account eachAcc : listAcc) {
      eachAcc.Description = 'updated!..';
    }

    update listAcc;
  }
}