import { LightningElement } from "lwc";
import { updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import Id from "@salesforce/schema/Account.Id";

export default class UpdateAccountRecord extends LightningElement {
  formData = {};
  recordId = "0018V00002PA3KHQA1";

  changeHandler(event) {
    this.formData[Id] = this.recordId;
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  updateAccount() {
    const recordIdInput = {
      fields: this.formData
    };

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