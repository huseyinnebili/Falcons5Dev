import { LightningElement, wire } from "lwc";
import getContactByLeadSource from "@salesforce/apex/AccountCtrl.getContactByLeadSource";

const COLUMNS = [
  { label: "Lead Source", fieldName: "LeadSource", text: "text" },
  { label: "Last Name", fieldName: "LastName", text: "text" },
  { label: "Phone", fieldName: "Phone", text: "text" },
  { label: "Email", fieldName: "Email", text: "text" },
  { label: "Status", fieldName: "Status__c", text: "text" }
];
export default class GetContactByLeadSource extends LightningElement {
  ontactLeadSource = "Employee Referral";
  columns = COLUMNS;

  @wire(getContactByLeadSource, { leadSource: "$ontactLeadSource" })
  contacts;
}