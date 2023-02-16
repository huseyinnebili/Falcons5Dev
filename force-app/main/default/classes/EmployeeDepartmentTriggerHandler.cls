public with sharing class EmployeeDepartmentTriggerHandler {
  public static void updateThe_Amount_Of_Year_Employee_Work_Field(
    List<Employee_Department__c> empTriggerNew,
    List<Employee_Department__c> empTriggerOld,
    Map<Id, Employee_Department__c> empTriggerNewMap,
    Map<Id, Employee_Department__c> empTriggerOldMap
  ) {
    Set<Id> setEmpDepIDs = new Set<Id>();

    for (Employee_Department__c eachDep : empTriggerNew) {
      if (eachDep.Department_Closing_Hour__c != null) {
        setEmpDepIDs.add(eachDep.id);
      }
    }

    List<Employee__c> listEmployee = [
      SELECT
        id,
        name,
        The_Amount_Of_Year_Employee_Work__c,
        Employee_Department__r.id,
        Employee_Department__r.Department_Closing_Hour__c,
        Employee_SSN__c
      FROM Employee__c
      WHERE Employee_Department__r.id IN :setEmpDepIDs
    ];

    for (Employee_Department__c eachDepartment : empTriggerNew) {
      for (Employee__c eachEmployee : listEmployee) {
        if (eachEmployee.Employee_SSN__c != null) {
          eachEmployee.Employee_Hourly_Salary__c = 43;
        } else {
          eachDepartment.addError('Employee_SSN__c field cannot be empty!..');
        }
      }
    }

    // if (!setEmpDepIDs.isEmpty()) {

    if (System.IsBatch() == false && System.isFuture() == false) {
      updateDepartmentClosingHourField(setEmpDepIDs);
    }
  }

  @future
  public static void updateDepartmentClosingHourField(set<id> setEmpDepIDs) {
    List<Employee__c> listEmployee = [
      SELECT
        id,
        name,
        The_Amount_Of_Year_Employee_Work__c,
        Employee_Department__r.id,
        Employee_Department__r.Department_Closing_Hour__c
      FROM Employee__c
      WHERE Employee_Department__r.id IN :setEmpDepIDs
    ];

    for (Employee__c eachEmp : listEmployee) {
      eachEmp.The_Amount_Of_Year_Employee_Work__c = 5;
      eachEmp.Course_Starting_Date__c = Date.today();
    }

    update listEmployee;
  }
}