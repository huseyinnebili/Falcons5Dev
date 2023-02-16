public with sharing class ContactBatch implements Database.Batchable<sObject>, database.stateful {
  public integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [SELECT id, name, Email FROM Contact]
    );

    return ql;
  }

  public void execute(Database.BatchableContext bc, List<Contact> scope) {
    List<Contact> listBranchUpdate = new List<Contact>();

    for (Contact eachBranch : scope) {
      //  if (eachBranch.Registration_Confirmation_Status__c == 'Completed') {
      eachBranch.Email = 'abcg@gmail.com';

      listBranchUpdate.add(eachBranch);

      count++;
    }
    //  }

    update listBranchUpdate;
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('done with updating all the accounts!...');
    System.debug('# of records updated: ' + count);
  }
}