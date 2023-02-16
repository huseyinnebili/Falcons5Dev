@isTest
public with sharing class TestGovernorLimits {
  @isTest
  public static void testData() {
    // List<Account> accountList = new List<Account>();
    // Account accountObject;
    // for (Integer i = 0; i < 300; i++) {
    //   accountObject = new Account();
    //   accountObject.Name = 'Test ' + i;
    //   accountList.add(accountObject);
    // }
    // insert accountList;

    // // Too many DML's fix:
    // List<Contact> contactList = new List<Contact>();
    // Contact contactObject;
    // for (Account accountIterator : [SELECT Id, Name FROM Account]) {
    //   contactObject = new Contact();
    //   contactObject.AccountId = accountIterator.Id;
    //   contactObject.LastName = 'Surname ' + accountIterator.Name;
    //   contactList.add(contactObject);
    // }

    // insert contactList;

    // Test.startTest();
    //StartAndStopTestOnContatcObject.testData();
    //Test.stopTest();

    // for (integer i = 0; i <= 99; i++) {
    //   Integer countOfAccounts = [SELECT COUNT() FROM Account];
    // }

    List<Account> listAcc = new List<Account>();

    for (integer i = 0; i < 9999; i++) {
      Account acc = new Account();
      acc.name = 'Test' + i;

      listAcc.add(acc);
    }

    insert listAcc;
  }
}