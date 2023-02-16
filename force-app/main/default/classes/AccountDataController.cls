public class AccountDataController {
  @AuraEnabled(cacheable=true)
  public static List<Account> fetchAccounts() {
    return [
      SELECT
        Id,
        Name,
        Type,
        Phone,
        Industry,
        Continent__c,
        Countries__c,
        Description
      FROM Account
      WHERE Phone != NULL AND Industry != NULL
      ORDER BY CreatedDate DESC
    ];
  }
}