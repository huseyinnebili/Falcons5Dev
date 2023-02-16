public with sharing class upsertAccountObject {
  public static void insertAccountRecord() {
    Account acc = new Account();
    acc.Name = 'Kohler';
    acc.Website = 'www.kohler.com';
  

    Account acc1 = new Account();
    acc1.Name = 'Shelll';
    acc1.Website = 'www.shell.com';
    

    List<Account> listAcc = new List<Account>{ acc, acc1 };
        
        if(!listAcc.isEmpty()){
            
            insert listAcc;
        }
  }

  public static void updateAccountField() {
    List<Account> listAcc = [
      SELECT id, Name,Description from Account 

    ];

    List<Account> updateAccounts = new List<Account>();

    for (Account eachAcc : listAcc) {
      eachAcc.Name = 'Account Test';
        eachAcc.Website='www.target.com';
        eachAcc.Description='This is a test description';

      updateAccounts.add(eachAcc);
    }

    if (!updateAccounts.isEmpty()) {
      update updateAccounts;
    }
  }
}