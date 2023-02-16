import { deleteRecord } from "lightning/uiRecordApi";
import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class DeleteRecordOnOpp extends LightningElement {
  recordId = "";

  changeHandler(event) {
    this.recordId = event.target.value;
  }

  deleteOpp() {
    deleteRecord(this.recordId)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.deleteOpp").reset();
        this.showToast(
          "Success",
          "Opp record has been deleted successfully!",
          "success"
        );
      })
      .catch((error) => {
        console.log(error);
        this.showToast("Error", error.message, "error");
      });
  }

  showToast(title, message, variant) {
    const event = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(event);
  }
}