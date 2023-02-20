public class QueryExample {
  public void writewQuery() {
    //  Write a SOQL to retrieve an Account and all Opportunities related to it where Contact Email is 'ABC@talech.com'

    Account acc = [
      SELECT Id, Name
      FROM Account
      WHERE Id IN (SELECT AccountId FROM Contact WHERE Email = 'ABC@talech.com')
      LIMIT 1
    ];

    System.debug(acc);
  }
}