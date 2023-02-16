import { LightningElement } from "lwc";
import searchAccountsByRating from "@salesforce/apex/AccountCtrl.searchAccountsByRating";
export default class SearchAccountsByRating extends LightningElement {
  selectedRating;
  accounts;
  error;

  get ratingOptions() {
    return [
      { label: "Hot", value: "Hot" },
      { label: "Warm", value: "Warm" },
      { label: "Cold", value: "Cold" }
    ];
  }

  changeHandler(event) {
    this.selectedRating = event.target.value;

    searchAccountsByRating({
      rating: this.selectedRating
    })
      .then((result) => {
        console.log(result);
        this.accounts = result;
      })
      .catch((error) => {
        console.error(error);
        this.error = error;
      });
  }
}