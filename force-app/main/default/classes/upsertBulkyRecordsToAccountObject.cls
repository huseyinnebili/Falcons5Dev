public with sharing class upsertBulkyRecordsToAccountObject {
  public static void insertNewRecord() {
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

    if (!listAcc.isEmpty()) {
      insert listAcc;
    }
  }

  public static void updateFields() {
    List<Account> listAccReturned = [
      SELECT id, name, Industry, UpsellOpportunity__c
      FROM Account
      WHERE UpsellOpportunity__c = 'No'
    ];

    for (Account eachAcc : listAccReturned) {
      eachAcc.UpsellOpportunity__c = 'Yes';
    }

    update listAccReturned;
  }
}