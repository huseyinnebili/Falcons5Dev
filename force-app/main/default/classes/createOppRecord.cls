public with sharing class createOppRecord {
  // @InvocableMethod
  public static void insertRecords(
    Opportunity opp,
    Quote qu,
    QuoteLineItem ql
  ) {
    insert opp;

    qu.OpportunityId = opp.id;
    insert qu;

    Product2 pro = new Product2();
    pro.Name = 'Test Product';
    insert pro;

    ql.QuoteId = qu.Id;
    ql.Product2Id = pro.Id;
    insert ql;
  }
}