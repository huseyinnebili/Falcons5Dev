public with sharing class insertUpdateRecordsOnStudentObject {
  public static void insertRecordToStudentObject() {
    List<Branch__c> branchList = [
      SELECT id, name, Branch_Name__c
      FROM Branch__c
      LIMIT 1
    ];
    List<Student__c> studentList = new List<Student__c>();
    for (Branch__c eachBranch : branchList) {
      Student__c obj1 = new Student__c();

      obj1.Student_Name__c = 'Nashville';
      obj1.Student_Registration_Date__c = Date.today();
      obj1.Student_Registration_Status__c = 'In Progress';
      obj1.Type_of_Lectures__c = 'Optional';
      obj1.Branch_ID__c = eachBranch.id;

      Student__c obj2 = new Student__c();

      obj2.Student_Name__c = 'Camilia';
      obj2.Student_Registration_Date__c = Date.today();
      obj2.Student_Registration_Status__c = 'Completed';
      obj2.Type_of_Lectures__c = 'Required';
      obj2.Branch_ID__c = eachBranch.id;

      studentList.add(obj1);
      studentList.add(obj2);
    }

    if (!studentList.isEmpty()) {
      insert studentList;
    }
  }
}