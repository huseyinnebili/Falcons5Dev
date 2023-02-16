@isTest
public with sharing class PreventingWorkRecordDeletingTriggerTest {
  @isTest
  public static void TriggerTest() {
    Account acc = new Account();

    acc.Name = 'Test Account';

    insert acc;

    try {
      delete acc;
    } catch (Exception e) {
      system.assert(
        e.getMessage().contains('Account Cannot be deleted'),
        'Account Cannot be deleted'
      );
    }
  }
}