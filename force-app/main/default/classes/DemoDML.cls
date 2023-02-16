public class DemoDML {
  public static void insertRecordToBranchObject() {
    Branch__c branchObj = new Branch__c();

    branchObj.Branch_Name__c = 'Physician';
    branchObj.HOD_Name__c = 'Rodriguez';
    branchObj.HOD_Phone__c = '2102321232';

    insert branchObj;
  }

  public static void insertRecordToStudentObject() {
    Branch__c branch = [
      SELECT Branch_Name__c, Name, Id
      FROM Branch__c
      WHERE Branch_Name__c = 'Mechanic'
      LIMIT 1
    ];

    Student__c stdObj = new Student__c();

    stdObj.Student_Name__c = 'Fernandez';
    stdObj.Branch_ID__c = branch.Id;
    stdObj.Type_of_Lectures__c = 'Optional';

    insert stdObj;
  }

  public static void insertRecordToMobileCarrierObject() {
    Mobile_Carrier__c mobCar = new Mobile_Carrier__c();

    mobCar.Service_Name__c = 'Talk Talk';
    mobCar.Service_Fee__c = 49.45;

    insert mobCar;
  }

  public static void insertRecordMobileCarrierCustomerObject() {
    Mobile_Carrier__c mobCar = [
      SELECT id, Service_Name__c
      FROM Mobile_Carrier__c
      WHERE Service_Name__c = 'Talk Talk'
      LIMIT 1
    ];

    Mobile_Carier_Customer__c mobCarCus = new Mobile_Carier_Customer__c();

    mobCarCus.Customer_Name__c = 'Sanchez';
    mobCarCus.Service_Type__c = 'Mobile';
    mobCarCus.Plan_Starting_Date__c = Date.newInstance(2022, 6, 27);
    mobCarCus.Mobile_Carrier__c = mobCar.id;

    insert mobCarCus;
  }
}