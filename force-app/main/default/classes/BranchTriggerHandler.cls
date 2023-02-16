public class BranchTriggerHandler {
  public static void updateBranchRegistrationDueDate(
    List<Branch__c> branchTriggerNew,
    List<Branch__c> branchTriggerOld,
    Map<Id, Branch__c> branchTriggerNewMap,
    Map<Id, Branch__c> branchTriggerOldMap
  ) {
    boolean condition = false;
    for (Branch__c eachBranch : branchTriggerNew) {
      //insert condition
      if (branchTriggerOldMap == null && eachBranch.Branch_Name__c != null) {
        if (eachBranch.Branch_Registration_Due_Date__c != null) {
          condition = true;
        } else {
          eachBranch.addError(
            'Branch_Registration_Due_Date__c cannot be emptyYY!..'
          );
        }
      }

      //update condition
      if (branchTriggerOldMap != null) {
        if (
          eachBranch.HOD_Phone__c != null &&
          eachBranch.Branch_Name__c !=
          branchTriggerOldMap.get(eachBranch.id).Branch_Name__c
        ) {
          if (eachBranch.Branch_Registration_Due_Date__c != null) {
            condition = true;
          } else {
            eachBranch.addError(
              'Branch_Registration_Due_Date__c cannot be emptyyyyy!..'
            );
          }
        }
      }
      if (condition) {
        eachBranch.Branch_Fee__c = 3265;
        eachBranch.HOD_Name__c = 'Diana';
      }
    }
  }

  public static void createStudentRecord(List<Branch__c> branchTriggerNew) {
    String customLabel = System.label.StudentValidationTwo;
    try {
      List<Student__c> listStd = new List<Student__c>();

      //we fetch custom settings hierarchical data
      StudentCustomSettings__c sct = StudentCustomSettings__c.getOrgDefaults();

      for (Branch__c eachBranch : branchTriggerNew) {
        Student__c obj1 = new Student__c();
        obj1.Student_Name__c = 'William';
        obj1.Boot_Camps__c = 'Data Science';
        obj1.Type_of_Lectures__c = 'Required';
        obj1.Student_Registration_Date__c = Date.today();
        obj1.Branch_ID__c = eachBranch.id;
        obj1.Student_Favourite_Branches__c = sct.Student_Favourite_Branches__c;
        obj1.Stuedent_Branch_Background__c = sct.Student_Branch_Background__c;

        Student__c obj2 = new Student__c();
        obj2.Student_Name__c = 'Jessica	';
        obj2.Boot_Camps__c = 'Cyber Security';
        obj2.Type_of_Lectures__c = 'Required';
        obj2.Student_Registration_Date__c = Date.today();
        obj2.Branch_ID__c = eachBranch.id;
        obj2.Student_Favourite_Branches__c = sct.Student_Favourite_Branches__c;
        obj2.Stuedent_Branch_Background__c = sct.Student_Branch_Background__c;

        listStd.add(obj1);
        listStd.add(obj2);
      }

      if (!listStd.isEmpty()) {
        insert listStd;
      }
    } catch (Exception ex) {
      for (Branch__c eachBro : branchTriggerNew) {
        eachBro.addError(customLabel);
      }
    }
  }

  public static void updateRelatedRecordsField(
    List<Branch__c> branchTriggerNew,
    List<Branch__c> branchTriggerOld,
    Map<Id, Branch__c> branchTriggerNewMap,
    Map<Id, Branch__c> branchTriggerOldMap
  ) {
    Set<Id> setBranchIDs = new Set<Id>();

    for (Branch__c eachBranch : branchTriggerNew) {
      setBranchIDs.add(eachBranch.id);
    }

    List<Student__c> listStudents = [
      SELECT id, name, Branch_ID__r.id, Type_of_Lectures__c
      FROM Student__c
      WHERE Branch_ID__r.id IN :setBranchIDs
    ];

    //Custom Label was crated!...
    String customError = system.label.Student_Validation;

    for (Branch__c eachBr : branchTriggerNew) {
      for (Student__c eachStudent : listStudents) {
        if (eachStudent.Type_of_Lectures__c != null) {
          decimal studentCourseFee = branchTriggerNewMap.get(
              eachStudent.Branch_ID__r.id
            )
            .Branch_Fee__c;

          eachStudent.Course_Fee__c = studentCourseFee;
        } else {
          eachBr.addError(customError);
        }
      }
    }
    if (!listStudents.isEmpty()) {
      //update listStudents;
    }
  }

  @future
  public static void updateBranchReviewField(set<id> setBranchIDs) {
    list<Branch__c> listBranch = [
      SELECT id, name, Branch_Description__c
      FROM Branch__c
      WHERE id IN :setBranchIDs
    ];

    for (Branch__c eachBranch : listBranch) {
      eachBranch.Branch_Description__c = 'Financial managers have the responsibility of overseeing the finances of major companies, agencies and everything in between';
      eachBranch.Registration_Confirmation_Status__c = 'In Progress';
    }

    update listBranch;
  }

  public static void updateRegistrationConfirmationStatusAndDescriptionFields(
    List<Branch__c> branchTriggerNew,
    List<Branch__c> branchTriggerOld,
    Map<Id, Branch__c> branchTriggerNewMap,
    Map<Id, Branch__c> branchTriggerOldMap
  ) {
    Set<id> setBranchIDs = new Set<id>();
    for (Branch__c eachBranch : branchTriggerNew) {
      if (
        eachBranch.Registration_Confirmation_Status__c == 'Completed' &&
        branchTriggerOldMap.get(eachBranch.id)
          .Registration_Confirmation_Status__c != 'Completed'
      ) {
        setBranchIDs.add(eachBranch.id);
      }
    }

    if (!setBranchIDs.isEmpty()) {
      updateRegistrationConfirmationStatusAndDescriptionFieldsFutureMethod(
        setBranchIDs
      );
    }
  }

  @future
  public static void updateRegistrationConfirmationStatusAndDescriptionFieldsFutureMethod(
    set<id> setBranchIDs
  ) {
    list<Student__c> listStudent = [
      SELECT
        id,
        name,
        Branch_ID__r.id,
        Student_Registration_Status__c,
        Student_Branch_Description__c,
        Type_of_Lectures__c
      FROM Student__c
      WHERE Branch_ID__r.id IN :setBranchIDs
    ];

    for (Student__c eachStudent : listStudent) {
      eachStudent.Student_Registration_Status__c = 'Completed';
      eachStudent.Student_Branch_Description__c = 'A Salesforce developer is a special type of computer programmer who writes software on the Salesforce CRM platform or another piece of Salesforce cloud technology. ';
    }

    update listStudent;
  }
}