public with sharing class AnimalLocator {
  public static String getAnimalNameById(Integer id) {
    String animalName;

    HttpRequest req = new HttpRequest();

    req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);

    req.setMethod('GET');

    Http http = new Http();

    HttpResponse res = http.send(req);

    if (res.getStatusCode() == 200) {
      String jsonString = res.getBody();
      Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
        jsonString
      );

      Map<String, Object> animal = (Map<String, Object>) results.get('animal');

      System.debug('Received animals : ' + animal);

      animalName = (String) animal.get('name');

      System.debug(animalName);
    }
    return animalName;
  }
}