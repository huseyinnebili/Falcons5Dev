@RestResource(urlMapping='/Opportunity/*')
global class OpportunityManagerApexWebService {
  @HttpGet
  global static Opportunity getOpportunity() {
    RestRequest request = RestContext.request;
    String url = request.requestURI;
    Integer lastIndex = url.lastIndexOf('/');
    String oppId = url.substring(lastIndex + 1);

    List<Opportunity> listOpp = [
      SELECT id, Name, StageName, Type, LeadSource
      FROM Opportunity
      WHERE id = :oppId
    ];

    if (!listOpp.isEmpty()) {
      return listOpp[0];
    } else {
      throw new CustomException(
        'Invalid case id.Please send a valid case id in order to get information.'
      );
    }
  }

  @HttpPost
  global static Id postOpp(
    String name,
    String type,
    String leadSource,
    String stageName,
    Date closeDate
  ) {
    Opportunity opp = new Opportunity();

    opp.Name = name;
    opp.CloseDate = closeDate;
    opp.Type = type;
    opp.StageName = stageName;
    opp.LeadSource = leadSource;

    insert opp;

    return opp.Id;
  }

  @HttpPut
  global static Opportunity putOpportunity() {
    RestRequest request = RestContext.request;
    String jsonToString = request.requestBody.toString();
    Opportunity opp = (Opportunity) JSON.deserialize(
      jsonToString,
      Opportunity.class
    );
    upsert opp;

    List<Opportunity> listOpp = [
      SELECT id, Name, StageName, Type, LeadSource
      FROM Opportunity
      WHERE id = :opp.Id
    ];

    return listOpp[0];
  }

  @HttpPatch
  global static Opportunity patchOpp() {
    RestRequest request = RestContext.request;
    String jsonToString = request.requestBody.toString();

    Map<String, Object> mapOpp = (Map<String, Object>) JSON.deserializeUntyped(
      jsonToString
    );

    Opportunity opp = new Opportunity();

    for (String key : mapOpp.keySet()) {
      opp.put(key, mapOpp.get(key));
    }

    update opp;

    List<Opportunity> listOpp = [
      SELECT id, Name, StageName, Type, LeadSource
      FROM Opportunity
      WHERE id = :opp.Id
    ];

    return listOpp[0];
  }

  @HttpDelete
  global static String deleteOpp() {
    RestRequest request = RestContext.request;
    String url = request.requestURI;
    String oppId = url.substring(url.length() - 18);

    List<Opportunity> deleteList = [SELECT id FROM Opportunity];

    if (!deleteList.isEmpty()) {
      delete deleteList;
      return 'The case has been deleted successfully';
    } else {
      throw new CustomException(
        'Could not find any cases with the supplied case id'
      );
    }
  }
}