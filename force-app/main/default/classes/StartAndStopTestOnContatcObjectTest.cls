@isTest
public with sharing class StartAndStopTestOnContatcObjectTest {
  @isTest
  public static void testDataTest() {
    Account acc1 = new Account();
    acc1.Name = 'abc';
    // acc1.Industry = 'Energy';

    // Account acc2 = new Account();
    // acc2.Name = 'abd';
    // acc2.Industry = 'Banking';

    //List<account> listAcc = new List<account>();

    // listAcc.add(acc1);
    // listAcc.add(acc2);

    insert acc1;

    List<contact> listConn = new List<contact>();

    for (integer i = 0; i <= 9000; i++) {
      Contact cont = new Contact();

      cont.lastName = 'testStartTest';
      cont.AccountId = acc1.id;

      //   if (i < 100) {
      //     cont.accountid = acc1.id;
      //   } else if (i < 200) {
      //     cont.accountid = acc1.id;
      //   }

      listConn.add(cont);
    }

    // Test.startTest();

    insert listConn;

    // StartAndStopTestOnContatcObject.testData();

    //Test.stopTest();
  }
}