public class DmlDemo {
  public static void insertNewAccountRecord() {
    Account acc = new Account();

    acc.Name = 'IBM';
    acc.UpsellOpportunity__c = 'Yes';
    acc.Active__c = 'Yes';
    acc.Type = 'Technology Partner';
    acc.Industry = 'Engineering';

    insert acc;
    //update acc;

    system.debug('acc = ' + acc);
  }

  public static void insertNewAccountRecordTwo() {
    Account acc = new Account();

    acc.Name = 'IBM';
    acc.Industry = 'Entertainment';

    insert acc;

    acc.Industry = 'Hospitality';
    acc.Industry = 'Government';
    acc.Industry = 'Finance';

    System.debug('inserted acc = ' + acc);

    update acc;

    System.debug('updated acc = ' + acc);
  }

  public static void updateCurrentAccountRecord() {
    Account acc = [
      SELECT id, name
      FROM account
      WHERE name = 'United Oil & Gas Corp.'
      LIMIT 1
    ];

    acc.Industry = 'Transportation';
    acc.Ownership = 'Subsidiary';
    acc.Type = 'Channel Partner / Reseller';

    update acc;

    System.debug('updated acc = ' + acc);
  }

  public static void updateCurrentAccountRecordTwo() {
    Account acc = [
      SELECT id, name, CustomerPriority__c, NumberOfEmployees, Type
      FROM account
      WHERE name = 'Express Logistics and Transport'
      LIMIT 1
    ];

    acc.CustomerPriority__c = 'High';
    acc.NumberOfEmployees = 1000;
    acc.Type = '	Customer - Channel';

    update acc;

    System.debug('updated acc = ' + acc);
  }

  @TestVisible
  private static void insertRelatedRecordsOfAccountRecord() {
    Account acc = [
      SELECT id, name
      FROM account
      WHERE name = 'Cognizant Inc.'
      LIMIT 1
    ];

    Contact cont = new Contact();

    cont.LastName = 'Rose';
    cont.AccountId = acc.Id;

    insert cont;

    System.debug('inserted cont = ' + cont);
  }

  @TestVisible
  private static void insertRelatedRecordsOfAccountRecordTwo() {
    Account acc = [SELECT id, name FROM account WHERE name = 'Meta' LIMIT 1];

    Contact cont = new Contact();

    cont.LastName = 'Abuzer';
    cont.AccountId = acc.Id;
    cont.MobilePhone = '2014537212';
    cont.LeadSource = 'Public Relations';
    cont.Languages__c = 'English,Turkish';

    insert cont;

    System.debug('inserted cont = ' + cont);
  }

  public static void insertMultipleRecordsBulkOfAccountRecords() {
    List<Account> listOfAccs = new List<Account>();

    Account acc1 = new Account();

    acc1.Name = 'Facebook';
    acc1.Rating = 'Warm';
    acc1.AccountNumber = 'AB12313';
    acc1.Industry = 'Engineering';

    listOfAccs.add(acc1);

    Account acc2 = new Account();

    acc2.Name = 'Google';
    acc2.Rating = 'Hot';
    acc2.AccountNumber = 'AC12613';
    acc2.Industry = 'Communications';

    listOfAccs.add(acc2);

    Account acc3 = new Account();

    acc3.Name = 'Syntax';
    acc3.Rating = 'Cold';
    acc3.AccountNumber = 'AD12613';
    acc3.Industry = 'Biotechnology';

    listOfAccs.add(acc3);

    System.debug('listOfAccs = ' + listOfAccs);

    insert listOfAccs;
  }

  public static void insertMultipleRecordsBulkOfAccountRecordsTwo() {
    List<Lead> listOfLeads = new List<Lead>();

    Lead lead1 = new Lead();

    lead1.LastName = 'Carson';
    lead1.Company = 'Microsoft';
    lead1.Status = 'Working - Contacted';
    lead1.ProductInterest__c = 'GC3000 series';

    listOfLeads.add(lead1);

    Lead lead2 = new Lead();

    lead2.LastName = 'Dawson';
    lead2.Company = 'Apple';
    lead2.Status = 'Open - Not Contacted';
    lead2.ProductInterest__c = 'GC5000 series';

    listOfLeads.add(lead2);

    System.debug('listOfLeads = ' + listOfLeads);

    insert listOfLeads;
  }
}