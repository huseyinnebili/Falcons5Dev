import { LightningElement } from "lwc";
import Case from "@salesforce/schema/Case";
import Type from "@salesforce/schema/Case.Type";
import Origin from "@salesforce/schema/Case.Origin";
import Status from "@salesforce/schema/Case.Status";
import Priority from "@salesforce/schema/Case.Priority";
import Reason from "@salesforce/schema/Case.Reason";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class RecordFormCaseObject extends LightningElement {
  objectApiName = Case;
  //recordId='';
  fields = [Type, Origin, Status, Priority, Reason];

  showToast() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "Case record has been created successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}