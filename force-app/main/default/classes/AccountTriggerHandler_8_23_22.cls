public with sharing class AccountTriggerHandler_8_23_22 {
  public static void updateAccountField(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap
  ) {
    boolean condition = false;
    for (Account eachAcc : accountTriggerNew) {
      if (accountTriggerOldMap == null && eachAcc.Type == 'Prospect') {
        if (eachAcc.Website != null) {
          condition = true;
        } else {
          eachAcc.addError('Website cannot be empty!...');
        }
      }

      if (accountTriggerOldMap != null) {
        if (
          eachAcc.Name != accountTriggerOldMap.get(eachAcc.id).Name &&
          eachAcc.Type == 'Prospect'
        ) {
          if (eachAcc.Website != null) {
            condition = true;
          } else {
            eachAcc.addError('Website cannot be empty!...');
          }
        }
      }

      if (condition) {
        eachAcc.SLA__c = 'Gold';
        eachAcc.CustomerPriority__c = 'High';
      }
    }
  }

  public static void insertRelatedObjectRecords(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap
  ) {
    List<Contact> insertToContact = new List<Contact>();
    for (Account eachAcc : accountTriggerNew) {
      Contact conn = new Contact();
      conn.FirstName = 'Adriana';
      conn.LastName = 'Bold';
      conn.LeadSource = 'External Referral';
      conn.Email = 'rose@gmail.com';
      conn.Level__c = 'Secondary';
      conn.Phone = '2129212123';
      conn.Status__c = 'active';
      conn.AccountId = eachAcc.id;

      Contact conn1 = new Contact();
      conn1.FirstName = 'Susan';
      conn1.LastName = 'McCain';
      conn1.LeadSource = 'External Referral';
      conn1.Email = 'susan@gmail.com';
      conn1.Level__c = 'Secondary';
      conn1.Phone = '2129212143';
      conn1.Status__c = 'inactive';
      conn1.AccountId = eachAcc.id;

      insertToContact.add(conn);
      insertToContact.add(conn1);
    }

    if (!insertToContact.isEmpty()) {
      insert insertToContact;
    }
  }
  public static void updateRelatedObjectFieldRespectToAccounts(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap
  ) {
    Set<Id> setAccountIDs = new Set<Id>();

    for (Account eachAcc : accountTriggerNew) {
      setAccountIDs.add(eachAcc.Id);
    }
    for (Account eachAccount : accountTriggerNew) {
      for (List<Contact> listContacts : [
        SELECT
          id,
          FirstName,
          Account.id,
          LastName,
          LeadSource,
          Description,
          Account.Description
        FROM Contact
        WHERE Account.id = :setAccountIDs
      ]) {
        for (Contact eachContact : listContacts) {
          if (eachContact.LeadSource != null) {
            String contactDes = accountTriggerNewMap.get(eachContact.Account.id)
              .Description;

            eachContact.Description = contactDes;
          } else {
            eachAccount.addError(
              'Please,do not keep the Lead Source field empty!...'
            );
          }
        }

        update listContacts;
      }
    }
  }
}