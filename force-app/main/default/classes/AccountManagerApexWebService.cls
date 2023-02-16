@RestResource(urlMapping='/Account/*')
global class AccountManagerApexWebService {
  @HttpGet
  global static Account getAccount() {
    RestRequest request = RestContext.request;
    String url = request.requestURI;
    Integer lastIndex = url.lastIndexOf('/');
    String accountId = url.substring(lastIndex + 1);

    List<Account> listAcc = [
      SELECT id, name, AnnualRevenue, CleanStatus, Industry, Type
      FROM Account
      WHERE id = '0018V00002PA3KMQA1'
    ];

    if (!listAcc.isEmpty()) {
      return listAcc[0];
    } else {
      throw new CustomException(
        'Invalid case id.Please send a valid case id in order to get information.'
      );
    }
  }

  @HttpPost
  global static Id postAccount(
    String name,
    String rating,
    String industry,
    String type
  ) {
    Account acc = new Account();

    acc.Name = name;
    acc.Rating = rating;
    acc.Industry = industry;
    acc.Type = type;
    acc.Website = 'www.account.com';

    insert acc;

    return acc.Id;
  }

  @HttpDelete
  global static String deleteAccount() {
    RestRequest req = RestContext.request;
    String url = req.requestURI;
    String accountId = url.substring(url.length() - 18);

    List<Account> accounts = [SELECT id FROM Account WHERE id = :accountId];

    if (!accounts.isEmpty()) {
      delete accounts;
      return 'The case has been deleted successfully';
    } else {
      throw new CustomException(
        'Could not find any cases with the supplied case id'
      );
    }
  }

  @HttpPut
  global static Account putAccount() {
    RestRequest req = RestContext.request;
    String jsonString = req.requestBody.toString();
    Account acc = (Account) JSON.deserialize(jsonString, Account.class);
    upsert acc;

    List<Account> listAcc = [
      SELECT id, name, AnnualRevenue, Rating, Industry, Type
      FROM Account
      WHERE id = :acc.id
    ];

    return listAcc[0];
  }
  @HttpPatch
  global static Account patchAccount() {
    RestRequest request = RestContext.request;
    String jsonString = request.requestBody.toString();
    Map<String, Object> accountInfo = (Map<String, Object>) JSON.deserializeUntyped(
      jsonString
    );

    Account acc = new Account();
    for (String key : accountInfo.keySet()) {
      acc.put(key, accountInfo.get(key));
    }
    update acc;

    List<Account> listAcc = [
      SELECT id, name, AnnualRevenue, Rating, Industry, Type
      FROM Account
      WHERE id = :acc.id
    ];

    return listAcc[0];
  }
}