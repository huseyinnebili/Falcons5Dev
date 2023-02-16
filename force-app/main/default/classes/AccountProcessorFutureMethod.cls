public class AccountProcessorFutureMethod {
  @future
  public static void countContacts(Set<id> setId) {
    List<Account> lstAccount = [
      SELECT id, Number_of_Contacts__c, (SELECT id FROM contacts)
      FROM account
      WHERE id IN :setId
    ];

    List<Account> updateToAccount = new List<Account>();

    for (Account acc : lstAccount) {
      acc.Number_of_Contacts__c = acc.Contacts.size();

      updateToAccount.add(acc);
    }
    update updateToAccount;
  }
}