import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import CASE_OBJECT from "@salesforce/schema/Case";

export default class GetPicklistValuesOfCaseObject extends LightningElement {
  customRecordTypeId;
  error;

  @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
  objectInfo({ data, error }) {
    if (data) {
      //   this.customRecordTypeId = data.defaultRecordTypeId;

      //   const recordTypeIds = data.recordTypeInfos;
      console.log(data);
    }

    if (error) {
      this.error = error;
    }
  }
}