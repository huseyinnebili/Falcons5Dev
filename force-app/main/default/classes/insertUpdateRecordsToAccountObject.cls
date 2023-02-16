public with sharing class insertUpdateRecordsToAccountObject {
  public static void insertBulkRecordsToAccount() {
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

    if (!listAcc.isEmpty()) {
      insert listAcc;
    }
  }

  public static void updateFieldOnAccount() {
    List<Account> listAccReturned = [
      SELECT id, name, Active__c, Industry
      FROM Account
      WHERE Name = 'Alphabet'
    ];

    for (Account eachAcc : listAccReturned) {
      eachAcc.Name = 'Google';
      eachAcc.Active__c = 'Yes';
      eachAcc.Industry = 'Technology';
    }

    update listAccReturned;
  }

  public static void updateFieldOnAccountTwo() {
    Account accReturned = [
      SELECT
        id,
        name,
        Active__c,
        Industry,
        (SELECT Phone, Title FROM Contacts),
        VIP__c
      FROM Account
      WHERE name = 'Costco'
      LIMIT 1
    ];

    accReturned.Name = 'Cigna';
    accReturned.Active__c = 'Yes';
    accReturned.Industry = 'Food & Beverage';
    accReturned.VIP__c = true;

    update accReturned;
  }
}