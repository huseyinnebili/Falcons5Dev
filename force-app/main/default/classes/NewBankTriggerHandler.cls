public with sharing class NewBankTriggerHandler {
  public static void updateField(
    List<New_Bank__c> bankTriggerNew,
    List<New_Bank__c> bankTriggerOld,
    Map<Id, New_Bank__c> bankTriggerOldMap,
    Map<Id, New_Bank__c> bankTriggerNewMap
  ) {
    String customError = System.label.NewBankFieldUpdate;

    boolean condition = false;
    for (New_Bank__c eachBank : bankTriggerNew) {
      //insert record via Trigger.isBefore && Trigger.isInsert
      if (bankTriggerOldMap == null && eachBank.Bank_Name__c != null) {
        if (eachBank.Bank_Loan_Types__c != null) {
          condition = true;
        } else {
          eachBank.addError(customError);
        }
      }

      //insert record via Trigger.isAfter && Trigger.isUpdate
      if (bankTriggerOldMap != null) {
        if (
          eachBank.Bank_Name__c !=
          bankTriggerOldMap.get(eachBank.id).Bank_Name__c
        ) {
          if (eachBank.Bank_Loan_Types__c != null) {
            condition = true;
          } else {
            eachBank.addError(customError);
          }
        }
      }

      if (condition) {
        eachBank.Bank_APR__c = 5.25;
      }
    }
  }

  public static void insertRelatedRecord(
    List<New_Bank__c> bankTriggerNew,
    Map<Id, New_Bank__c> bankTriggerMap
  ) {
    //we fetch custom settings hierarchical data
    NewBankCustomerCustomSetting__c nccs = NewBankCustomerCustomSetting__c.getOrgDefaults();
    List<New_Bank_Customer__c> listNewBankCus = new List<New_Bank_Customer__c>();

    for (New_Bank__c eachBank : bankTriggerNew) {
      New_Bank_Customer__c obj = new New_Bank_Customer__c();
      obj.Customer_Name__c = 'Anna';
      obj.Customer_Email__c = 'anna39@gmail.com';
      obj.New_Bank__c = eachBank.id;
      obj.What_type_loan_will_you_use__c = nccs.Type_of_The_Loan__c;
      //obj.Customer_Loan_APR__c = nccs.The_APR_of_the_Loan__c;
      obj.Customer_Loan_APR__c = 4.39;

      New_Bank_Customer__c obj1 = new New_Bank_Customer__c();
      obj1.Customer_Name__c = 'Isabella';
      obj1.Customer_Email__c = 'isabella@gmail.com';
      obj1.New_Bank__c = eachBank.id;
      obj1.What_type_loan_will_you_use__c = nccs.Type_of_The_Loan__c;
      //  obj1.Customer_Loan_APR__c = nccs.The_APR_of_the_Loan__c;
      obj1.Customer_Loan_APR__c = 4.35;

      listNewBankCus.add(obj);
      listNewBankCus.add(obj1);
    }

    if (!listNewBankCus.isEmpty()) {
      insert listNewBankCus;
    }
  }

  public static void updateRelatedRecordField(
    List<New_Bank__c> bankTriggerNew,
    List<New_Bank__c> bankTriggerOld,
    Map<Id, New_Bank__c> bankTriggerOldMap,
    Map<Id, New_Bank__c> bankTriggerNewMap
  ) {
    Set<Id> setNewBankIDs = new Set<Id>();

    for (New_Bank__c eachBank : bankTriggerNew) {
      if (eachBank.Bank_Name__c != null) {
        setNewBankIDs.add(eachBank.id);
      }

      List<New_Bank_Customer__c> listNewBankCusReturned = [
        SELECT
          id,
          name,
          Customer_Loan_APR__c,
          Customer_Review__c,
          Customer_Bank_Name__c,
          New_Bank__r.id,
          New_Bank__r.Bank_Name__c
        FROM New_Bank_Customer__c
        WHERE New_Bank__r.id IN :setNewBankIDs
      ];

      for (New_Bank__c eachBankTwo : bankTriggerNew) {
        for (New_Bank_Customer__c eachBankCustomer : listNewBankCusReturned) {
          if (eachBankCustomer.Customer_Loan_APR__c != null) {
            String customerBankName = bankTriggerNewMap.get(
                eachBankCustomer.New_Bank__r.id
              )
              .Bank_Name__c;

            eachBankCustomer.Customer_Bank_Name__c = customerBankName;
          } else {
            eachBankTwo.addError('Customer_Loan_APR__c cannot be empty!..');
          }
        }
      }

      if (!listNewBankCusReturned.isEmpty()) {
        update listNewBankCusReturned;
      }
    }
  }

  @future
  public static void updateRelatedRecordFieldViaFutureMethod(
    Set<id> setNewBankCustomerIDs
  ) {
    List<New_Bank_Customer__c> listNewBankCusReturned = [
      SELECT
        id,
        name,
        Customer_Loan_APR__c,
        Customer_Review__c,
        Customer_Bank_Name__c,
        New_Bank__r.id,
        New_Bank__r.Bank_Name__c
      FROM New_Bank_Customer__c
      WHERE New_Bank__r.id IN :setNewBankCustomerIDs
    ];

    List<New_Bank_Customer__c> listUpdate = new List<New_Bank_Customer__c>();
    for (New_Bank_Customer__c eachBankCustomer : listNewBankCusReturned) {
      eachBankCustomer.Customer_Review__c = 'Very nice staffs and fast transaction.';
      listUpdate.add(eachBankCustomer);
    }

    if (!listUpdate.isEmpty()) {
      update listUpdate;
    }
  }
}