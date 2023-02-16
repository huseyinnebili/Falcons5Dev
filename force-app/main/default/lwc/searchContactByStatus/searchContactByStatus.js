import { LightningElement } from "lwc";
import searchContactByStatus from "@salesforce/apex/AccountCtrl.searchContactByStatus";
export default class SearchContactByStatus extends LightningElement {
  selectedStatus;
  contacts;
  error;

  get statusOptions() {
    return [
      { label: "active", value: "active" },
      { label: "inactive", value: "inactive" }
    ];
  }

  changeHandler(event) {
    this.selectedStatus = event.target.value;

    searchContactByStatus({
      searchKey: this.selectedStatus
    })
      .then((result) => {
        console.log(result);
        this.contacts = result;
      })
      .catch((error) => {
        console.error(error);
        this.error = error;
      });
  }
}