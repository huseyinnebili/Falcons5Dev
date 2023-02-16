import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import Industry_Field from "@salesforce/schema/Account.Industry";

export default class GetIndustryPicklistValuesOnAccount extends LightningElement {
  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  accountObjectInfo;
  industryOptions;
  error;
  value;

  @wire(getPicklistValues, {
    recordTypeId: "$accountObjectInfo.data.defaultRecordTypeId",
    fieldApiName: Industry_Field
  })
  industryPicklistValues({ data, error }) {
    if (data) {
      this.industryOptions = this.picklistGenerator(data);

      console.log(data);
    }

    if (error) {
      console.error(error);
      this.error = error;
    }
  }

  picklistGenerator(data) {
    return data.values.map((item) => ({
      label: item.label,
      value: item.value
    }));
  }

  handleChange(event) {
    this.value = event.detail.value;
  }
}