import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import CASE_OBJECT from "@salesforce/schema/Case";
import Reason_Field from "@salesforce/schema/Case.Reason";

export default class GetReasonPicklistValuesOnCase extends LightningElement {
  customRecordTypeId;
  saleRecordTypeId;
  reasonOptions = [];
  error;
  value;

  @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
  caseObjectInfo({ data, error }) {
    if (data) {
      this.customRecordTypeId = data.defaultRecordTypeId;

      const recordTypeIDs = data.recordTypeInfos;
      this.saleRecordTypeId = Object.keys(recordTypeIDs).find(
        (recordTypeID) => recordTypeIDs[recordTypeID].name === "Sale Department"
      );
      console.log(data);
    }

    if (error) {
      console.error(error);
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$saleRecordTypeId",
    fieldApiName: Reason_Field
  })
  reasonPicklistValues({ data, error }) {
    if (data) {
      console.log(data);
      this.reasonOptions = this.picklistGenerator(data);
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