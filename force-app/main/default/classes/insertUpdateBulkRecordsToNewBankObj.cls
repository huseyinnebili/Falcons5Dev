public with sharing class insertUpdateBulkRecordsToNewBankObj {
  public static void insertRecordsToParentObj() {
    New_Bank__c obj = new New_Bank__c();

    obj.Bank_Name__c = 'Capital One';
    obj.Bank_Agent_Name__c = 'Henry';
    obj.Bank_Loan_Types__c = 'Mortgate';

    New_Bank__c obj1 = new New_Bank__c();
    obj1.Bank_Name__c = 'Valley Bank';
    obj1.Bank_Agent_Name__c = 'Sue';
    obj1.Bank_Loan_Types__c = 'Personal';

    List<New_Bank__c> listNewBank = new List<New_Bank__c>{ obj, obj1 };

    insert listNewBank;
  }

  public static void updateField() {
    List<New_Bank__c> listBankReturned = [
      SELECT id, name, Bank_State__c
      FROM New_Bank__c
      WHERE Bank_State__c = NULL
    ];

    for (New_Bank__c eachBank : listBankReturned) {
      eachBank.Bank_State__c = 'NJ';
    }

    if (!listBankReturned.isEmpty()) {
      update listBankReturned;
    }
  }
}