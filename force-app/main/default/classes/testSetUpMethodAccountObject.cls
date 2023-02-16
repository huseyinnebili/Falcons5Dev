@isTest
public with sharing class testSetUpMethodAccountObject {
  @TestSetup
  public static void makeData() {
    Account acc1 = new Account();
    acc1.name = 'efg';
    acc1.Industry = 'Energy';

    Account acc2 = new Account();
    acc2.name = 'mnr';
    acc2.Industry = 'Energy';

    Account acc3 = new Account();
    acc3.name = 'dlm';
    acc3.Industry = 'Banking';

    List<Account> listAcc = new List<Account>{ acc1, acc2, acc3 };

    // listAcc.add(acc1);
    // listAcc.add(acc2);
    // listAcc.add(acc3);

    insert listAcc;

    List<Contact> listCont = new List<Contact>();

    for (Integer i = 0; i < 9990; i++) {
      Contact cont = new Contact();

      cont.LastName = 'Alfonso';

      if (i < 3000) {
        cont.AccountId = acc1.id;
      } else if (i < 6000) {
        cont.AccountId = acc2.id;
      } else if (i < 9999) {
        cont.AccountId = acc3.id;
      }

      listCont.add(cont);
    }

    insert listCont;
  }

  @isTest
  public static void test1() {
    List<contact> listCont = [SELECT id, name FROM contact];

    FetchOppObjFromAccountObj.fetchChildToParent();
  }

  @isTest
  public static void test2() {
    list<account> listAcc = [SELECT id, name, type FROM account];

    for (Account eachAcc : listAcc) {
      eachAcc.type = 'Customer - Direct';
    }

    update listAcc;

    list<Opportunity> listOpp = new List<Opportunity>();

    for (integer i = 0; i < 300; i++) {
      Opportunity opp = new Opportunity();

      opp.Name = 'efg';
      opp.StageName = 'Closed Won';
      opp.CloseDate = date.today();

      if (i < 100) {
        opp.AccountId = listAcc[0].id;
      } else if (i < 200) {
        opp.AccountId = listAcc[1].id;
      } else if (i < 300) {
        opp.AccountId = listAcc[2].id;
      }

      listOpp.add(opp);
    }

    //  Test.startTest();
    // insert listOpp;
    FetchOppObjFromAccountObj.fetchParentToChildObj();
    //Test.stopTest();
  }
}