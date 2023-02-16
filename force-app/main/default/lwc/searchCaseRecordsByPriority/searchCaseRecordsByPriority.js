import { LightningElement } from "lwc";
import searchCaseRecordsByPriority from "@salesforce/apex/AccountCtrl.searchCaseRecordsByPriority";

export default class SearchCaseRecordsByPriority extends LightningElement {
  searchWord;
  cases;
  error;

  searchHandler(event) {
    this.searchWord = event.target.value;

    if (this.searchWord.length > 1) {
      searchCaseRecordsByPriority({ searchKey: this.searchWord })
        .then((result) => {
          console.log(result);
          this.cases = result;
        })
        .catch((error) => {
          console.error(error);
          this.error = error;
        });
    } else {
      this.cases = undefined;
      this.error = undefined;
    }
  }
}