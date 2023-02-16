public with sharing class FetchOppObjFromAccountObj {
  public static void fetchParentToChildObj() {
    List<Account> listAcc = [
      SELECT
        id,
        name,
        AnnualRevenue,
        (
          SELECT name, StageName, amount
          FROM Opportunities
          WHERE StageName = 'Closed Won'
        ),
        (SELECT lastName FROM Contacts)
      FROM account
      WHERE type = 'Customer - Direct'
    ];

    for (Account eachAcc : listAcc) {
      System.debug(
        'Account name : ' +
        eachAcc.name +
        ' its revenue => ' +
        eachAcc.AnnualRevenue
      );

      integer countOpp = 0;

      for (Opportunity eacOpp : eachAcc.Opportunities) {
        System.debug('opp name : ' + eachAcc.Name);
        System.debug('opp StageName : ' + eacOpp.StageName);

        countOpp++;
      }

      System.debug('opp count : ' + countOpp);
    }
  }

  public static void fetchChildToParent() {
    list<Contact> listContact = [
      SELECT
        id,
        name,
        AssistantName,
        Description,
        Account.id,
        Account.Name,
        Account.CustomerPriority__c
      FROM Contact
    ];

    for (Contact eachContact : listContact) {
      System.debug('AssistantName : ' + eachContact.AssistantName);
      System.debug(
        'Account.CustomerPriority__c : ' + Account.CustomerPriority__c
      );
    }
  }
}