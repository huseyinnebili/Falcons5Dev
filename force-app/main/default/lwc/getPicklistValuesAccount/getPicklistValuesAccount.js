import { LightningElement, wire } from "lwc";
import ACCOUNT from "@salesforce/schema/Account";
import INDUSTRY from "@salesforce/schema/Account.Industry";
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
export default class GetPicklistValuesAccount extends LightningElement {
  customRecordTypeId;
  vendorRecordTypeId;
  error;
  industryOptions = [];
  selectedIndustry;

  @wire(getObjectInfo, { objectApiName: ACCOUNT })
  accountInfoHandler({ data, error }) {
    if (data) {
      this.customRecordTypeId = data.defaultRecordTypeId;

      const recordTypeIds = data.recordTypeInfos;

      this.vendorRecordTypeId = Object.keys(recordTypeIds).find(
        (recordTypeId) => recordTypeIds[recordTypeId].name === "Vendor"
      );
    }

    if (error) {
      console.log(error);
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    fieldName: INDUSTRY,
    recordTypeId: "$vendorRecordTypeId"
  })
  picklistHandler({ data, error }) {
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