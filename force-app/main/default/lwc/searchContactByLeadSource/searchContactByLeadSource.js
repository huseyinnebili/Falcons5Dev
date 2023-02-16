import { LightningElement } from "lwc";
import searchContactByLeadSource from "@salesforce/apex/AccountCtrl.searchContactByLeadSource";
export default class SearchContactByLeadSource extends LightningElement {
  searchWord;
  contacts;
  error;

  searchHandler(event) {
    this.searchWord = event.target.value;
    if (this.searchWord.length > 1) {
      searchContactByLeadSource({ searchKey: this.searchWord })
        .then((result) => {
          console.log(result);
          this.contacts = result;
        })
        .catch((error) => {
          console.error(error);
          this.error = error;
        });
    } else {
      this.contacts = undefined;
      this.error = undefined;
    }
  }
}