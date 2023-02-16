public with sharing class RestCallout {
  private static final String GET_ANIMALS = 'getAnimalsWithAuthorization';
  private static final String HTTP_METHOD = 'GET';
  public static HttpResponse getAnimalsWithAuthorization() {
    //1.Prepare a request
    HttpRequest request = new HttpRequest();
    request.setEndpoint(CustomMetaDataHelper.getEndpoint(GET_ANIMALS));
    request.setMethod(HTTP_METHOD);

    //extra : authorization
    //Way-One : Creating authorization via hard coding
    String username = 'huseyinnebili36_ari@gmail.com';
    String password = '2112522Hn@';
    Blob requestBlob = Blob.valueOf(username + ':' + password);
    String authorizationString =
      'BASIC ' + EncodingUtil.base64Encode(requestBlob);
    request.setHeader('Authorization', authorizationString);
   //request.setBody(authorizationString);
   //request.setHeader('Content-Type', 'application/json');

    //Way-Two:Callout using Named Credentials(more secure and flexible)
    //request.setEndpoint('callout:MyWeatherAPI');

    //2.Prepare internet
    Http http = new Http();

    //3.Send the request over the internet
    HttpResponse response = http.send(request);
    // System.debug(response.getBody());

    //4.Process the response
    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();
      System.debug('jsonString = ' + jsonString);
      AnimalCalloutWrapper.Animals animalsPayLoad = (AnimalCalloutWrapper.Animals) JSON.deserialize(
        jsonString,
        AnimalCalloutWrapper.Animals.class
      );
      for (String animal : animalsPayLoad.animals) {
        System.debug(animal);
      }
      // Map<String, Object> info = (Map<String, Object>) JSON.deserializeUntyped(
      //   jsonString
      // );
      //map(key='animals' , valu=Object)

      // List<Object> animals = (List<Object>) info.get('animals');
      //   for (Object animal : animals) {
      //     system.debug('animals = ' + animal);
      //   }
      // } else {
      //   //log an error
      //   System.debug('Some error occurred!..');
      // }
    }

    return response;
  }
}