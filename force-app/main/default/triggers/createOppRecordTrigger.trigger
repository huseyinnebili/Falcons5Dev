trigger createOppRecordTrigger on Opportunity(after insert) {
  Opportunity opp = new Opportunity();
  opp.Name = 'Test Opportunity';
  opp.StageName = 'Needs Analysis';
  opp.CloseDate = Date.today().addDays(30);

  Quote qu = new Quote();
  qu.Name = 'Test Quote';

  QuoteLineItem ql = new QuoteLineItem();
  ql.UnitPrice = decimal.valueOf('20000');
  ql.Quantity = 100;

  //createOppRecord.insertRecords(opp, qu, ql);

}