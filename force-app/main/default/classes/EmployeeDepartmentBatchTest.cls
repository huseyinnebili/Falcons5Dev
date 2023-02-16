@isTest
public with sharing class EmployeeDepartmentBatchTest {
  @isTest
  public static void batchTest() {
    Employee_Department__c obj1 = new Employee_Department__c();
    obj1.Department__c = 'IT Technology';
    obj1.Weekly_Max_Hour__c = 40;

    Employee_Department__c obj2 = new Employee_Department__c();
    obj2.Department__c = 'Sales';
    obj2.Weekly_Max_Hour__c = 40;

    List<Employee_Department__c> listEmpDep = new List<Employee_Department__c>{
      obj1,
      obj2
    };

    for (integer i = 0; i < 2000; i++) {
      Employee_Department__c obj = new Employee_Department__c();
      obj.Department__c = 'IT Technology' + i;
      obj.Weekly_Max_Hour__c = 40;

      listEmpDep.add(obj);
    }

    insert listEmpDep;

    for (Employee_Department__c eachD : listEmpDep) {
      eachD.Weekly_Max_Hour__c = 43;
    }

    update listEmpDep;

    Test.startTest();

    EmployeeDepartmentBatch ed = new EmployeeDepartmentBatch();

    id empDepIDS = Database.executeBatch(ed, 200);

    Test.stopTest();
  }
}