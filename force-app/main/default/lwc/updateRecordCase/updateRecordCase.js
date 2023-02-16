import { updateRecord } from "lightning/uiRecordApi";
import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class UpdateRecordCase extends LightningElement {
  formData = {};
  recordId = "5008V00001QAxC2QAL";

  changeHandler(event) {
    this.formData["Id"] = this.recordId;
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  updateCase() {
    const recordIdInput = { fields: this.formData };

    updateRecord(recordIdInput)
      .then((result) => {
        console.log(result);

        this.creatToast(
          "Success",
          "Record has been updated successfully",
          "success"
        );
      })

      .catch((error) => {
        console.error(error);
        this.creatToast("Error", "Error has occurred!..", "error");
      });
  }

  creatToast(title, message, variant) {
    const toast = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(toast);
  }
}