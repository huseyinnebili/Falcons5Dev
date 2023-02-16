public with sharing class CustomMetaDataHelper {
  public static String getEndpoint(String methodName) {
    Integration_Info__mdt record = Integration_Info__mdt.getInstance(
      methodName
    );

    return record.URL__c;
  }
}