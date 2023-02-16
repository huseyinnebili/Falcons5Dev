import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import ACCOUNT from "@salesforce/schema/Account";

export default class GetObjectInfoAccount extends LightningElement {
  customRecordTypeId;
  vendorRecordTypeId;
  error;

  @wire(getObjectInfo, { objectApiName: ACCOUNT })
  accountInfoHandler({ data, error }) {
    if (data) {
      this.customRecordTypeId = data.defaultRecordTypeId;
      const recordTypeIDs = data.recordTypeInfos;
      this.vendorRecordTypeId = Object.keys(recordTypeIDs).find(
        (recordTypeID) => recordTypeIDs[recordTypeID].name === "Vendor"
      );
    }
    if (error) {
      this.error = error;
    }
  }
}