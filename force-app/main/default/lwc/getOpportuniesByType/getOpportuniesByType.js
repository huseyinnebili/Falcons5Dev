import { LightningElement } from "lwc";
import getOpportuniesByType from "@salesforce/apex/AccountCtrl.getOpportuniesByType";

export default class GetOpportuniesByType extends LightningElement {
  selectedType;
  opps;
  error;

  get typeOptions() {
    return [
      {
        label: "Existing Customer - Upgrade",
        value: "Existing Customer - Upgrade"
      },
      {
        label: "Existing Customer - Replacement",
        value: "Existing Customer - Replacement"
      },
      {
        label: "Existing Customer - Downgrade",
        value: "Existing Customer - Downgrade"
      },
      { label: "New Customer", value: "New Customer" }
    ];
  }

  changeHandler(event) {
    this.selectedType = event.target.value;

    getOpportuniesByType({ type: this.selectedType })
      .then((result) => {
        console.log(result);
        this.opps = result;
      })
      .catch((error) => {
        console.log(error);
        this.error = error;
      });
  }
}