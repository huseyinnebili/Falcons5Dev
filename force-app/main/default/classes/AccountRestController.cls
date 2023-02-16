@RestResource(urlMapping='/fetchallaccounts')
global class AccountRestController {
  @HttpGet
  global static List<Account> queryAllAccounts() {
    RestRequest req = RestContext.request;
    Map<String, String> paramMap = req.params;

    String type = paramMap.get('Type');
    String name = paramMap.get('name');
    String Phone = paramMap.get('phone');

    return [SELECT id, name, phone, type FROM account WHERE Type = :Type];
  }

  global static void createAccount(
    String accountName,
    String accountType,
    String accountDescription
  ) {
    Account acc = new Account();
    acc.Name = accountName;
    acc.Type = accountType;
    acc.Description = accountDescription;

    insert acc;
  }
}