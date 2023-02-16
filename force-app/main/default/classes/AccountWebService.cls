@RestResource(urlMapping='/accountwebservice')
global with sharing class AccountWebService {
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
  global static String createAccount() {
    Boolean success = false;
    String message = '';

    if (RestContext.request != null) {
      String requestBody = RestContext.request.requestBody.toString();

      if (String.isNotBlank(requestBody)) {
        try {
          List<AccountJSONWrapper.Account> accountPayload = (List<AccountJSONWrapper.Account>) JSON.deserialize(
            requestBody,
            List<AccountJSONWrapper.Account>.class
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
    AccountJSONWrapper.Response responsePayload = new AccountJSONWrapper.Response();
    responsePayload.success = success;
    responsePayload.message = message;

    return JSON.serialize(responsePayload);
  }

  private static List<Account> createAccountRecords(
    List<AccountJSONWrapper.Account> accountPayload
  ) {
    List<Account> accountRecordList = new List<Account>();

    for (AccountJSONWrapper.Account account : accountPayload) {
      Account accountRecord = new Account();
      accountRecord.name = account.name;
      accountRecord.type = account.type;
      accountRecord.phone = account.phone;

      accountRecordList.add(accountRecord);
    }
    return accountRecordList;
  }
}