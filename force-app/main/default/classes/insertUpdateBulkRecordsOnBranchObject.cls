public with sharing class insertUpdateBulkRecordsOnBranchObject {
  public static void insertBulkRecordsToBranchObject() {
    List<Branch__c> listOfBranchObj = new List<Branch__c>();

    Branch__c obj1 = new Branch__c();

    obj1.Branch_Name__c = 'Financial Manager';
    obj1.Branch_Registration_Due_Date__c = Date.newInstance(2022, 7, 15);
    obj1.HOD_Phone__c = '2013212380';
    obj1.HOD_Name__c = 'Diana';

    listOfBranchObj.add(obj1);

    Branch__c obj2 = new Branch__c();

    obj2.Branch_Name__c = 'Financial Manager';
    obj2.Branch_Registration_Due_Date__c = Date.newInstance(2022, 8, 30);
    obj2.HOD_Phone__c = '2013212390';
    obj2.HOD_Name__c = 'Beverly';

    listOfBranchObj.add(obj2);

    insert listOfBranchObj;
  }

  public static void updateBranchObjectField() {
    List<Branch__c> listBranch = [
      SELECT
        id,
        name,
        Branch_Description__c,
        Branch_Name__c,
        Registration_Confirmation_Status__c,
        (
          SELECT Student_Branch_Description__c, Student_Registration_Status__c
          FROM Students__r
        )
      FROM Branch__c
      WHERE
        Branch_Name__c = 'Salesforce Developer'
        AND Registration_Confirmation_Status__c != 'Completed'
    ];

    for (Branch__c eachBranch : listBranch) {
      eachBranch.Branch_Description__c = 'A Salesforce developer is a special type of computer programmer who writes software on the Salesforce CRM platform or another piece of Salesforce cloud technology. ';
      eachBranch.Registration_Confirmation_Status__c = 'Completed';
    }

    update listBranch;
  }

  public static void updateTypeOfLectureField() {
    list<Student__c> listStudent = [
      SELECT id, name, Type_of_Lectures__c
      FROM Student__c
      WHERE Type_of_Lectures__c = NULL
    ];

    for (Student__c eachStudent : listStudent) {
      eachStudent.Type_of_Lectures__c = 'Required';
    }

    update listStudent;
  }

  public static void updateRegistrationConfirmationStatusFieldOnBranch() {
    list<Branch__c> listBranch = [
      SELECT id, name, Registration_Confirmation_Status__c, Branch_Name__c
      FROM Branch__c
      WHERE Branch_Name__c = 'Salesforce Developer'
    ];

    for (Branch__c eachBranch : listBranch) {
      eachBranch.Registration_Confirmation_Status__c = 'In Progress';
    }

    update listBranch;
  }

  //Database.insert (sObject,AllOrNothing)=>true or false
  public static void insertUpdateBulkRecordsOnBranchObjectViaDatabaseInsert() {
    Branch__c obj1 = new Branch__c();

    obj1.Branch_Name__c = 'Salesforce Administor';
    obj1.Branch_Registration_Due_Date__c = Date.today();
    obj1.HOD_Phone__c = '2013212380';
    obj1.HOD_Name__c = 'Carol';

    Branch__c obj2 = new Branch__c();

    obj2.Branch_Name__c = 'Java Developer';
    obj2.Branch_Registration_Due_Date__c = Date.today();
    obj2.HOD_Phone__c = '2013212390';
    obj2.HOD_Name__c = 'Emma';

    Branch__c obj3 = new Branch__c();

    Branch__c obj4 = new Branch__c();
    List<Branch__c> listOfBranchObj = new List<Branch__c>{
      obj1,
      obj2,
      obj3,
      obj4
    };
    List<Database.SaveResult> results = Database.insert(listOfBranchObj, true);

    for (Database.SaveResult eachResult : results) {
      if (eachResult.isSuccess()) {
        System.debug(
          'Branch successfully inserted.Branch id is ' + eachResult.getId()
        );
      } else {
        System.debug('Errors ' + eachResult.getErrors());
      }
    }
  }
}