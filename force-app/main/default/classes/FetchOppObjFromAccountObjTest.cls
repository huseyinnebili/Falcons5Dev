@isTest
public with sharing class FetchOppObjFromAccountObjTest {
  @isTest
  public static void FetchOppObjFromAccountObjTest() {
    Account acc1 = new Account();
    acc1.name = 'abc';

    Account acc2 = new Account();
    acc2.name = 'dbc';

    Account acc3 = new Account();
    acc3.name = 'ghl';

    List<Account> listAcc = new List<Account>();

    listAcc.add(acc1);
    listAcc.add(acc2);
    listAcc.add(acc3);

    List<Opportunity> listOpp = new List<Opportunity>();

    for (integer i = 0; i < 9999; i++) {
      Opportunity opp = new Opportunity();

      opp.name = 'TestOpp' + i;
      opp.StageName = 'Negotiation/Review';
      opp.CloseDate = Date.today();

      if (i < 3000) {
        opp.AccountId = acc1.id;
      } else if (i < 6000) {
        opp.AccountId = acc2.id;
      } else if (i < 9999) {
        opp.AccountId = acc3.id;
      }

      listOpp.add(opp);
    }

    insert listOpp;

    FetchOppObjFromAccountObj.fetchParentToChildObj();
  }
}