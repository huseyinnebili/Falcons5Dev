import { LightningElement, wire } from "lwc";
import getCaseRecords from "@salesforce/apex/CaseCtrl.getCaseRecords";

const COLUMNS = [
  { label: "Case Number", fieldName: "CaseNumber", type: "text" },
  { label: "Case Origin", fieldName: "Origin", type: "text" },
  { label: "Case Reason", fieldName: "Reason", type: "text" },
  { label: "Date/Time Opened", fieldName: "CreatedDate", type: "date" },
  { label: "Priority", fieldName: "Priority", type: "text" },
  { label: "Status", fieldName: "Status", type: "text" }
];
export default class GetCaseRecords extends LightningElement {
  columns = COLUMNS;
  @wire(getCaseRecords)
  cases;
}