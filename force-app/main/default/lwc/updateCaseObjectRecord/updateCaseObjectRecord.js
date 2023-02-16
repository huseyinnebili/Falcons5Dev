import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { updateRecord } from "lightning/uiRecordApi";
import { LightningElement } from "lwc";

export default class UpdateCaseObjectRecord extends LightningElement {
  recordId = "5008V00001RQG2iQAH";
  formData = {};

  changeHandler(event) {
    const { name, value } = event.target;
    this.formData[name] = value;
    this.formData["Id"] = this.recordId;
  }

  updateCaseRecord() {
    const recordIdInput = { fields: this.formData };

    updateRecord(recordIdInput)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.updateCase").reset();
        this.showToast(
          "Success",
          "Record has been updated succesfully",
          "success"
        );
        this.formData = {};
      })
      .catch((error) => {
        console.error(error);
        this.showToast("Error", error.message, "error");
      });
  }

  showToast(title, message, variant) {
    const event = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(event);
  }
}