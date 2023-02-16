@isTest
public class SampleTest {

    @isTest
    public static void test(){
        
        Test.startTest();
        
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
        for (integer i = 0; i <= 9900;i++){
      New_Bank__c obj3 = new New_Bank__c();
      obj3.Bank_Name__c = 'Wells Fargo' + i;

      listNewBank.add(obj3);
    }

    insert listNewBank;
        
        Test.stopTest();
        
    }
}