import { LightningElement } from "lwc";
import { deleteRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class DeleteRecordCaase extends LightningElement {
  recordId;
  changeHandler(event) {
    this.recordId = event.target.value;
  }

  deleteRec() {
    deleteRecord(this.recordId)
      .then((result) => {
        console.log(result);

        this.template.querySelector("lightning-input").reset();
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