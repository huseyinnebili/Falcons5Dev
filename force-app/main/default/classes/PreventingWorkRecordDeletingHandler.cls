public with sharing class PreventingWorkRecordDeletingHandler {
  public static void preventingWorkRecordDeleted(List<Account> accTriggerOld) {
    for (Account acc : accTriggerOld) {
      acc.addError('Account Cannot be deleted');
    }
  }
}