public with sharing class AccountTriggerHandlerTwo {
  // public static void updateField(
  //   List<Account> accountTriggerNew,
  //   List<Account> accountTriggerOld,
  //   Map<Id, Account> accountTriggerNewMap,
  //   Map<Id, Account> accountTriggerOldMap
  // ) {
  //   boolean condition = false;

  //   for (Account eachAccount : accountTriggerNew) {
  //     //insert record via Trigger.isBefore & Trigger.isInsert
  //     if (accountTriggerOldMap == null && eachAccount.Rating == 'Hot') {
  //       if (eachAccount.Type != null) {
  //         condition = true;
  //       } else {
  //         eachAccount.Type.addError('Type cannot be empty!..');
  //       }
  //     }

  //     //update record via Trigger.isBefore & Trigger.isInsert
  //     if (accountTriggerOldMap != null) {
  //       if (
  //         eachAccount.Name != accountTriggerOldMap.get(eachAccount.id).Name &&
  //         eachAccount.Rating == 'Hot'
  //       ) {
  //         if (eachAccount.Type != null) {
  //           condition = true;
  //         } else {
  //           eachAccount.Type.addError('Type cannot be empty!..');
  //         }
  //       }
  //     }

  //     if (condition) {
  //       eachAccount.SLA__c = 'Gold';
  //       eachAccount.NumberofLocations__c = 3;
  //       eachAccount.SLAExpirationDate__c = Date.newInstance(2022, 12, 29);
  //     }
  //   }
  // }

  // public static void insertRelatedRecord(
  //   List<Account> accountTriggerNew,
  //   List<Account> accountTriggerOld,
  //   Map<Id, Account> accountTriggerNewMap,
  //   Map<Id, Account> accountTriggerOldMap
  // ) {
  //   List<Contact> contactList = new List<Contact>();

  //   for (Account eachAccount : accountTriggerNew) {
  //     if (accountTriggerOldMap == null) {
  //       Contact obj1 = new Contact();
  //       obj1.LastName = 'Wilson';
  //       obj1.AccountId = eachAccount.Id;
  //       obj1.LeadSource = 'Partner Referral';
  //       obj1.Phone = '2102314365';
  //       obj1.Languages__c = 'English';
  //       obj1.Title = 'VP, Technology';

  //       Contact obj2 = new Contact();
  //       obj2.LastName = 'MARTINEZ';
  //       obj2.AccountId = eachAccount.Id;
  //       obj2.LeadSource = 'Partner Referral';
  //       obj2.Phone = '2102314375';
  //       obj2.Languages__c = 'Spanish';
  //       obj2.Title = 'Manager, Energy';

  //       contactList.add(obj1);
  //       contactList.add(obj2);
  //     }
  //   }

  //   if (!contactList.isEmpty()) {
  //     insert contactList;
  //   }
  // }

  public static void updateRelatedRecordField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    Set<Id> setAccountIDs = new Set<Id>();
    for (Account eachAccount : accountTriggerNew) {
      if (
        accountTriggerOldMap != null &&
        eachAccount.VIP__c != accountTriggerOldMap.get(eachAccount.id).VIP__c
      ) {
        setAccountIDs.add(eachAccount.Id);
      }
    }

    List<Contact> listContacts = [
      SELECT id, name, VIP__c, Account.id
      FROM Contact
      WHERE Account.id IN :setAccountIDs
    ];

    for (Contact eachContact : listContacts) {
      Boolean accountPhone = accountTriggerNewMap.get(eachContact.Account.id)
        .VIP__c;
      eachContact.VIP__c = accountPhone;
    }

    update listContacts;
  }
}