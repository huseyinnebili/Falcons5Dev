import { LightningElement, wire } from "lwc";
import getContacts from "@salesforce/apex/AccountCtrl.getContacts";

const COLUMNS = [
  { label: "Name", fieldName: "Name", type: "text" },
  { label: "Phone", fieldName: "Phone", type: "text" },
  { label: "Title", fieldName: "Title", type: "text" },
  { label: "Email", fieldName: "Email", type: "text" },
  { label: "Department", fieldName: "Department", type: "text" },
  { label: "Birthdate", fieldName: "Birthdate", type: "date" }
];
export default class GetContacts extends LightningElement {
  columns = COLUMNS;
  @wire(getContacts)
  contacts;
}