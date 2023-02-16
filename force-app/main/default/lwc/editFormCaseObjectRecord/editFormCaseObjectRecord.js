import { LightningElement } from "lwc";
import CASE_OBJECT from "@salesforce/schema/Case";
import Subject_Field from "@salesforce/schema/Case.Subject";
import Status_Field from "@salesforce/schema/Case.Status";
import Priority_Field from "@salesforce/schema/Case.Priority";
import Origin_Field from "@salesforce/schema/Case.Origin";
import AccountId_Field from "@salesforce/schema/Case.AccountId";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class EditFormCaseObjectRecord extends LightningElement {
  objectApiName = CASE_OBJECT;
  recordId = "5008V00001QAxC0QAL";
  fields = {
    subject: Subject_Field,
    status: Status_Field,
    priority: Priority_Field,
    origin: Origin_Field,
    account: AccountId_Field
  };

  showToast() {
    const event = new ShowToastEvent({
      title: "success",
      message: "Case has been updated successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}