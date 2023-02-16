public with sharing class StudentTriggerHandler {
  public static void updateFieldsOnStudentObj(
    List<Student__c> studentTriggerNew,
    Map<Id, Student__c> studentTriggerOldMap
  ) {
    //we fetch custom settings list data
    Map<String, StudentBootCamps__c> stdnBootCamps = StudentBootCamps__c.getAll();

    boolean condition = false;
    for (Student__c eachStd : studentTriggerNew) {
      if (studentTriggerOldMap == null) {
        condition = true;
      } else if (
        eachStd.Boot_Camps__c !=
        studentTriggerOldMap.get(eachStd.id).Boot_Camps__c
      ) {
        condition = true;
      }

      if (condition) {
        StudentBootCamps__c sbc = stdnBootCamps.get(eachStd.Boot_Camps__c);

        eachStd.Course_Fee__c = sbc.Course_Fee__c;
      }
    }
  }
}