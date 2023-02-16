@isTest
public with sharing class DemoDMLManipulationBulkRecordsTest {
  @isTest
  public static void DemoDMLManipulationBulkRecordsTest() {
    Mobile_Carrier__c mobile = new Mobile_Carrier__c();
    mobile.Service_Name__c = 'Talk Talk';

    insert mobile;

    DemoDMLManipulationBulkRecords.insertRecordMobileCarrierCustomerObject();

    List<Mobile_Carier_Customer__c> customerList = [
      SELECT Customer_Name__c, id, name
      FROM Mobile_Carier_Customer__c
    ];

    system.assertEquals('Sanchez', customerList[0].Customer_Name__c);
    system.assertEquals(1, customerList.size());
  }

  @isTest
  public static void DemoDMLManipulationBulkRecordsTestTwo() {
    DemoDMLManipulationBulkRecords.insertMultipleRecordsBranchObject();

    List<Branch__c> branchList = [
      SELECT
        id,
        name,
        HOD_Name__c,
        Branch_Name__c,
        HOD_Phone__c,
        Branch_Registration_Due_Date__c
      FROM Branch__c
    ];

    system.assertEquals(3, branchList.size());
    system.assertEquals('Theodore', branchList[0].HOD_Name__c);
    system.assertEquals('2963451265', branchList[0].HOD_Phone__c);
    system.assertEquals(
      Date.newInstance(2022, 8, 25),
      branchList[1].Branch_Registration_Due_Date__c
    );
  }

  @isTest
  public static void DemoDMLManipulationBulkRecordsTestThree() {
    Mobile_Carrier__c mob = new Mobile_Carrier__c();
    mob.Service_Name__c = 'Talk Talk';
    insert mob;

    DemoDMLManipulationBulkRecords.updateRecordOnMobileCarrierObject();

    List<Mobile_Carrier__c> mobile = [
      SELECT
        Service_Name__c,
        Service_Fee__c,
        id,
        Provider_Companies__c,
        Carrier_Plans_Provided__c
      FROM Mobile_Carrier__c
      WHERE Service_Name__c = 'Talk Talk'
      LIMIT 1
    ];

    system.assertEquals(1, mobile.size());
    system.assertEquals('AT&T Mobile', mobile[0].Provider_Companies__c);
    system.assertEquals(
      'Fun games across all Apple devices',
      mobile[0].Carrier_Plans_Provided__c
    );
  }

  @isTest
  public static void DemoDMLManipulationBulkRecordsTestFour() {
    Branch__c branch = new Branch__c();

    branch.Branch_Name__c = 'Java Developer';

    insert branch;

    DemoDMLManipulationBulkRecords.insertMultipleRecordsToStudentObject();

    list<Student__c> studentList = [
      SELECT Student_Name__c, Type_of_Lectures__c, Lectures__c
      FROM Student__c
    ];

    system.assertEquals(3, studentList.size());
    system.assertEquals('Amelia', studentList[1].Student_Name__c);
    system.assertEquals('Optional', studentList[2].Type_of_Lectures__c);
  }
}