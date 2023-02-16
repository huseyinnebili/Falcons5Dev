import { LightningElement, wire } from "lwc";
import CASE from "@salesforce/schema/Case";
import Type from "@salesforce/schema/Case.Type";
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

export default class GetObjectInfoCaseNew extends LightningElement {
  saleDepartmentRecordTypeId;
  technicalDepartmentRecordTypeId;
  error;
  typeOptions = [];
  selectedTypes;
  value;

  @wire(getObjectInfo, { objectApiName: CASE })
  caseInfoHandler({ data, error }) {
    if (data) {
      console.log("data = ", data);
      this.saleDepartmentRecordTypeId = data.defaultRecordTypeId;

      const recordTypeIDs = data.recordTypeInfos;
      this.technicalDepartmentRecordTypeId = Object.keys(recordTypeIDs).find(
        (recordTypeID) =>
          recordTypeIDs[recordTypeID].name === "Technical Department"
      );
    }
    if (error) {
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    fieldApiName: Type,
    recordTypeId: "$saleDepartmentRecordTypeId"
  })
  picklistHandler({ data, error }) {
    if (data) {
      console.log("data", data);
      this.typeOptions = this.picklistGenerator(data);
    }

    if (error) {
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