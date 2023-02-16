@isTest
public with sharing class scoreCardTriggerHandlerShortTest {
  @isTest
  public static void Test() {
    Account acc = new Account();
    acc.Name = 'Test';

    insert acc;

    Contact conn = new Contact();
    conn.LastName = 'Test Contact';
    conn.AccountId = acc.Id;
    insert conn;
   
      //Case cs=new Case();
      //cs.Origin='Email';
      //cs.Status='Working';
      
    try {
      delete acc;
    } catch (DmlException e) {
      system.assert(
        e.getMessage()
          .contains(
            'You can not delete rocords associated with Contact records.'
          ),
        'You can not delete rocords associated with Contact records.'
      );
    }
  }
}