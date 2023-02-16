@IsTest
public class AccountProcessorTest {
  public static testMethod void TestAccountProcessorTest() {
    Account a = new Account();
    a.Name = 'Test Account';
    insert a;

    Contact cont = new Contact();
    cont.FirstName = 'Bob';
    cont.LastName = 'Masters';
    cont.AccountId = a.Id;
    insert cont;

    set<Id> setAccId = new Set<ID>();
    setAccId.add(a.id);

    Test.startTest();
    AccountProcessor.countContacts(setAccId);
    Test.stopTest();

    Account ACC = [
      SELECT Number_of_Contacts__c
      FROM Account
      WHERE id = :a.id
      LIMIT 1
    ];
    System.assertEquals(Integer.valueOf(ACC.Number_of_Contacts__c), 1);
  }
}