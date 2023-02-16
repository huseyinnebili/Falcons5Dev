@isTest
public with sharing class insertUpdateRecordsOnStudentObjectTest {
  @isTest
  public static void insertRecordToStudentObjectTest() {
    Branch__c branch = new Branch__c();

    branch.Branch_Name__c = 'Data Science';
    branch.Branch_Fee__c = 3291;
    branch.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 1);

    insert branch;

    insertUpdateRecordsOnStudentObject.insertRecordToStudentObject();

    list<Student__c> studentList = [
      SELECT
        id,
        name,
        Student_Name__c,
        Student_Registration_Date__c,
        Type_of_Lectures__c
      FROM Student__c
    ];

    system.assertEquals(2, studentList.size());
    system.assertEquals('Camilia', studentList[1].Student_Name__c);
    system.assertEquals('Optional', studentList[0].Type_of_Lectures__c);
  }
}