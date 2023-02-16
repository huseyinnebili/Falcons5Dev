public class DemoDMLManipulationBulkRecords {
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

  public static void insertMultipleRecordsBranchObject() {
    List<Branch__c> listOfBranchObject = new List<Branch__c>();

    Branch__c obj1 = new Branch__c();

    obj1.HOD_Name__c = 'Theodore';
    obj1.Branch_Name__c = 'Java Developer';
    obj1.HOD_Phone__c = '2963451265';
    obj1.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 15);

    Branch__c obj2 = new Branch__c();

    obj2.HOD_Name__c = 'Henry';
    obj2.Branch_Name__c = 'QA Tester';
    obj2.HOD_Phone__c = '2963461255';
    obj2.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 25);

    Branch__c obj3 = new Branch__c();

    obj3.HOD_Name__c = 'Mia';
    obj3.Branch_Name__c = 'Plumber';
    obj3.HOD_Phone__c = '2963491355';
    obj3.Branch_Registration_Due_Date__c = Date.newInstance(2022, 9, 15);

    listOfBranchObject.add(obj1);
    listOfBranchObject.add(obj2);
    listOfBranchObject.add(obj3);

    insert listOfBranchObject;
  }

  public static void updateRecordOnMobileCarrierObject() {
    Mobile_Carrier__c mobCar = [
      SELECT Service_Name__c, Service_Fee__c, id
      FROM Mobile_Carrier__c
      WHERE Service_Name__c = 'Talk Talk'
      LIMIT 1
    ];

    mobCar.Provider_Companies__c = 'AT&T Mobile';
    mobCar.Carrier_Plans_Provided__c = 'Fun games across all Apple devices';

    update mobCar;
  }

  public static void insertMultipleRecordsToStudentObject() {
    Branch__c branch = [
      SELECT Branch_Name__c, id
      FROM Branch__c
      WHERE Branch_Name__c = 'Java Developer'
      LIMIT 1
    ];
    List<Student__c> listOfStdObjRec = new List<Student__c>();

    Student__c obj1 = new Student__c();

    obj1.Student_Name__c = 'Emma';
    obj1.Branch_ID__c = branch.Id;
    obj1.Type_of_Lectures__c = 'Optional';
    obj1.Lectures__c = 'Science';

    Student__c obj2 = new Student__c();

    obj2.Student_Name__c = 'Amelia';
    obj2.Branch_ID__c = branch.Id;
    obj2.Type_of_Lectures__c = 'Required';
    obj2.Lectures__c = 'Geometry';

    Student__c obj3 = new Student__c();

    obj3.Student_Name__c = 'Sophia';
    obj3.Branch_ID__c = branch.Id;
    obj3.Type_of_Lectures__c = 'Optional';
    obj3.Lectures__c = 'Math';

    listOfStdObjRec.add(obj1);
    listOfStdObjRec.add(obj2);
    listOfStdObjRec.add(obj3);

    insert listOfStdObjRec;
  }
}