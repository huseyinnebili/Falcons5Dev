import { LightningElement } from "lwc";
import getOpportuniesByStage from "@salesforce/apex/AccountCtrl.getOpportuniesByStage";
const COLUMNS = [
  { label: "Opportunity Name", fieldName: "Name", type: "text" },
  { label: "Close Date", fieldName: "CloseDate", type: "date" },
  { label: "Expected Revenue", fieldName: "ExpectedRevenue", type: "currency" },
  { label: "Lead Source", fieldName: "LeadSource", type: "text" },
  { label: "Stage", fieldName: "StageName", type: "text" }
];
export default class ParentActionOpportuniesByStage extends LightningElement {
  selectedStage;
  opps;
  columns = COLUMNS;

  changeHandler(event) {
    this.selectedStage = event.target.value;
    getOpportuniesByStage({ StageName: this.selectedStage })
      .then((result) => {
        this.opps = result;
      })
      .catch((error) => {
        this.error = error;
      });
  }

  get stageOptions() {
    return [
      {
        label: "Prospecting",
        value: "Prospecting"
      },
      {
        label: "Qualification",
        value: "Qualification"
      },
      {
        label: "Needs Analysis",
        value: "Needs Analysis"
      },
      { label: "Value Proposition", value: "Value Proposition" },
      {
        label: "Id. Decision Makers",
        value: "Id. Decision Makers"
      },
      {
        label: "Perception Analysis",
        value: "Perception Analysis"
      },
      {
        label: "Proposal/Price Quote",
        value: "Proposal/Price Quote"
      },
      {
        label: "Negotiation/Review",
        value: "Negotiation/Review"
      },
      {
        label: "Closed Won",
        value: "Closed Won"
      },
      {
        label: "Closed Lost",
        value: "Closed Lost"
      }
    ];
  }
}