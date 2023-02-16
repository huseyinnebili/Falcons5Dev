@isTest
public with sharing class AccountTriggerHandlerNewTest {
  @isTest
  public static void handlerTest() {
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
      eachAcc.Name = 'ALPHABET';
      eachAcc.Ownership = 'Subsidiary';
      //eachAcc.Active__c = 'Yes';
    }

    update listAcc;

    List<Contact> listContact = new List<Contact>();

    for (integer i = 0; i < 20; i++) {
      Contact cont = new Contact();

      cont.lastName = 'test class';
      cont.Phone = '2134432121';

      if (i < 10) {
        cont.AccountId = acc1.id;
      } else if (i < 20) {
        cont.AccountId = acc2.id;
      }

      listContact.add(cont);
    }

    insert listContact;

    list<Account> listAccQuery = [
      SELECT id, name, Ownership, Industry, Active__c, VIP__c
      FROM Account
    ];
    system.assertEquals('Subsidiary', listAccQuery[0].Ownership);
  }

  @isTest
  public static void batchTest() {
    Account acc1 = new Account();
    acc1.Name = 'CVS Health';
    acc1.Active__c = 'Yes';
    acc1.Industry = 'Healthcare';
    acc1.Ownership = 'Private';
    acc1.Phone = '212321231';

    Account acc2 = new Account();
    acc2.Name = 'Microsoft Corporation';
    acc2.Active__c = 'Yes';
    acc2.Industry = 'Technology';
    acc2.Ownership = 'Private';
    acc2.Phone = '212321231';

    List<Account> listAcc = new List<Account>{ acc1, acc2 };

    for (integer i = 0; i < 200; i++) {
      Account acc = new Account();

      acc.name = 'AVC Company' + i;
      acc.Phone = '2123421232';

      listAcc.add(acc);
    }

    insert listAcc;

    Test.startTest();

    AccountBatch obj = new AccountBatch();
    Database.executeBatch(obj, 100);

    Test.stopTest();
  }
}