import { LightningElement } from "lwc";

import ACCOUNT_OBJECT from "@salesforce/schema/Account";

import Name from "@salesforce/schema/Account.Name";
import Type from "@salesforce/schema/Account.Type";
import Industry from "@salesforce/schema/Account.Industry";
import AnnualRevenue from "@salesforce/schema/Account.AnnualRevenue";

export default class RecordViewForm extends LightningElement {
  showContent = true;

  recordId = "0018b000026d86mAAA";
  objectName = ACCOUNT_OBJECT;
  fields = {
    name: Name,
    type: Type,
    industry: Industry,
    annualRevenue: AnnualRevenue
  };
}