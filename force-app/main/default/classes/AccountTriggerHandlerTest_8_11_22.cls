@isTest
public with sharing class AccountTriggerHandlerTest_8_11_22 {
  @isTest
  public static void handlerTest() {
    Account acc1 = new Account();
    acc1.name = 'Design and Tech Solutions';
    acc1.CustomerPriority__c = 'High';
    acc1.Industry = 'Technology';
    acc1.UpsellOpportunity__c = 'Maybe';
    acc1.BillingStreet = '1680 Route 23 North';
    acc1.BillingCity = 'Wayne';
    acc1.BillingState = 'NJ';
    acc1.BillingPostalCode = '07470';

    Account acc2 = new Account();
    acc2.name = 'OnCom Technologies';
    acc2.CustomerPriority__c = 'High';
    acc2.Industry = 'Technology';
    acc2.UpsellOpportunity__c = 'Maybe';
    acc2.BillingStreet = '155 U.S. 46 West';
    acc2.BillingCity = 'Wayne';
    acc2.BillingState = 'NJ';
    acc2.BillingPostalCode = '07470';

    List<Account> listAcc = new List<Account>{ acc1, acc2 };

    insert listAcc;

    List<Account> listAccReturned = [
      SELECT id, name, CustomerPriority__c, BillingState
      FROM Account
    ];

    System.assertEquals('OnCom Technologies', listAccReturned[1].name);

    for (Account eachAcc : listAccReturned) {
      eachAcc.name = 'Sky Technology Partners';
    }

    update listAccReturned;
  }

  @isTest
  public static void batchTest() {
    Account acc1 = new Account();
    acc1.name = 'Design and Tech Solutions';
    acc1.CustomerPriority__c = 'High';
    acc1.Industry = 'Technology';
    acc1.UpsellOpportunity__c = 'Maybe';
    acc1.BillingStreet = '1680 Route 23 North';
    acc1.BillingCity = 'Wayne';
    acc1.BillingState = 'NJ';
    acc1.BillingPostalCode = '07470';

    Account acc2 = new Account();
    acc2.name = 'OnCom Technologies';
    acc2.CustomerPriority__c = 'High';
    acc2.Industry = 'Technology';
    acc2.UpsellOpportunity__c = 'Maybe';
    acc2.BillingStreet = '155 U.S. 46 West';
    acc2.BillingCity = 'Wayne';
    acc2.BillingState = 'NJ';
    acc2.BillingPostalCode = '07470';

    List<Account> listAcc = new List<Account>{ acc1, acc2 };

    for (integer i = 0; i < 9000; i++) {
      Account acc = new Account();

      acc.name = 'ABC Technology' + i;
      acc.Industry = 'Technology';

      listAcc.add(acc);
    }

    insert listAcc;

    Test.startTest();

    AccountBatch_8_11_22 obj = new AccountBatch_8_11_22();

    Database.executeBatch(obj, 200);

    Test.stopTest();
  }
}