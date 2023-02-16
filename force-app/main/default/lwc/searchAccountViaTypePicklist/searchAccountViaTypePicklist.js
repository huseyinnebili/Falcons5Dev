import { LightningElement } from "lwc";
import getAccountsByType from "@salesforce/apex/AccountCtrl.getAccountsByType";
const COLUMNS = [
  { label: "Account Name", fieldName: "Name" },
  { label: "Type", fieldName: "Type" },
  { label: "Industry", fieldName: "Industry" },
  { label: "Annual Revenue", fieldName: "AnnualRevenue" }
];

export default class SearchAccountViaTypePicklist extends LightningElement {
  columns = COLUMNS;
  accounts;
  selectedType;

  changeHandler(event) {
    this.selectedType = event.target.value;

    getAccountsByType({ type: this.selectedType })
      .then((result) => {
        console.log(result);
        this.accounts = result;
      })
      .catch((error) => {
        console.error(error);
      });
  }

  get typeOptions() {
    return [
      { label: "Prospect", value: "Prospect" },
      { label: "Prospect", value: "Prospect" },
      { label: "Customer - Direct", value: "Customer - Direct" },
      { label: "Customer - Channel", value: "Customer - Channel" },
      {
        label: "Channel Partner / Reseller",
        value: "Channel Partner / Reseller"
      },
      { label: "Installation Partner", value: "Installation Partner" },
      { label: "Other", value: "Other" },
      { label: "Customer", value: "Customer" }
    ];
  }
}