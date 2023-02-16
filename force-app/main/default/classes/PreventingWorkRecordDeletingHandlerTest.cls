@isTest
public with sharing class PreventingWorkRecordDeletingHandlerTest {
  @isTest
  public static void Test() {
    Account acc = new Account();

    acc.Name = 'Test Account';

    insert acc;

    try {
      delete acc;
    } catch (DmlException e) {
      system.assert(
        e.getMessage().contains('Account Cannot be deleted'),
        'Account Cannot be deleted'
      );
    }
  }
}