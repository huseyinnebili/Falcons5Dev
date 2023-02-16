public with sharing class insertUpdateAccountBulkyRecords {
  public static void insertRecordsToAccount() {
    Account acc1 = new Account();
    acc1.Name = 'CVS Health';
    acc1.Active__c = 'Yes';
    acc1.Industry = 'Healthcare';
    acc1.Ownership = 'Private';
    acc1.Type = 'Prospect';
    acc1.Website = 'www.cvs.com';

    Account acc2 = new Account();
    acc2.Name = 'Microsoft Corporation';
    acc2.Active__c = 'Yes';
    acc2.Industry = 'Technology';
    acc2.Ownership = 'Private';
    acc2.Type = 'Customer';
    acc2.Website = 'www.microsoft.com';

    List<Account> insertToAccount = new List<Account>{ acc1, acc2 };

    if (!insertToAccount.isEmpty()) {
      insert insertToAccount;
    }
  }

  public static void updateAccountField() {
    List<Account> listAcc = [
      SELECT id, name, Description
      FROM Account
      WHERE name != NULL
    ];

    for (Account eachAcc : listAcc) {
      eachAcc.Industry = 'Technology';
    }

    if (!listAcc.isEmpty()) {
      update listAcc;
    }
  }
}