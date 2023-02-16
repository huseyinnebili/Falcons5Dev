import { LightningElement, wire } from "lwc";
import CASE from "@salesforce/schema/Case";
import Priority from "@salesforce/schema/Case.Priority";
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";

export default class GetObjectInfoCaseObject extends LightningElement {
  saleDepRecordType;
  techDepRecordType;
  error;
  priorityOptions = [];
  value;

  @wire(getObjectInfo, { objectApiName: CASE })
  cases({ data, error }) {
    if (data) {
      console.log(data);

      this.saleDepRecordType = data.defaultRecordTypeId;

      const recordTypeIDs = data.recordTypeInfos;
      this.techDepRecordType = Object.keys(recordTypeIDs).find(
        (recordTypeID) => recordTypeIDs[recordTypeID].name === "Sale Department"
      );
    }
    if (error) {
      console.log(error);
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    fieldApiName: Priority,
    recordTypeId: "$techDepRecordType"
  })
  casePicklist({ data, error }) {
    if (data) {
      this.priorityOptions = this.picklistGenerator(data);
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