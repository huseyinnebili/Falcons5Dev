@isTest
public with sharing class NewBankTriggerHandlerTest {
  @isTest
  public static void testHandler() {
    New_Bank__c obj = new New_Bank__c();
    obj.Bank_Name__c = 'Wells Fargo';
    obj.Bank_Agent_Name__c = 'Mary';
    obj.Bank_Loan_Types__c = 'Auto Loan';
    obj.Bank_APR__c = 4.25;

    New_Bank__c obj1 = new New_Bank__c();
    obj1.Bank_Name__c = 'PNC Bank';
    obj1.Bank_Agent_Name__c = 'Patricia';
    obj1.Bank_Loan_Types__c = 'Personal';
    obj1.Bank_APR__c = 4.25;

    List<New_Bank__c> listNewBank = new List<New_Bank__c>{ obj, obj1 };

    insert listNewBank;

    for (New_Bank__c eachNewBank : listNewBank) {
      eachNewBank.Bank_Name__c = 'Columbia Bank';
      eachNewBank.Bank_APR__c = 5.67;
    }

    update listNewBank;

    List<New_Bank__c> listBankReturned = [
      SELECT id, name, Bank_Name__c, Bank_Agent_Name__c, Bank_Loan_Types__c
      FROM New_Bank__c
    ];

    system.assertEquals('Columbia Bank', listBankReturned[0].Bank_Name__c);
  }

  @isTest
  public static void testTrigger() {
    New_Bank__c obj = new New_Bank__c();
    obj.Bank_Name__c = 'Wells Fargo';
    obj.Bank_Agent_Name__c = 'Mary';
    obj.Bank_Loan_Types__c = 'Auto Loan';
    obj.Bank_APR__c = 4.25;

    New_Bank__c obj1 = new New_Bank__c();
    obj1.Bank_Name__c = 'PNC Bank';
    obj1.Bank_Agent_Name__c = 'Patricia';
    obj1.Bank_Loan_Types__c = 'Personal';
    obj1.Bank_APR__c = 4.25;

    List<New_Bank__c> listNewBank = new List<New_Bank__c>{ obj, obj1 };

    insert listNewBank;

    for (New_Bank__c eachNewBank : listNewBank) {
      eachNewBank.Bank_Name__c = 'Columbia Bank';
      eachNewBank.Bank_APR__c = 5.67;
    }

    update listNewBank;

    List<New_Bank__c> listBankReturned = [
      SELECT id, name, Bank_Name__c, Bank_Agent_Name__c, Bank_Loan_Types__c
      FROM New_Bank__c
    ];

    system.assertEquals('Columbia Bank', listBankReturned[0].Bank_Name__c);
  }

  @isTest
  public static void testBatch() {
    New_Bank__c obj = new New_Bank__c();
    obj.Bank_Name__c = 'Wells Fargo';
    obj.Bank_Agent_Name__c = 'Mary';
    obj.Bank_Loan_Types__c = 'Auto Loan';
    obj.Bank_APR__c = 4.25;

    New_Bank__c obj1 = new New_Bank__c();
    obj1.Bank_Name__c = 'PNC Bank';
    obj1.Bank_Agent_Name__c = 'Patricia';
    obj1.Bank_Loan_Types__c = 'Personal';
    obj1.Bank_APR__c = 4.25;

    List<New_Bank__c> listNewBank = new List<New_Bank__c>{ obj, obj1 };
    for (integer i = 0; i <= 2000; i++) {
      New_Bank__c obj3 = new New_Bank__c();
      obj3.Bank_Name__c = 'Wells Fargo' + i;

      listNewBank.add(obj3);
    }

    insert listNewBank;

    Test.startTest();

    NewBankBatch obj4 = new NewBankBatch();

    Id jobID = Database.executeBatch(obj4);

    Test.stopTest();
  }
}