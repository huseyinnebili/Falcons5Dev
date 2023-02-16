import { LightningElement } from "lwc";

import CONTACT from "@salesforce/schema/Contact";
import FirstName from "@salesforce/schema/Contact.FirstName";
import LastName from "@salesforce/schema/Contact.LastName";
import AccountName from "@salesforce/schema/Contact.AccountId";
import Title from "@salesforce/schema/Contact.Title";
import Phone from "@salesforce/schema/Contact.Phone";
import Department from "@salesforce/schema/Contact.Department";

export default class RecordViewFormContact extends LightningElement {
  showContent = true;
  recordId = "0038b00002nI5HvAAK";
  objectName = CONTACT;
  fields = {
    firstName: FirstName,
    lastName: LastName,
    accountName: AccountName,
    title: Title,
    phone: Phone,
    department: Department
  };
}