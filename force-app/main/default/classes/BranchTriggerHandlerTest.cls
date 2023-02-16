@isTest
public with sharing class BranchTriggerHandlerTest {
  @isTest
  public static void handlerTest() {
    Branch__c obj1 = new Branch__c();
    obj1.Branch_Name__c = 'Math';
    obj1.HOD_Name__c = 'Anna';
    obj1.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 12);

    Branch__c obj2 = new Branch__c();
    obj2.Branch_Name__c = 'Sience';
    obj2.HOD_Name__c = 'Eugene';
    obj2.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 19);

    List<Branch__c> listBranch = new List<Branch__c>{ obj1, obj2 };

    insert listBranch;

    for (Branch__c eachBranch : listBranch) {
      eachBranch.Branch_Name__c = 'Statistician ';
      eachBranch.Branch_Registration_Due_Date__c = Date.today();
    }

    update listBranch;

    list<Branch__c> listBranchReturned = [
      SELECT Branch_Name__c, HOD_Name__c, Branch_Registration_Due_Date__c
      FROM Branch__c
    ];

    system.assertEquals('Statistician', listBranchReturned[0].Branch_Name__c);
  }

  @isTest
  public static void handlerTestFutureMethod() {
    Branch__c obj1 = new Branch__c();
    obj1.Branch_Name__c = 'Math';
    obj1.HOD_Name__c = 'Anna';
    obj1.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 12);
    obj1.Registration_Confirmation_Status__c = '	In Progress';
    obj1.Branch_Description__c = 'Financial managers have the responsibility of overseeing the finances of major companies, agencies and everything in between';

    Branch__c obj2 = new Branch__c();
    obj2.Branch_Name__c = 'Sience';
    obj2.HOD_Name__c = 'Eugene';
    obj2.Registration_Confirmation_Status__c = '	In Progress';
    obj2.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 19);
    obj2.Branch_Description__c = 'Financial managers have the responsibility of overseeing the finances of major companies, agencies and everything in between';

    List<Branch__c> listBranch = new List<Branch__c>{ obj1, obj2 };

    insert listBranch;

    for (Branch__c eachBranch : listBranch) {
      eachBranch.Registration_Confirmation_Status__c = 'Completed';
    }

    update listBranch;
    set<id> setBranchIDs = new Set<id>{ obj1.id, obj2.id };

    Test.startTest();

    BranchTriggerHandler.updateBranchReviewField(setBranchIDs);

    Test.stopTest();

    List<Branch__c> listBranchTwo = [
      SELECT id, name, Branch_Description__c
      FROM Branch__c
    ];

    system.assert(listBranchTwo[0].Branch_Description__c.contains('Financial'));
  }
}