public class SoqlDemo {
  public static void accountSOQL_1() {
    List<Account> listAcc = [SELECT ID, NAME FROM ACCOUNT WHERE NAME LIKE 'U%'];
    System.debug('account list = ' + listAcc);

    List<Account> listAccTwo = [
      SELECT ID, NAME, PHONE
      FROM ACCOUNT
      WHERE (PHONE != NULL OR WEBSITE != NULL) AND AccountNumber != NULL
    ];

    System.debug('acc = ' + listAccTwo);
    System.debug(listAccTwo.size());

    Account acc = [
      SELECT ID, NAME
      FROM ACCOUNT
      ORDER BY createdDate DESC
      LIMIT 1
    ];
    System.debug('The latest created account is ' + acc);
  }

  public static void accountSOQL_2() {
    Account acc = [
      SELECT id, name, phone, AccountNumber
      FROM Account
      ORDER BY CreatedDate DESC
      LIMIT 1
    ];

    System.debug('the latest account created is ' + acc);

    String accName = acc.Name;
    String accPhone = acc.Phone;

    System.debug('accName = ' + accName + ',and phone is ' + accPhone);
    System.debug('account number is ' + acc.AccountNumber);
  }

  public static void contactSOQL_1() {
    List<Contact> listsContact = [
      SELECT Name, AssistantPhone, Email, Languages__c
      FROM CONTACT
      WHERE Name != NULL
    ];
    System.debug('listContact = ' + listsContact);
    System.debug('size of listContact = ' + listsContact.size());

    for (Contact listContact : listsContact) {
      System.debug(' listContact = ' + listContact);

      String contatcName = listContact.name;
      String assistantPhone = listContact.AssistantPhone;

      System.debug('contatcName = ' + contatcName);
      System.debug('assistantPhone = ' + assistantPhone);
    }

    Contact contacts = [
      SELECT Name, AssistantPhone, Email, Languages__c, Title
      FROM CONTACT
      WHERE Name != NULL
      ORDER BY Title
      LIMIT 1
    ];

    System.debug('The latest contact = ' + contacts);

    String contactsName = contacts.Name;
    String contactsAssPhone = contacts.AssistantPhone;
    String contactsLanguage = contacts.Languages__c;

    System.debug('contactsName = ' + contactsName);
    System.debug('contactsAssPhone = ' + contactsAssPhone);
    System.debug('contactsLanguage = ' + contactsLanguage);
  }

  public static void casesSOQL() {
    List<Case> listOfCases = [
      SELECT ContactId, ContactEmail, CaseNumber, Status, Priority, Subject
      FROM Case
      WHERE Subject != NULL
      ORDER BY Priority DESC
    ];

    integer listOfCasesSize = listOfCases.size();

    System.debug('listOfCasesSize =' + listOfCasesSize);

    for (Case listOfCase : listOfCases) {
      System.debug('list of case = ' + listOfCase);

      String listOfCaseOfcontactName = listOfCase.ContactId;
      String listOfCaseOfEmail = listOfCase.ContactEmail;

      System.debug('listOfCaseOfcontactName = ' + listOfCaseOfcontactName);
      System.debug('listOfCaseOfEmail = ' + listOfCaseOfEmail);
    }

    Case lastCase = [
      SELECT ContactId, ContactEmail, CaseNumber, Status, Priority, Subject
      FROM Case
      WHERE Subject != NULL
      ORDER BY Priority DESC
      LIMIT 1
    ];

    System.debug('the last case = ' + lastCase);
  }

  public static void soqlDemoFilter() {
    String caseStatus = 'closed';
    List<Case> listOfCases = [
      SELECT ContactId, ContactEmail, CaseNumber, Status, Priority, Subject
      FROM Case
      WHERE Subject != NULL AND status = :CaseStatus
      ORDER BY Priority DESC
    ];

    for (Case listOfCase : listOfCases) {
      System.debug('listOfCase = ' + listOfCase);
    }
  }

  public static void soqlDemoFilter(String caseStatus) {
    List<Case> listOfCases = [
      SELECT ContactId, ContactEmail, CaseNumber, Status, Priority, Subject
      FROM Case
      WHERE Subject != NULL AND status = :CaseStatus
      ORDER BY Priority DESC
    ];

    for (Case listOfCase : listOfCases) {
      System.debug('listOfCase = ' + listOfCase);
    }
  }
}