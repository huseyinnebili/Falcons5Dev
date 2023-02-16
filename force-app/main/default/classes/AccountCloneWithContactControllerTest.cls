@isTest
public class AccountCloneWithContactControllerTest {
  @isTest
  public static void test() {
    Account ac = new Account(Name = 'Test Account');
    insert ac;

    //AccountNew is the Visualforce page created
    PageReference testPage = Page.AccountCloneWithContact;
    Test.setCurrentPage(testPage);
    testPage.getParameters().put('Id', String.valueOf(ac.Id));

    Contact cont = new Contact();

    cont.LastName = 'Test';
    cont.Accountid = ac.id;
    insert cont;

    ApexPages.StandardController sc = new ApexPages.StandardController(ac);
    AccountCloneWithItemController ext = new AccountCloneWithItemController(sc);
    // ext.cloneWithItems();

    // Switch to test context
    Test.startTest();

    // call the cloneWithItems method
    PageReference ref = ext.cloneWithItems();
    // create the matching page reference
    PageReference redir = new PageReference(
      '/' +
      ext.newRecordId +
      '/e?retURL=%2F' +
      ext.newRecordId
    );

    // make sure the user is sent to the correct url
    System.assertEquals(ref.getUrl(), redir.getUrl());

    // check that the new po was created successfully
    Account newAcc = [SELECT id FROM Account WHERE id = :ext.newRecordId];
    System.assertNotEquals(newAcc, null);

    // check that the line item was created
    List<Contact> newCon = [
      SELECT Id, AccountId
      FROM Contact
      WHERE AccountId = :newAcc.id
    ];
    System.assertEquals(newCon.size(), 1);

    // Switch back to runtime context
    Test.stopTest();
  }
}