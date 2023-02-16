import { LightningElement } from "lwc";
import searchAccounts from "@salesforce/apex/AccountCtrl.searchAccounts";

const COLUMNS = [
  { label: "Account Name", fieldName: "Name", type: "text" },
  { label: "Type", fieldName: "Type", type: "text" },
  { label: "Industry", fieldName: "Industry", type: "text" },
  { label: "Annual Revenue", fieldName: "AnnualRevenue", type: "currency" },
  { label: "Account Number", fieldName: "AccountNumber", type: "text" }
];

export default class P2cParentAction extends LightningElement {
  searchKey;
  accounts;
  columns = COLUMNS;

  searchHandler(event) {
    this.searchKey = event.target.value;
    searchAccounts({ searchKey: this.searchKey })
      .then((result) => {
        this.accounts = result;
      })
      .catch((error) => {
        console.error(error);
      });
  }
}