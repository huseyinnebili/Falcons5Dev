trigger HospitalTrigger on Hospital__c(
  before insert,
  after insert,
  before update,
  after update
) {
  List<Hospital__c> listOfReturnedNewTriggers = Trigger.new;
  List<Hospital__c> listOfReturnedOldTriggers = Trigger.old;

  //   if (Trigger.isBefore && Trigger.isUpdate) {
  //     for (Hospital__c listOfReturnedOldTrigger : listOfReturnedOldTriggers) {
  //       String hospitalOldName = listOfReturnedOldTrigger.Name;
  //       System.debug('hospitalOldName = ' + hospitalOldName);
  //     }

  //     for (Hospital__c listOfReturnedNewTrigger : listOfReturnedNewTriggers) {
  //       String hospitalNewName = listOfReturnedNewTrigger.Name;
  //       System.debug('hospitalNewName = ' + hospitalNewName);
  //     }
  //   }

  //   if (Trigger.isAfter && Trigger.isUpdate) {
  //     for (Hospital__c listOfReturnedOldTrigger : listOfReturnedOldTriggers) {
  //       String hospitalOldCity = listOfReturnedOldTrigger.Hospital_City__c;
  //       System.debug('hospitalOldCity = ' + hospitalOldCity);
  //     }

  //     for (Hospital__c listOfReturnedNewTrigger : listOfReturnedNewTriggers) {
  //       String hospitalNewCity = listOfReturnedNewTrigger.Hospital_City__c;
  //       System.debug('hospitalNewCity = ' + hospitalNewCity);
  //     }
  //   }

  Map<Id, Hospital__c> mapOfReturnedOldRecords = Trigger.oldMap;
  Map<Id, Hospital__c> mapOfReturnedNewRecords = Trigger.newMap;

  if (Trigger.isAfter && Trigger.isUpdate) {
    Set<Id> setOfIDs = mapOfReturnedNewRecords.keySet();

    for (Id setOfID : setOfIDs) {
      System.debug('eachID = ' + setOfID);

      Hospital__c oldHospitalID = mapOfReturnedOldRecords.get(setOfID);
      System.debug('old hospital names = ' + oldHospitalID.Name);

      Hospital__c newHospitalID = mapOfReturnedNewRecords.get(setOfID);
      System.debug('new hospital names = ' + newHospitalID.Name);

      String oldHospitalCity = oldHospitalID.Hospital_City__c;
      System.debug('oldHospitalCity = ' + oldHospitalCity);

      String newHospitalCity = newHospitalID.Hospital_City__c;
      System.debug('newHospitalCity = ' + newHospitalCity);
    }

    integer count = 0;

    //   if (Trigger.isBefore && Trigger.isUpdate) {
    //     Set<Id> setOfIDs = mapOfReturnedOldRecords.keySet();

    //     for (Id setOfID : setOfIDs) {
    //       Hospital__c oldHospitalValues = mapOfReturnedOldRecords.get(setOfID);
    //       String oldHospitalName = oldHospitalValues.Name;
    //       //System.debug('oldHospitalName = ' + oldHospitalName);

    //       Hospital__c newHospitalValues = mapOfReturnedNewRecords.get(setOfID);
    //       String newHospitalName = newHospitalValues.Name;
    //       //System.debug('newHospitalName = ' + newHospitalName);

    //       if (oldHospitalName != newHospitalName) {
    //         System.debug(
    //           'oldHospitalName = ' +
    //           oldHospitalName +
    //           ';' +
    //           'newHospitalName = ' +
    //           newHospitalName
    //         );
    //         count++;
    //       }
    //     }
    //   }

    if (Trigger.isAfter && Trigger.isInsert) {
      Set<Id> setOfKeys = mapOfReturnedNewRecords.keySet();

      for (Id setOfKey : setOfKeys) {
        System.debug('setOfID = ' + setOfKey);

        Hospital__c newHospitalValues = mapOfReturnedNewRecords.get(setOfKey);
        String newHospitalName = newHospitalValues.Name;
        System.debug('newHospitalName = ' + newHospitalName);

        String newHospitalCity = newHospitalValues.Hospital_City__c;
        System.debug('newHospitalCity = ' + newHospitalCity);
      }
    }
  }
}