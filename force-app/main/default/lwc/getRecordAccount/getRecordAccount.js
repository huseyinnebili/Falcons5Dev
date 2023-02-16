import { getRecord } from "lightning/uiRecordApi";
import { LightningElement, wire } from "lwc";

import Name from "@salesforce/schema/Account.Name";
import Type from "@salesforce/schema/Account.Type";
import Industry from "@salesforce/schema/Account.Industry";
import AnnualRevenue from "@salesforce/schema/Account.AnnualRevenue";
import Rating from "@salesforce/schema/Account.Rating";
import AccountNumber from "@salesforce/schema/Account.AccountNumber";

const FIELDS = [Name, Type, Industry, AnnualRevenue, Rating, AccountNumber];

export default class GetRecordAccount extends LightningElement {
  recordId = "0018V00002PaRzaQAF";
  accName;
  accType;
  accIndustry;
  accAnnualRevenue;
  accRating;
  accAccountNumber;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  accountHandle({ data, error }) {
    console.log(data);

    if (data) {
      console.log(data);
      this.accName = data.fields.Name.value;
      this.accType = data.fields.Type.value;
      this.accIndustry = data.fields.Industry.value;
      this.accAnnualRevenue = data.fields.AnnualRevenue.value;
      this.accAccountNumber = data.fields.AccountNumber.value;
      this.accRating = data.fields.Rating.value;
    }
    if (error) {
      console.log(error);
    }
  }
}