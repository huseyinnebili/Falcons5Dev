import { LightningElement } from "lwc";
import getOpportuniesByType from "@salesforce/apex/AccountCtrl.getOpportuniesByType";

const COLUMNS = [
  { label: "Opportunity Name", fieldName: "Name", type: "text" },
  { label: "Close Date", fieldName: "CloseDate", type: "date" },
  { label: "Expected Revenue", fieldName: "ExpectedRevenue", type: "currency" },
  { label: "Lead Source", fieldName: "LeadSource", type: "text" },
  { label: "Stage", fieldName: "StageName", type: "text" }
];
export default class SelectOppByType extends LightningElement {
  selectedType;
  opps;
  columns = COLUMNS;

  changeHandler(event) {
    this.selectedType = event.target.value;

    getOpportuniesByType({ type: this.selectedType })
      .then((result) => {
        this.opps = result;
      })
      .catch((error) => {
        this.error = error;
      });
  }
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
}