public with sharing class AccountCtrl {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    return [
      SELECT Name, Type, Industry, AnnualRevenue
      FROM Account
      WHERE AnnualRevenue != NULL
      ORDER BY AnnualRevenue DESC
      LIMIT 10
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Account> getAccountsByType(String type) {
    return [
      SELECT Name, Type, Industry, AnnualRevenue
      FROM Account
      WHERE Type LIKE :type
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Case> getCasesThroughCaseReason() {
    return [
      SELECT Id, Origin, Reason, Priority, Subject
      FROM Case
      WHERE Priority != NULL
      LIMIT 5
    ];
  }

  // @AuraEnabled(cacheable=true)
  // public static List<Contact> getContacts() {
  //   return [
  //     SELECT Name, Phone, Title, Email, Department, Birthdate
  //     FROM Contact
  //     WHERE Title != NULL
  //     ORDER BY Name DESC
  //     LIMIT 10
  //   ];
  // }

  // @AuraEnabled(cacheable=true)
  // public static List<Opportunity> getOpportunies() {
  //   return [
  //     SELECT Name, CloseDate, ExpectedRevenue, LeadSource
  //     FROM Opportunity
  //     WHERE LeadSource != NULL
  //     LIMIT 10
  //   ];
  // }

  // @AuraEnabled(cacheable=true)
  // public static List<Opportunity> getOpportuniesByStage(String StageName) {
  //   return [
  //     SELECT Name, CloseDate, ExpectedRevenue, LeadSource, StageName
  //     FROM Opportunity
  //     WHERE StageName LIKE :StageName
  //     WITH SECURITY_ENFORCED
  //     LIMIT 10
  //   ];
  // }

  //get all the accounts whose name contains the given search key
  @AuraEnabled
  public static List<Account> searchAccounts(String searchKey) {
    searchKey = '%' + searchKey + '%';
    return [
      SELECT Name, Type, Industry, AnnualRevenue, AccountNumber
      FROM Account
      WHERE Name LIKE :searchKey
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  @AuraEnabled
  public static List<Opportunity> searchOpportunity(String searchKey) {
    searchKey = '%' + searchKey + '%';

    return [
      SELECT Name, CloseDate, ExpectedRevenue, LeadSource, StageName
      FROM Opportunity
      WHERE Name LIKE :searchKey
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  // //get all opp whose matches with the given input
  // @AuraEnabled
  // public static List<Opportunity> getOpportuniesByType(String type) {
  //   return [
  //     SELECT Name, CloseDate, ExpectedRevenue, LeadSource, StageName, Type
  //     FROM Opportunity
  //     WHERE Type = :type
  //     WITH SECURITY_ENFORCED
  //     LIMIT 10
  //   ];
  // }

  // //get all the accounts whose matches with the given input
  @AuraEnabled
  public static List<Account> searchAccountsByRating(String rating) {
    // searchKey = '%' + searchKey + '%';
    return [
      SELECT Name, Type, Industry, AnnualRevenue, Rating
      FROM Account
      WHERE Rating LIKE :rating
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Case> getCasesByPriority(String priority) {
    return [
      SELECT Origin, Reason, ContactEmail, Priority, Status
      FROM Case
      WHERE Priority = :priority
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Contact> getContactByLeadSource(String leadSource) {
    return [
      SELECT LeadSource, LastName, Phone, Email, Status__c
      FROM Contact
      WHERE LeadSource = :leadSource
      WITH SECURITY_ENFORCED
      LIMIT 5
    ];
  }

  @AuraEnabled
  public static List<Contact> searchContactByLeadSource(String searchKey) {
    searchKey = '%' + searchKey + '%';
    return [
      SELECT LeadSource, LastName, Phone, Email, Status__c
      FROM Contact
      WHERE LeadSource LIKE :searchKey
      WITH SECURITY_ENFORCED
      LIMIT 5
    ];
  }

  @AuraEnabled
  public static List<Contact> searchContactByStatus(String searchKey) {
    searchKey = '%' + searchKey + '%';
    return [
      SELECT LeadSource, LastName, Phone, Email, Status__c
      FROM Contact
      WHERE Status__c LIKE :searchKey
      WITH SECURITY_ENFORCED
      LIMIT 5
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Case> searchCaseRecordsByPriority(String searchKey) {
    searchKey = '%' + searchKey + '%';
    return [
      SELECT Origin, Reason, ContactEmail, Priority, Status
      FROM Case
      WHERE Priority = :searchKey
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }
}