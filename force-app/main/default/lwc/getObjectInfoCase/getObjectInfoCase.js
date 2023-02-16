import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";

import CASE from "@salesforce/schema/Case";
import Priority from "@salesforce/schema/Case.Priority";

export default class GetObjectInfoCase extends LightningElement {
  saleDepRecordType;
  techDepRecordType;
  error;
  priorityOptions = [];
  value;

  @wire(getObjectInfo, { objectApiName: CASE })
  caseObjectInfo({ data, error }) {
    if (data) {
      console.log("data", data);
      this.saleDepRecordType = data.defaultRecordTypeId;

      const recordTypeIDs = data.recordTypeInfos;
      this.techDepRecordType = Object.keys(recordTypeIDs).find(
        (recordTypeID) => recordTypeIDs[recordTypeID].name === "Sale Department"
      );
    }

    if (error) {
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    fieldApiName: Priority,
    recordTypeId: "$techDepRecordType"
  })
  casePicklistInfo({ data, error }) {
    if (data) {
      console.log(data);

      this.priorityOptions = this.picklistGenerator(data);
    }
    if (error) {
      console.log(error);
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