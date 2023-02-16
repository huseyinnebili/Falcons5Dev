public with sharing class DealershipTriggerHandler {
  public static void updateDealershipReviewsField(
    List<Dealership__c> dealerTriggerNew,
    List<Dealership__c> dealerTriggerOld,
    Map<Id, Dealership__c> dealerTriggerOldMap,
    Map<Id, Dealership__c> dealerTriggerNewMap
  ) {
    boolean condition = false;

    for (Dealership__c eachDealer : dealerTriggerNew) {
      //insert record via Trigger.isBefore && Trigger.isInsert
      if (dealerTriggerOldMap == null && eachDealer.Delearship_Name__c != null)
        if (eachDealer.Dealership_Agent_Name__c != null) {
          condition = true;
        } else {
          eachDealer.Dealership_Agent_Name__c.addError(
            'Dealership_Agent_Name__c cannot be emptyyyy!...'
          );
        }

      //insert record via Trigger.isBefore && Trigger.isUpdate
      if (dealerTriggerOldMap != null) {
        if (
          eachDealer.Delearship_Name__c !=
          dealerTriggerOldMap.get(eachDealer.id).Delearship_Name__c
        ) {
          if (eachDealer.Dealership_Agent_Name__c != null) {
            condition = true;
          } else {
            eachDealer.Dealership_Agent_Name__c.addError(
              'Dealership_Agent_Name__c cannot be emptyyyy!...'
            );
          }
        }
      }
      if (condition) {
        eachDealer.Dealership_Reviews__c = 'Wonderful experience! Salesman Polanco was very helpful and reliable throughout the whole process. Would definitely recommend.';
      }
    }
  }

  public static void insertRelatedRecord(
    List<Dealership__c> dealerTriggerNew,
    List<Dealership__c> dealerTriggerOld,
    Map<Id, Dealership__c> dealerTriggerOldMap,
    Map<Id, Dealership__c> dealerTriggerNewMap
  ) {
    List<Customer_of_Dealership__c> listDCustomer = new List<Customer_of_Dealership__c>();
    for (Dealership__c eachDealer : dealerTriggerNew) {
      Customer_of_Dealership__c cd1 = new Customer_of_Dealership__c();
      cd1.Customer_Name__c = 'Wayne';
      cd1.Inventory_for_the_Customer__c = 'Toyota Certified Program Vehicles';
      cd1.Current_Inventory__c = 'New Toyota RAV4';
      cd1.Customer_Phone__c = '2102312313';
      cd1.VIN__c = 'WP0AD2A92HS167783';

      cd1.Dealership__c = eachDealer.id;

      Customer_of_Dealership__c cd2 = new Customer_of_Dealership__c();
      cd2.Customer_Name__c = 'Danielle';
      cd2.Inventory_for_the_Customer__c = 'Cars';
      cd2.Current_Inventory__c = 'New Toyota Corolla';
      cd2.Customer_Phone__c = '2102312313';
      cd2.Dealership__c = eachDealer.id;
      cd2.VIN__c = 'WP0AD2A92HS167124';

      listDCustomer.add(cd1);
      listDCustomer.add(cd2);
    }

    if (!listDCustomer.isEmpty()) {
      insert listDCustomer;
    }
  }

  public static void insertRelatedRecordDidtheCustomerBuyAVehicleField(
    List<Dealership__c> dealerTriggerNew,
    List<Dealership__c> dealerTriggerOld,
    Map<Id, Dealership__c> dealerTriggerOldMap,
    Map<Id, Dealership__c> dealerTriggerNewMap
  ) {
    Set<Id> setDealerIDs = new Set<Id>();
    for (Dealership__c eachDealer : dealerTriggerNew) {
      setDealerIDs.add(eachDealer.id);
    }

    list<Customer_of_Dealership__c> listCD = [
      SELECT
        id,
        name,
        Did_the_Customer_Buy_A_Vehicle__c,
        Dealership__r.id,
        Dealership__r.Dealership_Reviews__c,
        Dealership__r.Dealership_Agent_Name__c
      FROM Customer_of_Dealership__c
      WHERE Dealership__r.id IN :setDealerIDs
    ];

    for (Dealership__c eachDealership : dealerTriggerNew) {
      for (Customer_of_Dealership__c eachCustomer : listCD) {
        if (eachCustomer.Did_the_Customer_Buy_A_Vehicle__c != 'False') {
          String customerReview = dealerTriggerNewMap.get(
              eachCustomer.Dealership__r.id
            )
            .Dealership_Reviews__c;

          eachCustomer.Customer_Review__c = customerReview;

          String customerAgentName = dealerTriggerNewMap.get(
              eachCustomer.Dealership__r.id
            )
            .Dealership_Agent_Name__c;

          eachCustomer.Agent_Name__c = customerAgentName;
        } else {
          eachDealership.addError(
            'Did_the_Customer_Buy_A_Vehicle__c cannot be empty!...'
          );
        }
      }
    }

    update listCD;
  }

  public static void updateDealershipReviewsFieldWithFutureMethod(
    List<Dealership__c> dealerTriggerNew,
    List<Dealership__c> dealerTriggerOld,
    Map<Id, Dealership__c> dealerTriggerOldMap,
    Map<Id, Dealership__c> dealerTriggerNewMap
  ) {
    Set<Id> setDealerIDs = new Set<id>();
    for (Dealership__c eachDeal : dealerTriggerNew) {
      if (
        eachDeal.Delearship_Name__c !=
        dealerTriggerOldMap.get(eachDeal.id).Delearship_Name__c
      ) {
        setDealerIDs.add(eachDeal.id);
      }
    }
    if (!setDealerIDs.isEmpty()) {
      updateDealershipReviewsFieldFutureMethod(setDealerIDs);
    }
  }

  @future
  public static void updateDealershipReviewsFieldFutureMethod(
    Set<id> setDealerIDs
  ) {
    list<Customer_of_Dealership__c> listCustomerDeal = [
      SELECT
        id,
        name,
        Did_the_Customer_Buy_A_Vehicle__c,
        Dealership__r.id,
        Dealership__r.Dealership_Reviews__c,
        Dealership__r.Dealership_Agent_Name__c
      FROM Customer_of_Dealership__c
      WHERE Dealership__r.id IN :setDealerIDs
    ];

    for (Customer_of_Dealership__c eachCustomerDeal : listCustomerDeal) {
      eachCustomerDeal.Stock_Number__c = '12AB2234';
      eachCustomerDeal.Did_the_Customer_Buy_A_Vehicle__c = 'True';
    }

    update listCustomerDeal;
  }

  @future
  public static void updateDealerInfo(Set<Id> setCustomerDealerIDs) {
    list<Customer_of_Dealership__c> listCustomDealerNew = [
      SELECT
        id,
        name,
        Inventory_for_the_Customer__c,
        Dealership__r.id,
        Current_Inventory__c,
        Stock_Number_of_The_Vehicles__c,
        Manufacturer_Suggested_Retail_Price__c
      FROM Customer_of_Dealership__c
      WHERE Dealership__r.id IN :setCustomerDealerIDs
    ];

    for (Customer_of_Dealership__c eachCus : listCustomDealerNew) {
      eachCus.Current_Inventory__c = 'New Toyota Corolla';
      eachCus.Inventory_for_the_Customer__c = 'Cars';
      eachCus.Stock_Number_of_The_Vehicles__c = '56';
      eachCus.Manufacturer_Suggested_Retail_Price__c = '$29,628';
    }

    update listCustomDealerNew;
  }
}