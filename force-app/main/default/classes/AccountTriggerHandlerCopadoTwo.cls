public with sharing class AccountTriggerHandlerCopadoTwo {
  public static void updateAccountField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    boolean condition = false;
    for (Account eachAcc : accountTriggerNew) {
      if (accountTriggerOldMap == null && eachAcc.Name != null) {
        if (eachAcc.Website != null) {
          condition = true;
        } else {
          eachAcc.addError('Please do not keep Website field empty!..');
        }
      }

      if (accountTriggerOldMap != null) {
        if (eachAcc.Name != accountTriggerOldMap.get(eachAcc.id).Name) {
          if (eachAcc.Website != null) {
            condition = true;
          } else {
            eachAcc.addError('Please do not keep Website field!..');
          }
        }
      }
      if (condition) {
        eachAcc.Type = 'Prospect';
        eachAcc.AnnualRevenue = 120000000;
        eachAcc.Description = 'This account is created through apex trigger.';
      }
    }
  }
  public static void insertRecordToCase(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    List<Case> listCases = new List<Case>();
    for (Account eachAccount : accountTriggerNew) {
      Case ca = new Case();
      ca.AccountId = eachAccount.Id;
      ca.Subject = 'Order was not placed in time';
      ca.Origin = 'Web';
      ca.Priority = 'High';
      ca.Reason = 'New problem';

      Case ca1 = new Case();
      ca1.AccountId = eachAccount.Id;
      ca1.Subject = 'Order lost';
      ca1.Origin = 'Web';
      ca1.Priority = 'Low';
      ca1.Reason = 'New problem';

      listCases.add(ca);
      listCases.add(ca1);
    }
    if (!listCases.isEmpty()) {
      insert listCases;
    }
  }

  public static void updateCaseFieldRespectToAccountField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    Set<Id> setAccountIDs = new Set<Id>();

    for (Account eachAcc : accountTriggerNew) {
      if (
        eachAcc.Name != accountTriggerOldMap.get(eachAcc.id).Name
      ) {
        setAccountIDs.add(eachAcc.id);
      }
    }

    List<Case> returnedCases = [
      SELECT
        id,
        Subject,
        Origin,
        Priority,
        Reason,
        Description,
        Account.Description,
        Account.Id
      FROM Case
      WHERE Account.Id IN :setAccountIDs
    ];

    List<Case> updateCase = new List<Case>();
    for (Account eachAccount : accountTriggerNew) {
      for (Case eachCase : returnedCases) {
        if (eachCase.Origin == 'Web') {
           String caseDescription = accountTriggerNewMap.get(eachCase.Account.Id)
           .Description;

          eachCase.Description = caseDescription;

          updateCase.add(eachCase);
        } else {
          eachAccount.addError('Origin cannot be kept empty!..');
        }
      }
    }

   
      update updateCase;
    
  }
}