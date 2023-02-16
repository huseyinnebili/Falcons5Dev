@RestResource(urlMapping='/Case/*')
global class CaseManagerRestService {
  @HttpGet
  global static Case getCase() {
    RestRequest request = RestContext.request;
    String url = request.requestURI;
    // String caseId = url.split('/')[url.split('/').size() - 1];
    Integer lastIndex = url.lastIndexOf('/');
    String caseId = url.subString(lastIndex + 1);
    List<Case> listCase = [
      SELECT id, CaseNumber, Status, Priority, Origin
      FROM Case
      WHERE id = :caseId
    ];

    if (!listCase.isEmpty()) {
      return listCase[0];
    } else {
      throw new CustomException(
        'Invalid case id.Please send a valid case id in order to get information.'
      );
    }
  }

  @HttpPost
  global static Id postCase(String subject, String description, String origin) {
    Case cs = new Case();

    cs.Subject = subject;
    cs.Description = description;
    cs.Origin = origin;
    cs.Priority = 'Medium';
    cs.Status = 'New';

    insert cs;

    return cs.Id;
  }

  @HttpDelete
  global static String deleteCase() {
    RestRequest req = RestContext.request;
    String url = req.requestURI;
    String caseId = url.substring(url.length() - 18);
    List<Case> cases = [SELECT id FROM Case WHERE id = :caseId];
    if (!cases.isEmpty()) {
      delete cases;
      return 'The case has been deleted successfully';
    } else {
      throw new CustomException(
        'Could not find any cases with the supplied case id'
      );
    }
  }
  @HttpPut
  global static Case putCase() {
    RestRequest req = RestContext.request;
    String jsonToString = req.requestBody.toString();
    Case cs = (Case) JSON.deserialize(jsonToString, Case.class);
    upsert cs;

    List<Case> cases = [
      SELECT id, CaseNumber, Subject, Priority
      FROM Case
      WHERE id = :cs.id
    ];

    return cases[0];
  }

  @HttpPatch
  global static Case patchCase() {
    RestRequest req = RestContext.request;
    String jsonToString = req.requestBody.toString();
    Map<String, Object> caseInfo = (Map<String, Object>) JSON.deserializeUntyped(
      jsonToString
    );
    Case cs = new Case();
    for (String key : caseInfo.keySet()) {
      cs.put(key, caseInfo.get(key));
    }

    update cs;

    List<Case> cases = [
      SELECT id, CaseNumber, Subject, Priority
      FROM Case
      WHERE id = :cs.id
    ];

    return cases[0];
  }
}

//https://d8v0000027hntuai-dev-ed.lightning.force.com/services/apexrest/Case/*