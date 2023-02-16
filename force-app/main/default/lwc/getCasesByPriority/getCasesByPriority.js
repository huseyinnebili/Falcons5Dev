import { LightningElement, wire } from "lwc";
import getCasesByPriority from "@salesforce/apex/AccountCtrl.getCasesByPriority";

const COLUMNS = [
  { label: "Case Origin", fieldName: "Origin", type: "text" },
  { label: "Case Reason", fieldName: "Reason", type: "text" },
  { label: "Contact Email", fieldName: "ContactEmail", type: "text" },
  { label: "Priority", fieldName: "Priority", type: "text" },
  { label: "Status", fieldName: "Status", type: "text" }
];

export default class GetCasesByPriority extends LightningElement {
  casePriority = "Medium";
  columns = COLUMNS;

  @wire(getCasesByPriority, { priority: "$casePriority" })
  cases;
}