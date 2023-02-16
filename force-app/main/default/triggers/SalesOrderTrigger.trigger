trigger SalesOrderTrigger on Sales_Order__c(
  before insert,
  after insert,
  before update,
  after update
) {
  List<Sales_Order__c> listOfNewTriggers = Trigger.new;

  System.debug('size of the trigger = ' + listOfNewTriggers.size());

  if (Trigger.isBefore && Trigger.isInsert) {
    for (Sales_Order__c listOfNewTrigger : listOfNewTriggers) {
      String customerName = listOfNewTrigger.Customer_Name__c;

      System.debug(
        'before insert trigger called customerName = ' + customerName
      );
    }
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    for (Sales_Order__c listOfNewTrigger : listOfNewTriggers) {
      String orderSource = listOfNewTrigger.Order_Source__c;

      System.debug('after insert trigger called orderSource = ' + orderSource);
    }
  }

  List<Sales_Order__c> listOfReturnedOldRecords = Trigger.old;
  if (Trigger.isBefore && Trigger.isUpdate) {
    for (Sales_Order__c listOfReturnedOldRecord : listOfReturnedOldRecords) {
      decimal oldQuantity = listOfReturnedOldRecord.Quantity__c;
      System.debug(
        'before update trigger called orginal oldQuantity = ' + oldQuantity
      );
    }

    for (Sales_Order__c listOfNewTrigger : listOfNewTriggers) {
      decimal newQuantity = listOfNewTrigger.Quantity__c;

      System.debug(
        'before update trigger called new unitePrice = ' + newQuantity
      );
    }
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    for (Sales_Order__c listOfNewTrigger : listOfNewTriggers) {
      string orderProductName = listOfNewTrigger.Sales_Order_Product_Name__c;

      System.debug(
        'after update trigger called orderProductName = ' + orderProductName
      );
    }
  }
}