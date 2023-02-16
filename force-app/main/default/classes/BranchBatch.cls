public with sharing class BranchBatch implements Database.Batchable<sObject>, database.stateful {
  public integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [
        SELECT
          id,
          name,
          Branch_Job_Bord_Source_URL__c,
          Registration_Confirmation_Status__c
        FROM Branch__c
        WHERE Registration_Confirmation_Status__c = 'Completed'
      ]
    );

    return ql;
  }

  public void execute(Database.BatchableContext bc, List<Branch__c> scope) {
    List<Branch__c> listBranchUpdate = new List<Branch__c>();

    for (Branch__c eachBranch : scope) {
      //  if (eachBranch.Registration_Confirmation_Status__c == 'Completed') {
      eachBranch.Branch_Job_Bord_Source_URL__c = 'https://www.linkedin.com/';

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