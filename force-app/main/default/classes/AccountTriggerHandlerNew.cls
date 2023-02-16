public with sharing class AccountTriggerHandlerNew {
  public static void updateField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap
  ) {
    boolean condition = false;

    //insert record via Trigger.isBefore && Trigger.isInsert
    for (Account eachAccount : accountTriggerNew) {
      if (accountTriggerOldMap == null && eachAccount.Active__c == 'Yes') {
        if (eachAccount.Industry != null) {
          condition = true;
        } else {
          eachAccount.addError('Industry cannot be empty!...');
        }
      }

      //update field via Trigger.isBefore && Trigger.isUpdate
      if (accountTriggerOldMap != null) {
        if (
          eachAccount.Name != accountTriggerOldMap.get(eachAccount.id).Name &&
          eachAccount.Active__c == 'Yes'
        ) {
          if (eachAccount.Industry != null) {
            condition = true;
          } else {
            eachAccount.addError('Industry cannot be empty!...');
          }
        }
      }

      if (condition) {
        eachAccount.Type = 'Customer - Direct';
        eachAccount.AccountSource = 'Web';
        eachAccount.CustomerPriority__c = 'High';
        eachAccount.Rating = 'Hot';
      }
    }
  }

  //insert record to related obj via Trigger.isAfter && Trigger.isInsert
  public static void insertRecordToContact(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap
  ) {
    List<Contact> listCont = new List<Contact>();
    for (Account eachAcc : accountTriggerNew) {
      Contact cont = new Contact();

      cont.LastName = 'Kayla';
      cont.AssistantName = 'Ralph';
      cont.Languages__c = 'English';
      cont.LeadSource = 'Web';
      cont.Phone = '2134432121';
      cont.AccountId = eachAcc.id;

      Contact cont1 = new Contact();

      cont1.LastName = 'McMain';
      cont1.AssistantName = 'Adriana';
      cont1.Languages__c = 'English';
      cont1.LeadSource = 'Web';
      cont1.Phone = '2134432112';
      cont1.AccountId = eachAcc.id;

      listCont.add(cont);
      listCont.add(cont1);
    }

    insert listCont;
  }

  //update field in related obj via Trigger.isAfter && Trigger.isUpdate
  public static void updateRelatedObjectField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap
  ) {
    Set<Id> setAccIDs = new Set<Id>();
    for (Account eachAcc : accountTriggerNew) {
      if (accountTriggerOldMap != null) {
        setAccIDs.add(eachAcc.id);
      }
    }

    list<Contact> listCont = [
      SELECT id, name, Account.id, LeadSource, Phone
      FROM Contact
      WHERE Account.id IN :setAccIDs
    ];

    for (Account eachAcc : accountTriggerNew) {
      for (Contact eachCont : listCont) {
        if (eachCont.Phone != null) {
          boolean contactVip = accountTriggerNewMap.get(eachCont.Account.id)
            .VIP__c;

          eachCont.VIP__c = contactVip;
        } else {
          eachAcc.addError(
            'You should complete related record saving first!...'
          );
        }
      }
    }

    update listCont;
  }

  @future
  public static void updateDescription(set<Id> setAccountIDs) {
    list<Account> listAcc = [
      SELECT id, name, Description
      FROM account
      WHERE id IN :setAccountIDs
    ];

    for (Account eachAcc : listAcc) {
      eachAcc.Description = 'It is a big company.';
    }

    update listAcc;
  }
  public static void updateDescriptionOnContact(
    List<account> accTriggerNew,
    List<Account> accTriggerOld,
    Map<Id, Account> accTriggerOldMap,
    Map<id, Account> accTriggerNewMap
  ) {
    Set<Id> setAccIDs = new Set<id>();

    for (Account eachAcc : accTriggerNew) {
      if (
        eachAcc.Description != null &&
        accTriggerOldMap.get(eachAcc.id).Description == null
      ) {
        setAccIDs.add(eachAcc.id);
      }
    }

    // if (!setAccIDs.isEmpty()) {
    if (System.IsBatch() == false && System.isFuture() == false) {
      updateDescriptionOnContactFutureMethod(setAccIDs);
    }
  }

  @future
  public static void updateDescriptionOnContactFutureMethod(Set<id> setAccIDs) {
    list<Contact> listContact = [
      SELECT id, name, Description, Account.id
      FROM contact
      WHERE Account.id IN :setAccIDs
    ];

    for (Contact eachContact : listContact) {
      eachContact.Description = 'The contact was found via web.';
    }

    update listContact;
  }
}