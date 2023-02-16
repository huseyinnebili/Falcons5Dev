public with sharing class updateContact {
  // public static List<Account> createOpportunity(List<Account> listAcc) {
  //   try {
  //     for (Account acc : listAcc) {
  //       Opportunity opp = new Opportunity();
  //       opp.Name = acc.Name + ' Opportunity';
  //       opp.AccountId = acc.Id;
  //       opp.Type = 'Existing Customer - Upgrade';
  //       opp.StageName = 'Needs Analysis';
  //       opp.CloseDate = System.today() + 90;
  //       opp.ForecastCategoryName = 'Pipeline';

  //       insert opp;
  //     }
  //     return listAcc;
  //   } catch (Exception e) {
  //     System.debug(e);
  //     return null;
  //   }
  // }

@AuraEnabled
  public static List<Opportunity> createOpportunities(String accounts) {
    System.debug('accounts > '+accounts);
    List<String> accountId = new List<String>();
    if(String.isNotBlank(accounts) && accounts.contains(',')){
      accountId = accounts.split(',');
    }else{
      accountId.add(accounts);
    }
    List<Opportunity> oppsToInsert = new List<Opportunity>();
    System.debug('accountId > '+accountId);
    for (String acc : accountId) {
      System.debug('acc > '+acc);
      acc= acc.replaceAll( '\\s+', '');
      Opportunity opp = new Opportunity();
      opp.Name = 'Test Opportunity';
      opp.StageName = 'Needs Analysis';
      opp.CloseDate = Date.today().addDays(30);
      opp.AccountId = (Id)acc;
      oppsToInsert.add(opp);      
    }
    System.debug('oppsToInsert > '+oppsToInsert);
    insert oppsToInsert;
    return oppsToInsert;
  }
}