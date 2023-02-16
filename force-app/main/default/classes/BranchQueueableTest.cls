@isTest
public with sharing class BranchQueueableTest {
  @TestSetup
  static void setup() {
    List<Branch__c> listBranch = new List<Branch__c>();

    for (integer i = 0; i < 900; i++) {
      Branch__c obj = new Branch__c();

      obj.HOD_Phone__c = '213234221' + i;
      // obj.Branch_Registration_Due_Date__c = Date.today();

      listBranch.add(obj);
    }

    insert listBranch;
  }

  @isTest
  public static void queueableTest() {
    List<Branch__c> listBranch = [
      SELECT id, name, Branch_Name__c, Branch_Registration_Due_Date__c
      FROM Branch__c
    ];

    BranchQueueable obj = new BranchQueueable(listBranch);

    Test.startTest();
    System.enqueueJob(obj);
    Test.stopTest();

    // List<Branch__c> listBranchNew = [
    //   SELECT id, name, Branch_Name__c, Branch_Registration_Due_Date__c
    //   FROM Branch__c
    // ];
    // for (Branch__c eachBr : listBranchNew) {
    //   system.assert(eachBr.Branch_Name__c.contains('Math'));
    // }
  }
}