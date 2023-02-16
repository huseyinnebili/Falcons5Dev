@isTest
public with sharing class SoqlDemoTest {
  @isTest
  public static void soqlDemoTestOne() {
    List<Account> accList = new List<Account>();

    Account acc1 = new Account();
    acc1.name = 'abc';

    Account acc2 = new Account();
    acc2.name = 'abcd';

    accList.add(acc1);
    accList.add(acc2);

    insert accList;

    SoqlDemo.accountSOQL_1();
  }

  @isTest
  public static void soqlDemoTestTwo() {
    List<Account> accList = new List<Account>();

    Account acc1 = new Account();
    acc1.name = 'abc';
    acc1.phone = '2102122312';

    Account acc2 = new Account();
    acc2.name = 'abcd';
    acc2.phone = '2102122399';

    accList.add(acc1);
    accList.add(acc2);

    insert accList;

    SoqlDemo.accountSOQL_2();

    List<Account> AccountList = [SELECT id, name, phone FROM account];
    system.assertEquals('abc', AccountList[0].name);
    system.assertEquals('2102122399', AccountList[1].phone);
  }

  @isTest
  public static void soqlDemoTestThree() {
    List<Contact> connList = new List<Contact>();

    Contact conn1 = new Contact();
    conn1.LastName = 'abc';
    conn1.AssistantPhone = '2112342123';
    conn1.Languages__c = 'English';

    Contact conn2 = new Contact();
    conn2.LastName = 'abcd';
    conn2.AssistantPhone = '2901231243';
    conn2.Languages__c = 'Spanish';

    connList.add(conn1);
    connList.add(conn2);

    insert connList;

    SoqlDemo.contactSOQL_1();

    conn2.Languages__c = 'Spanish';
    List<Contact> connectList = [
      SELECT id, name, LastName, AssistantPhone
      FROM Contact
    ];

    system.assertEquals(2, connectList.size());
  }

  @isTest
  public static void soqlDemoTestFour() {
    List<Case> caseList = new List<Case>();

    Case c = new Case();

    c.Origin = 'Phone';
    c.Status = 'Working';

    insert c;

    SoqlDemo.soqlDemoFilter();
  }

  @isTest
  public static void soqlDemoTestFive() {
    List<Case> caseList = new List<Case>();

    Case c = new Case();

    c.Origin = 'Phone';
    c.Status = 'Working';

    insert c;

    SoqlDemo.soqlDemoFilter('Working');
  }
}