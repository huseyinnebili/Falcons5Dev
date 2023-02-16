public with sharing class UpdateCaseFieldsViaFuture {
  public static void updateCaseField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap
  ) {
    Set<Id> setIDs = new Set<Id>();

    for (Account acc : accountTriggerNew) {
      if (acc.Description != null) {
        if (
          accountTriggerOld == null ||
          acc.Name != accountTriggerOldMap.get(acc.id).Name
        ) {
          setIDs.add(acc.Id);
        }
      }
    }

    if (!setIDs.isEmpty()) {
      updateCaseFieldsViaFuture(setIDs);
    }
  }

  @future
  public static void updateCaseFieldsViaFuture(Set<Id> setIDs) {
    List<Case> listOFCase = [
      SELECT id, Description, Account.Description, AccountId, Priority
      FROM Case
      WHERE AccountId IN :setIDs
    ];

    List<Case> updateToCase = new List<Case>();

    if (!listOFCase.isEmpty()) {
      for (Case cs : listOFCase) {
        if (cs.Priority == 'High') {
          cs.Description = cs.Account.Description;

          updateToCase.add(cs);
        }
      }
    }

    if (!updateToCase.isEmpty()) {
      update updateToCase;
    }
  }
}