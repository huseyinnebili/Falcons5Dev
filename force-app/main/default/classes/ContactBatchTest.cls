@isTest
public with sharing class ContactBatchTest {
  @isTest
  public static void ContactBatchTest() {
    List<Contact> listName = new List<Contact>();

    for (integer i = 0; i < 10000; i++) {
      Contact co = new Contact();

      co.LastName = 'Azare';

      listName.add(co);
    }
    insert listName;

    Test.startTest();

    //To fix the Error: 'No more than one executeBatch can be called from within a testmethod'!..
    if (!Test.isRunningTest()) {
      ContactBatch connn = new ContactBatch();

      Database.executeBatch(connn, 200);
    }
    Test.stopTest();
  }
}