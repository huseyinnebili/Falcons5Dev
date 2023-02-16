import { LightningElement } from "lwc";
import CASE_OBJECT from "@salesforce/schema/Case";
import Subject_Field from "@salesforce/schema/Case.Subject";
import Status_Field from "@salesforce/schema/Case.Status";
import Priority_Field from "@salesforce/schema/Case.Priority";
import Origin_Field from "@salesforce/schema/Case.Origin";
import AccountId_Field from "@salesforce/schema/Case.AccountId";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class RecordFormCreateCaseRecord extends LightningElement {
  objectApiName = CASE_OBJECT;
  recordId;
  fields = [
    Subject_Field,
    Status_Field,
    Priority_Field,
    Origin_Field,
    AccountId_Field
  ];

  showToast() {
    const event = new ShowToastEvent({
      title: "success",
      message: "The Case has been saved successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}

/*

cs1.Subject='Test Case Four';
cs1.Status='New';
cs1.Origin='Web';
cs1.Priority='Low';
cs1.AccountId=cs.Id;

*/