@isTest
public with sharing class BranchTriggerTest {
  @isTest
  public static void triggerTest() {
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
      eachBranch.Branch_Registration_Due_Date__c = Date.today();
    }

    update listBranch;
  }
}