public with sharing class StartAndStopTestOnContatcObject {
  public static void testData() {
    List<Contact> listContReturned = [
      SELECT id, name, account.name, account.industry
      FROM contact
    ];

    for (Contact eachCont : listContReturned) {
      String accountName = eachCont.account.name;
      System.debug(
        'contact name : ' +
        eachCont.name +
        ' ,and its acc : ' +
        accountName +
        '!...'
      );
    }
  }
}