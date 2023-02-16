@isTest
public with sharing class preventDuplicateContactsTest {
  @isTest
  public static void test() {
    Contact conn = new Contact();
    conn.LastName = 'Test';
    conn.Email = 'test@gmail.com';

    Contact conn2 = new Contact();
    conn2.LastName = 'Test Two';
    conn2.Email = 'test_two@gmail.com';

    List<Contact> listContact = new List<Contact>{ conn, conn2 };

    try {
      Contact con3 = new Contact();
      con3.LastName = 'Test Three';
      con3.Email = 'test@gmail.com';

      insert con3;

      for (Contact con : listContact) {
        con.Email = 'test@gmail.com';
      }

      update listContact;
    } catch (Exception e) {
      System.debug('An error happened, as predicted!');
    }
  }
}