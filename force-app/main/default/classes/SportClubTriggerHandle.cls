public with sharing class SportClubTriggerHandle {
  public static void updateClubReviewFieldOnSportClub(
    List<Sport_Club__c> sportTriggerNew,
    List<Sport_Club__c> sportTriggerOld,
    Map<Id, Sport_Club__c> sportTriggerNewMap,
    Map<Id, Sport_Club__c> sportTriggerOldMap
  ) {
    boolean condition = false;

    String sClubCustomError = system.label.SportClubRequiredAgeValidation;

    //Trigger.isBefore && Trigger.isInsert
    for (Sport_Club__c eachClub : sportTriggerNew) {
      if (sportTriggerOld == null && eachClub.Club_Name__c != null) {
        if (eachClub.Required_Age__c != null) {
          condition = true;
        } else {
          eachClub.addError(sClubCustomError);
        }
      }

      //Trigger.isBefore && Trigger.isUpdate

      if (sportTriggerOld != null) {
        if (
          eachClub.Club_Name__c !=
          sportTriggerOldMap.get(eachClub.id).Club_Name__c
        ) {
          if (eachClub.Required_Age__c != null) {
            condition = true;
          } else {
            eachClub.addError(sClubCustomError);
          }
        }
        if (condition) {
          eachClub.Club_Reviews__c = 'Beautiful facility, everything you need to train to up your game whether its  asketball, volleyball, or my favorite baseball,and the others.';
        }
      }
    }
  }

  //Trigger.isAfter && Trigger.isInsert
  public static void insertRelatedRecords(
    List<Sport_Club__c> sportTriggerNew,
    List<Sport_Club__c> sportTriggerOld,
    Map<Id, Sport_Club__c> sportTriggerNewMap,
    Map<Id, Sport_Club__c> sportTriggerOldMap
  ) {
    //We will get hiearchy custom settings value via getOrgDefaults() method and use dynamic values!...
    String customError = system.label.ClubAttendeeValidation;
    try {
      List<Club_Attendee__c> listAttendee = new List<Club_Attendee__c>();
      ClubAttendeeReview__c ca = ClubAttendeeReview__c.getOrgDefaults();
      for (Sport_Club__c eachClub : sportTriggerNew) {
        Club_Attendee__c obj1 = new Club_Attendee__c();
        obj1.Attendee_Name__c = 'Teddy';
        obj1.Register_Date__c = Date.today();
        obj1.Attendee_Phone__c = '2101321234';
        obj1.Sport_Club__c = eachClub.id;
        obj1.Attendee_Favourite_Sport__c = ca.Attendee_Favourite_Sports__c;
        obj1.Attendee_Review_For_Club__c = ca.AttendeeReviewForClub__c;

        Club_Attendee__c obj2 = new Club_Attendee__c();
        obj2.Attendee_Name__c = 'Sue';
        obj2.Register_Date__c = Date.today();
        obj2.Attendee_Phone__c = '2101321245';
        obj2.Sport_Club__c = eachClub.id;
        obj2.Attendee_Favourite_Sport__c = ca.Attendee_Favourite_Sports__c;
        obj2.Attendee_Review_For_Club__c = ca.AttendeeReviewForClub__c;

        listAttendee.add(obj1);
        listAttendee.add(obj2);
      }

      if (!listAttendee.isEmpty()) {
        insert listAttendee;
      }
    } catch (Exception e) {
      for (Sport_Club__c eachSport : sportTriggerNew) {
        eachSport.addError(customError);
      }
    }
  }
  //Trigger.isAfter && Trigger.isUpdate
  public static void updateRelatedRecordField(
    List<Sport_Club__c> sportTriggerNew,
    List<Sport_Club__c> sportTriggerOld,
    Map<Id, Sport_Club__c> sportTriggerNewMap,
    Map<Id, Sport_Club__c> sportTriggerOldMap
  ) {
    Set<Id> setSportIDs = new Set<Id>();

    for (Sport_Club__c eachSport : sportTriggerNew) {
      setSportIDs.add(eachSport.id);
    }

    String customError = system.label.ClubAttendeeAgeValidation;
    List<Club_Attendee__c> listCAttendee = [
      SELECT
        id,
        name,
        Attendee_Age__c,
        Attendee_Branch_Name__c,
        Sport_Club__r.id,
        Sport_Club__r.Required_Age__c,
        Sport_Club__r.Branch_Name__c,
        Register_Date__c
      FROM Club_Attendee__c
      WHERE Sport_Club__r.id IN :setSportIDs
    ];

    for (Sport_Club__c eachSC : sportTriggerNew) {
      for (Club_Attendee__c eachAttendee : listCAttendee) {
        if (eachAttendee.Attendee_Age__c != null) {
          decimal attendeeAge = sportTriggerNewMap.get(
              eachAttendee.Sport_Club__r.id
            )
            .Required_Age__c;

          eachAttendee.Attendee_Age__c = attendeeAge;

          String attendeeBranchName = sportTriggerNewMap.get(
              eachAttendee.Sport_Club__r.id
            )
            .Branch_Name__c;
          eachAttendee.Attendee_Branch_Name__c = attendeeBranchName;
        } else {
          eachSC.addError(customError);
        }
      }
    }

    update listCAttendee;
  }

  //Trigger.isAfter && Trigger.isInsert
  @future
  public static void updateRelatedRecordFieldViaFutureMethod(
    set<id> setSportIDs
  ) {
    String customError = system.label.ClubAttendeeAgeValidation;
    List<Club_Attendee__c> listCAttendee = [
      SELECT
        id,
        name,
        Attendee_Age__c,
        Have_You_Ever_Attend_Any_Sport_Club__c,
        Sport_Club__r.id,
        Sport_Club__r.Required_Age__c,
        Sport_Club__r.Club_Reviews__c
      FROM Club_Attendee__c
      WHERE Sport_Club__r.id IN :setSportIDs
    ];

    for (Club_Attendee__c eachAttendee : listCAttendee) {
      eachAttendee.Have_You_Ever_Attend_Any_Sport_Club__c = true;
    }

    update listCAttendee;
  }
}