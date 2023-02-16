import { LightningElement, wire } from "lwc";
import getOpportunies from "@salesforce/apex/AccountCtrl.getOpportunies";
const COLUMNS = [
  { label: "Opportunity Name", fieldName: "Name", type: "text" },
  { label: "Close Date", fieldName: "CloseDate", type: "date" },
  { label: "Expected Revenue", fieldName: "ExpectedRevenue", type: "currency" },
  { label: "Lead Source", fieldName: "LeadSource", type: "text" }
];
export default class GetOpportunityRecord extends LightningElement {
  columns = COLUMNS;
  @wire(getOpportunies)
  opportunities;
}