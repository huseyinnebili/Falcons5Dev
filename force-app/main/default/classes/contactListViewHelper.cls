public with sharing class contactListViewHelper {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts() {
    return [
      SELECT
        id,
        firstName,
        Status__c,
        lastName,
        accountId,
        account.name,
        mailingStreet,
        mailingCity,
        mailingState,
        mailingCountry,
        email,
        phone
      FROM Contact
      LIMIT 1000
    ];
  }

  @AuraEnabled
  public static string updateContacts(Object contactData) {
    system.debug('contatc data :' + contactData);
    List<Contact> contactList = (List<Contact>) JSON.deserialize(
      JSON.serialize(contactData),
      List<Contact>.class
    );

    System.debug('contactList:' + contactList);

    if (!contactList.isEmpty()) {
      update contactList;
      return 'Success';
    }
    return 'failed';
  }

  @AuraEnabled(Cacheable=true)
  public static List<Account> getAccounts() {
    List<Account> accList = [
      SELECT
        Id,
        Name,
        Phone,
        Industry,
        Type,
        Website,
        Description,
        Continent__c,
        Countries__c,
        Employee_Shift__c,
        SLAExpirationDate__c
      FROM Account
      WHERE Phone != NULL AND Industry != NULL
      ORDER BY CreatedDate DESC
    ];

    return accList;
  }
}