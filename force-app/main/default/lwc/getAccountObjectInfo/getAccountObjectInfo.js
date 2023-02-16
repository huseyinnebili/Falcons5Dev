import { LightningElement, wire } from "lwc";

import ACCOUNT from "@salesforce/schema/Account";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

export default class GetAccountObjectInfo extends LightningElement {
  customRecordTypeId;
  vendorRecordTypeId;
  error;

  @wire(getObjectInfo, { objectApiName: ACCOUNT })
  accountInfo({ data, error }) {
    if (data) {
      this.customRecordTypeId = data.defaultRecordTypeId;
      console.log(this.customRecordTypeId);

      const recordTypeIDs = data.recordTypeInfos;
      this.vendorRecordTypeId = Object.keys(recordTypeIDs).find(
        (recordTypeID) => recordTypeIDs[recordTypeID].name === "Vendor"
      );
      console.log(this.vendorRecordTypeId);
    }

    if (error) {
      this.error = error;
    }
  }
}