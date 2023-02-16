trigger EmployeeDepartmentTrigger on Employee_Department__c(
  before insert,
  after insert,
  before update,
  after update
) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    EmployeeDepartmentTriggerHandler.updateThe_Amount_Of_Year_Employee_Work_Field(
      Trigger.new,
      Trigger.old,
      Trigger.newMap,
      Trigger.oldMap
    );
  }
}