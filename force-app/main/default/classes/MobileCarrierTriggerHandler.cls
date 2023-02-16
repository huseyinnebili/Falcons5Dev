public with sharing class MobileCarrierTriggerHandler {
  public static void updateField(
    List<Mobile_Carrier__c> mobileTriggerNew,
    List<Mobile_Carrier__c> mobileTriggerOld,
    Map<Id, Mobile_Carrier__c> mobileTriggerNewMap,
    Map<Id, Mobile_Carrier__c> mobileTriggerOldMap
  ) {
    for (Mobile_Carrier__c eachMobile : mobileTriggerNew) {
      boolean condition = false;

      if (
        mobileTriggerOldMap == null &&
        eachMobile.Service_Name__c == 'T-Mobile'
      ) {
        if (eachMobile.Country__c != null) {
          condition = true;
        } else {
          eachMobile.Country__c.addError(
            'Country field cannot be kept empty!...'
          );
        }
      }

      if (mobileTriggerOld != null) {
        if (
          eachMobile.Service_Name__c == 'T-Mobile' &&
          mobileTriggerOldMap.get(eachMobile.id).Service_Name__c !=
          mobileTriggerNewMap.get(eachMobile.id).Service_Name__c
        ) {
          if (eachMobile.Country__c != null) {
            condition = true;
          } else {
            eachMobile.Country__c.addError(
              'Country field cannot be kept empty!...'
            );
          }
        }
      }

      if (condition) {
        eachMobile.Carrier_Plans_Provided__c = '5 GB internet;Fun games across all Apple devices;TravelPass';
        eachMobile.Service_Fee__c = 49.99;
        eachMobile.Provider_Companies__c = 'T-Mobile';
      }
    }
  }

  public static void createRelatedRecordOnMobileCarrierRecord(
    List<Mobile_Carrier__c> mobileTriggerNew
  ) {
    List<Mobile_Carier_Customer__c> listOfCustomer = new List<Mobile_Carier_Customer__c>();

    for (Mobile_Carrier__c eachMobile : mobileTriggerNew) {
      Mobile_Carier_Customer__c obj = new Mobile_Carier_Customer__c();

      obj.Provider_Companies__c = 'Mint';
      obj.Customer_Name__c = 'David';
      obj.Service_Country__c = 'UK';
      obj.Plan_Starting_Date__c = Date.today();
      obj.Mobile_Carrier__c = eachMobile.id;

      listOfCustomer.add(obj);
    }

    if (!listOfCustomer.isEmpty()) {
      insert listOfCustomer;
    }
  }

  public static void updateRelatedRecords(
    List<Mobile_Carrier__c> mobileTriggerNew,
    List<Mobile_Carrier__c> mobileTriggerOld,
    Map<Id, Mobile_Carrier__c> mobileTriggerNewMap,
    Map<Id, Mobile_Carrier__c> mobileTriggerOldMap
  ) {
    Set<Id> setMobileIDs = new Set<Id>();

    for (Mobile_Carrier__c eachMobile : mobileTriggerNew) {
      if (
        mobileTriggerOldMap.get(eachMobile.id).Country__c !=
        eachMobile.Country__c
      ) {
        setMobileIDs.add(eachMobile.id);
      }
    }

    List<Mobile_Carier_Customer__c> listCustomer = [
      SELECT id, name, Mobile_Carrier__r.id
      FROM Mobile_Carier_Customer__c
      WHERE Mobile_Carrier__r.id IN :setMobileIDs
    ];

    for (Mobile_Carier_Customer__c eachCustomer : listCustomer) {
      String customerServiceCountry = mobileTriggerNewMap.get(
          eachCustomer.Mobile_Carrier__r.id
        )
        .Country__c;

      eachCustomer.Service_Country__c = customerServiceCountry;
    }

    update listCustomer;
  }
}