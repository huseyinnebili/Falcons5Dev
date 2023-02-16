public with sharing class EmployeeDepartmentBatch implements Database.Batchable<SObject>, Database.stateful {
  public integer count = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [
        SELECT id, name, Department_Closing_Hour__c, Weekly_Max_Hour__c
        FROM Employee_Department__c
        LIMIT 200
      ]
    );

    return ql;
  }

  public void execute(
    Database.BatchableContext bc,
    list<Employee_Department__c> scope
  ) {
    List<Employee_Department__c> listEmpDepartment = new List<Employee_Department__c>();

    for (Employee_Department__c eachEmpDep : scope) {
      eachEmpDep.Department_Closing_Hour__c = Time.newInstance(19, 45, 0, 0);
      listEmpDepartment.add(eachEmpDep);

      count++;
    }

    if (!listEmpDepartment.isEmpty()) {
      update listEmpDepartment;
    }
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('Update done!...');
    System.debug('The number of the record updated = ' + count);
  }
}