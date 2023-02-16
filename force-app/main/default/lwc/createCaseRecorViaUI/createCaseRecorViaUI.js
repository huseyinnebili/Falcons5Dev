import { LightningElement } from "lwc";
import Case from "@salesforce/schema/Case";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class CreateCaseRecorViaUI extends LightningElement {
  formData = {};

  changeHandler(event) {
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  createCase() {
    const recordInput = {
      apiName: Case.objectApiName,
      fields: this.formData
    };

    createRecord(recordInput)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.caseRecord").reset();
        this.formData = {};
        this.creatToast(
          "Success",
          "Record has been created successfully",
          "success"
        );
      })
      .catch((error) => {
        console.error(error);
        this.creatToast("Error", error.message, "error");
      });
  }

  creatToast(title, message, variant) {
    const toast = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(toast);
  }
}