public with sharing class AccountTrigerHandler {
  public static void updateAccountFields(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    boolean condition = false;

    for (Account eachAcc : accountTriggerNew) {
      //Trigger.Before && Trigger.insert
      if (accountTriggerOldMap == null && eachAcc.Name != null) {
        if (eachAcc.Industry != null && eachAcc.CustomerPriority__c == 'High') {
          condition = true;
        } else {
          eachAcc.addError('Please populate Industry filed!..');
        }
      }

      //Trigger.Before && Trigger.Update
      if (accountTriggerOldMap != null) {
        if (eachAcc.Name != accountTriggerNewMap.get(eachAcc.id).Name) {
          if (
            eachAcc.Industry != null &&
            eachAcc.CustomerPriority__c == 'High'
          ) {
            condition = true;
          } else {
            eachAcc.addError('Please populate Industry field!..');
          }
        }
      }

      if (condition) {
        eachAcc.VIP__c = true;
        eachAcc.Active__c = 'Yes';
        eachAcc.Ownership = 'Private';
      }
    }
  }

  public static void insertRecordToRelatedObjectOnAccount(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    for (Account eachAcc : accountTriggerNew) {
      Opportunity obj1 = new Opportunity();
      obj1.AccountId = eachAcc.id;
      obj1.Name = 'New Tecnology Opp';
      obj1.CloseDate = Date.newInstance(2022, 9, 20);
      obj1.StageName = 'Prospecting';
      obj1.Is_Eligible_for_Extended_Support__c = 'Yes';

      Opportunity obj2 = new Opportunity();
      obj2.AccountId = eachAcc.id;
      obj2.Name = 'New Tecnology Opp';
      obj2.CloseDate = Date.newInstance(2022, 9, 25);
      obj2.StageName = 'Needs Analysis';
      obj2.Is_Eligible_for_Extended_Support__c = 'Yes';

      List<Opportunity> listOpp = new List<Opportunity>{ obj1, obj2 };

      if (!listOpp.isEmpty()) {
        insert listOpp;
      }
    }
  }

  public static void updateRecordToRelatedObjectOnAccount(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    Set<Id> setAccountIDs = new Set<Id>();

    for (Account eachAcc : accountTriggerNew) {
      if (eachAcc.Industry == 'Technology') {
        setAccountIDs.add(eachAcc.id);
      }
    }
    // List<Opportunity> listOppReturned = [
    //   SELECT
    //     id,
    //     name,
    //     Upsell_Opportunity__c,
    //     LeadSource,
    //     Account.Id,
    //     Account.Name,
    //     Account.UpsellOpportunity__c
    //   FROM Opportunity
    //   WHERE Account.id IN :setAccountIDs
    // ];

    // List<Opportunity> listOppUpdate = new List<Opportunity>();

    // for (Account eachAccount : accountTriggerNew) {
    //   for (Opportunity eachOpp : listOppReturned) {
    //     if (eachOpp.LeadSource != null) {
    //       String oppUpsellOpp = accountTriggerNewMap.get(eachOpp.Account.Id)
    //         .UpsellOpportunity__c;

    //       eachOpp.Upsell_Opportunity__c = oppUpsellOpp;
    //     }
    //   }
    // }
    if (!setAccountIDs.isEmpty()) {
      //  update listOppReturned;

      updateRelatedObjectRecordFieldViaFutureMethod(setAccountIDs);
    }
  }

  //@future
  public static void updateRelatedObjectRecordFieldViaFutureMethod(
    Set<Id> setOppIDs
  ) {
    List<Opportunity> listOpp = [
      SELECT id, Renewal_Date__c, TrackingNumber__c, Description, Account.id
      FROM Opportunity
      WHERE Account.id IN :setOppIDs
    ];
    List<Opportunity> listOppUpdate = new List<Opportunity>();
    for (Opportunity eachOpp : listOpp) {
      eachOpp.Description = 'This is a fresh opp.';
      eachOpp.TrackingNumber__c = 'AZ1232FR2';
      eachOpp.Renewal_Date__c = Date.newInstance(2022, 5, 23);

      listOppUpdate.add(eachOpp);
    }

    update listOppUpdate;
  }
}