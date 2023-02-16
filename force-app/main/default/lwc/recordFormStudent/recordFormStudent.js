import { LightningElement } from "lwc";

import StudentName from "@salesforce/schema/Student__c.Student_Name__c";
import StudentDOB from "@salesforce/schema/Student__c.Student_DOB__c";
import StudentFavouriteBranches from "@salesforce/schema/Student__c.Student_Favourite_Branches__c";
import StudentRegistrationStatus from "@salesforce/schema/Student__c.Student_Registration_Status__c";
import TypeofLectures from "@salesforce/schema/Student__c.Type_of_Lectures__c";
import Phone from "@salesforce/schema/Student__c.Phone__c";
import BranchID from "@salesforce/schema/Student__c.Branch_ID__c";

import { ShowToastEvent } from "lightning/platformShowToastEvent";

import STUDENT_OBJECT from "@salesforce/schema/Student__c";

export default class RecordFormStudent extends LightningElement {
  // recordId = "a0E8b00000yz2jpEAA";
  objectName = STUDENT_OBJECT;
  fields = [
    StudentName,
    Phone,
    StudentDOB,
    StudentFavouriteBranches,
    StudentRegistrationStatus,
    TypeofLectures,
    BranchID
  ];

  showToast() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "The opportunity has been saved successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}