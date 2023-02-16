import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { deleteRecord } from "lightning/uiRecordApi";
export default class DeleteCaseRecordViaUI extends LightningElement {
  recordId;

  changeHandler(event) {
    this.recordId = event.target.value;
  }

  deleteRecord() {
    deleteRecord(this.recordId)
      .then((result) => {
        console.log(result);
        this.createToast(
          "Success",
          "Record has been deleted successfully",
          "success"
        );
      })

      .catch((error) => {
        console.log(error);
        this.createToast("Error", error.body.message, "error");
      });
  }
  createToast(title, message, variant) {
    const toast = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(toast);
  }
}