import { LightningElement, wire } from "lwc";

import ACCOUNT from "@salesforce/schema/Account";
import Industry from "@salesforce/schema/Account.Industry";

import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";

export default class GetAccountPicklistValues extends LightningElement {
  customRecordTypeId;
  vendorRecordTypeId;
  error;
  industryOptions = [];
  selectedIndustry;

  @wire(getObjectInfo, { objectApiName: ACCOUNT })
  accountObjectInfo({ data, error }) {
    if (data) {
      this.customRecordTypeId = data.defaultRecordTypeId;

      const recordTpeIDs = data.recordTypeInfos;
      this.vendorRecordTypeId = Object.keys(recordTpeIDs).find(
        (recordTpeID) => recordTpeIDs[recordTpeID].name === "Vendor"
      );
    }

    if (error) {
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    fiedlApiName: Industry,
    recordTypeId: "0128V000001NuQUQA0"
  })
  getAccountPicklistInfo({ data, error }) {
    if (data) {
      console.log(data);
      this.industryOptions = this.picklistGenerator(data);
    }

    if (error) {
      console.log(error);
      this.error = error;
    }
  }

  picklistGenerator(data) {
    return data.values.map((item) => ({
      label: item.label,
      value: item.value
    }));
  }
}