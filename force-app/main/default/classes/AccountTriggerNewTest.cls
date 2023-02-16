@isTest
public with sharing class AccountTriggerNewTest {
  @isTest
  public static void triggerTest() {
    Account acc1 = new Account();
    acc1.Name = 'CVS Health';
    acc1.Active__c = 'Yes';
    acc1.Industry = 'Healthcare';
    acc1.Ownership = 'Private';

    Account acc2 = new Account();
    acc2.Name = 'Microsoft Corporation';
    acc2.Active__c = 'Yes';
    acc2.Industry = 'Technology';
    acc2.Ownership = 'Private';

    List<Account> listAcc = new List<Account>{ acc1, acc2 };

    insert listAcc;

    for (Account eachAcc : listAcc) {
      eachAcc.Ownership = 'Subsidiary';
    }

    update listAcc;
  }
}