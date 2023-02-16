import { LightningElement } from "lwc";
import Case from "@salesforce/schema/Case";
import Type from "@salesforce/schema/Case.Type";
import Origin from "@salesforce/schema/Case.Origin";
import Status from "@salesforce/schema/Case.Status";
import Priority from "@salesforce/schema/Case.Priority";
import Reason from "@salesforce/schema/Case.Reason";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class RecordEditFormCaseObject extends LightningElement {
  objectApiName = Case;
  recordId = "5008V00001QAxC1QAL";

  fields = {
    type: Type,
    origin: Origin,
    status: Status,
    priority: Priority,
    reason: Reason
  };

  showToast() {
    const event = new ShowToastEvent({
      title: "success",
      message: "Case record has been updated successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}