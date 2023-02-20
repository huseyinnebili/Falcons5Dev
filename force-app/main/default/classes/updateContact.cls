public with sharing class updateContact {
  @AuraEnabled
  public static List<Opportunity> createOpportunities(String accounts) {
    System.debug('accounts > ' + accounts);
    List<String> accountId = new List<String>();
    if (String.isNotBlank(accounts) && accounts.contains(',')) {
      accountId = accounts.split(',');
    } else {
      accountId.add(accounts);
    }
    List<Opportunity> oppsToInsert = new List<Opportunity>();
    System.debug('accountId > ' + accountId);
    for (String acc : accountId) {
      System.debug('acc > ' + acc);
      acc = acc.replaceAll('\\s+', '');
      Opportunity opp = new Opportunity();
      opp.Name = 'Test Opportunity';
      opp.StageName = 'Needs Analysis';
      opp.CloseDate = Date.today().addDays(30);
      opp.AccountId = (Id) acc;
      oppsToInsert.add(opp);
    }
    System.debug('oppsToInsert > ' + oppsToInsert);
    insert oppsToInsert;
    return oppsToInsert;
  }

  @AuraEnabled
  public static List<softinnovas144__Subscription__c>  updateSubscription(String accountId, String subscriptions) {
    System.debug('subscriptions > ' + subscriptions);
    System.debug('accountId > ' + accountId);
    List<String> subscriptionIds = new List<String>();
    if (String.isNotBlank(subscriptions) && subscriptions.contains(',')) {
      subscriptionIds = subscriptions.split(',');
    } else {
      subscriptionIds.add(subscriptions);
    }
    Opportunity opp = new Opportunity();
    opp.Name = 'Test Opportunity';
    opp.StageName = 'Needs Analysis';
    opp.CloseDate = Date.today().addDays(30);
    opp.AccountId = accountId;

    insert opp;

    Product2 p = new Product2(name = 'Test product',IsActive = true);
    insert p;

    //Id pbId = Test.getStandardPricebookId();
   

    Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];

    PriceBookEntry pe = new PriceBookEntry(PriceBook2Id = standardPB.Id, Product2Id = p.id, UnitPrice = 100, IsActive = true);
    insert pe;

    Quote q = new Quote(name = 'Test quote', OpportunityId = opp.id, PriceBook2Id = standardPB.Id);
    insert q;

    QuoteLineItem qli = new QuoteLineItem(QuoteId = q.id, PriceBookentryId = pe.Id, Quantity = 1, UnitPrice = 1);
    insert qli; 

    System.debug('subscriptionIds > ' + subscriptionIds);
    List<softinnovas144__Subscription__c> subscriptionList = new List<softinnovas144__Subscription__c>();
    for (String sub : subscriptionIds) {
      softinnovas144__Subscription__c subscription  = new softinnovas144__Subscription__c();
      subscription.Id = sub.trim();
      subscription.softinnovas144__Quote_Line_Item__c = qli.Id;
      subscriptionList.add(subscription);
    }
    if(!subscriptionList.isEmpty()){
      update subscriptionList;
    }
    
    return subscriptionList;
  }
}