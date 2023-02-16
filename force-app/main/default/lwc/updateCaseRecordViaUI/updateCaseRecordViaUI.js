import { LightningElement } from "lwc";

import { updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class UpdateCaseRecordViaUI extends LightningElement {
  formData = {};
  recordId = "5008V00001RNtHpQAL";

  changeHandler(event) {
    this.formData["Id"] = this.recordId;
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  updateCase() {
    const recordInput = {
      fields: this.formData
    };

    updateRecord(recordInput)
      .then((result) => {
        console.log(result);

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