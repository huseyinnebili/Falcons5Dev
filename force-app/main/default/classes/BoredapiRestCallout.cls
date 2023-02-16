public with sharing class BoredapiRestCallout {
  public static HttpResponse getActivities() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('http://www.boredapi.com/api/activity/');
    request.setMethod('GET');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonToString = response.getBody();
      System.debug('jsonToString = ' + jsonToString);

      BoredapiWrapperClass activities = (BoredapiWrapperClass) JSON.deserialize(
        jsonToString,
        BoredapiWrapperClass.class
      );

      insertFieldReturnedFromBoredapi(activities);
    } else {
      System.debug('Some errors have occurred!..');
    }

    return response;
  }
  private static void insertFieldReturnedFromBoredapi(
    BoredapiWrapperClass activities
  ) {
    //  List<Opportunity> insertList = new List<Opportunity>();

    Opportunity opp = new Opportunity();

    opp.Participants__c = activities.participants;
    opp.Activity__c = activities.activity;
    opp.Name = 'RestCallout Opp Two';
    opp.StageName = 'Closed Won';
    opp.CloseDate = Date.today();

    // insertList.add(opp);

    insert opp;
  }
}