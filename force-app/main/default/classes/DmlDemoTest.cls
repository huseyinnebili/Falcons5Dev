@isTest
public with sharing class DmlDemoTest {
  @isTest
  public static void DmlDemoTest() {
    DmlDemo.insertNewAccountRecord();

    List<Account> listAcc = [SELECT id, name FROM account WHERE name = 'IBM'];

    system.assertEquals(1, listAcc.size());
    system.assertEquals('IBM', listAcc[0].Name);
  }

  @isTest
  public static void DmlDemoTest2() {
    DmlDemo.insertNewAccountRecordTwo();

    List<Account> listAcc = [
      SELECT id, name, Industry
      FROM account
      WHERE Industry = 'Finance'
    ];

    system.assertEquals('Finance', listAcc[0].Industry);
    system.assertEquals(1, listAcc.size());
  }

  //System.QueryException: List has no rows for assignment to SObject

  @isTest
  public static void DmlDemoTest3() {
    DmlDemo.updateCurrentAccountRecordTwo();
  }
}