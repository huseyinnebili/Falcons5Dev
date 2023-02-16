@isTest
public with sharing class DmlDemoTestTwo {
  @isTest
  public static void dmlDemoTest1() {
    DmlDemo.insertNewAccountRecord();

    List<Account> accList = [SELECT id, name FROM account WHERE name = 'IBM'];

    system.assertEquals(1, accList.size());
    system.assertEquals('IBM', accList[0].Name);
  }

  @isTest
  public static void dmlDemoTest2() {
    DmlDemo.insertMultipleRecordsBulkOfAccountRecords();

    List<Lead> listOfLeads = [
      SELECT id, name, Company
      FROM lead
      WHERE Company IN ('Apple', 'Microsoft')
    ];

    for (Lead eachLead : listOfLeads) {
      system.assertEquals('Apple', eachLead.Company);
      system.assertEquals('Microsoft', eachLead.Company);
    }
  }

  @isTest
  public static void dmlDemoTest3() {
    //List<account> acc = new List<account>();
    //how many records will be fetched?=>0
    //Because we cannot access the org.
    //So we have to create an account first.
    //Prepare Data because we cannot access anything from the org.

    Account acc = new Account();
    acc.Name = 'Meta';

    insert acc;
    //2.Call methods.
    DmlDemo.insertRelatedRecordsOfAccountRecordTwo();

    //3.Assertions
    list<contact> contactList = [
      SELECT id, LastName, MobilePhone, LeadSource
      FROM Contact
    ];
    // for (Contact eachConn : acc.Contacts) {
    for (Contact eachConn : contactList) {
      system.assertEquals('Abuzer', eachConn.LastName);
      system.assertEquals('2014537212', eachConn.MobilePhone);
      system.assertEquals('Public Relations', eachConn.LeadSource);
      system.assertEquals(1, contactList.size());
    }
  }

  @isTest
  public static void dmlDemoTest4() {
    Account acc = new Account();

    acc.Name = 'Cognizant Inc.';

    insert acc;

    DmlDemo.insertRelatedRecordsOfAccountRecord();

    list<contact> contactList = [
      SELECT id, LastName, MobilePhone, LeadSource
      FROM Contact
    ];
    //for (Contact conn : acc.Contacts) {
    for (Contact conn : contactList) {
      system.assertEquals('Rose', conn.LastName);
      System.debug(conn.Id);
    }
  }

  @isTest
  public static void dmlDemoTest5() {
    DmlDemo.insertMultipleRecordsBulkOfAccountRecords();

    List<Account> listOfAccs = [
      SELECT id, name, Rating, Industry, AccountNumber
      FROM account
    ];

    // for (Account eacAcc : listOfAccs) {
    system.assertEquals('Warm', listOfAccs[0].Rating);
    system.assertEquals('Engineering', listOfAccs[0].Industry);
    system.assertEquals('AB12313', listOfAccs[0].AccountNumber);
    system.assertEquals('Hot', listOfAccs[1].Rating);
    system.assertEquals('Communications', listOfAccs[1].Industry);
    system.assertEquals('AC12613', listOfAccs[1].AccountNumber);
  }
}