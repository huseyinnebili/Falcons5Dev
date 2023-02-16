import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import BRANCH from "@salesforce/schema/Branch__c";
import BranchName from "@salesforce/schema/Branch__c.Branch_Name__c";
import HODName from "@salesforce/schema/Branch__c.HOD_Name__c";
import HODPhone from "@salesforce/schema/Branch__c.HOD_Phone__c";
import RegistrationConfirmationStatus from "@salesforce/schema/Branch__c.Registration_Confirmation_Status__c";
import BranchFee from "@salesforce/schema/Branch__c.Branch_Fee__c";
import BranchRegistrationDueDate from "@salesforce/schema/Branch__c.Branch_Registration_Due_Date__c";

export default class RecordFormBranch extends LightningElement {
  objectName = BRANCH;

  fields = [
    BranchName,
    HODName,
    HODPhone,
    RegistrationConfirmationStatus,
    BranchFee,
    BranchRegistrationDueDate
  ];

  showToast() {
    const event = new ShowToastEvent({
      title: "success",
      message: "Branch object record has been created successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}