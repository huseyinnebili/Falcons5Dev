import { LightningElement, wire } from "lwc";
import getOpportuniesByStage from "@salesforce/apex/AccountCtrl.getOpportuniesByStage";

const COLUMNS = [
  { label: "Opportunity Name", fieldName: "Name", type: "text" },
  { label: "Close Date", fieldName: "CloseDate", type: "date" },
  { label: "Expected Revenue", fieldName: "ExpectedRevenue", type: "currency" },
  { label: "Lead Source", fieldName: "LeadSource", type: "text" },
  { label: "Stage", fieldName: "StageName", type: "text" }
];
export default class GetOpportuniesByStage extends LightningElement {
  columns = COLUMNS;
  oppStage = "Closed Won";

  @wire(getOpportuniesByStage, { StageName: "$oppStage" })
  opportunities;
}