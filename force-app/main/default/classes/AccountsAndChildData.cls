@RestResource(urlMapping='/fetcAccountsAndChilds')
global with sharing class AccountsAndChildData {
  @HttpGet
  global static List<Account> fetchAllAccounts() {
    RestRequest reqInstance = RestContext.request;
    Map<String, String> paramMap = reqInstance.params;

    String accountType = paramMap.get('type');
    String type = paramMap.get('Type');
    String name = paramMap.get('name');

    // //Dynamic SOQL
    String accountQueryString =
      'SELECT id,name,phone,type,' +
      '(SELECT id, name, email FROM contacts),' +
      '(SELECT id, name, StageName, CloseDate FROM Opportunities)' +
      ' FROM Account';

    if (String.isNotBlank(accountType) == true) {
      accountQueryString = accountQueryString + 'WHERE Type = :type';
    }
    return Database.query(accountQueryString);
  }

  @HttpPost
  global static String createAccountAndChilds() {
    Boolean success = false;
    String message = '';

    if (RestContext.request != null) {
      String requestBody = RestContext.request.requestBody.toString();

      if (String.isNotBlank(requestBody)) {
        try {
          List<AccountWrapper> accountPayload = (List<AccountWrapper>) JSON.deserialize(
            requestBody,
            List<AccountWrapper>.class
          );
          List<Account> accountRecordList = createAccountRecords(
            accountPayload
          );
          if (accountRecordList.size() > 0) {
            insert accountRecordList;

            success = true;
            message = 'Account Request proccessed successfully';
          } else {
            success = false;
            message = 'Account Request not proccessed.V erify that the required field are provided.';
          }
        } catch (Exception e) {
          success = false;
          message =
            'Account Request not processed.Encountered Error:' + e.getMessage();
        }
      }
    }

    Response responsePayload = new Response();
    responsePayload.success = success;
    responsePayload.message = message;

    return JSON.serialize(responsePayload);
  }

  private static List<Account> createAccountRecords(
    List<AccountWrapper> accountPayload
  ) {
    List<Account> accountRecordList = new List<Account>();

    for (AccountWrapper account : accountPayload) {
      Account accountRecord = new Account();
      accountRecord.name = account.name;
      accountRecord.type = account.type;
      accountRecord.phone = account.phone;

      accountRecordList.add(accountRecord);
    }
    return accountRecordList;
  }
  global class OpportunityWrapper {
    public String name;
    public String stageName;
    public String closeDate;
  }

  global class ContactWrapper {
    public String firstname;
    public String lastname;
    public String email;
  }

  // global class AccountAndChildWrapper {
  //   public Account account;
  //   public Contact contact;
  //   public Opportunity opportunity;
  // }

  global class Response {
    global Boolean success;
    global String message;
  }

  global class AccountWrapper {
    public String name;
    public String type;
    public String phone;
    public ContactWrapper Contact;
    public OpportunityWrapper Opportunity;
  }
}