import { LightningElement } from "lwc";
import searchOpportunity from "@salesforce/apex/AccountCtrl.searchOpportunity";

export default class SearchOpportunity extends LightningElement {
  searchWord;
  opportunities;
  error;

  searchHandler(event) {
    this.searchWord = event.target.value;
    if (this.searchWord.length > 1) {
      searchOpportunity({ searchKey: this.searchWord })
        .then((result) => {
          console.log(result);
          this.opportunities = result;
        })
        .catch((error) => {
          console.error(error);
          this.error = error;
        });
    } else {
      this.opportunities = undefined;
      this.error = undefined;
    }
  }
}