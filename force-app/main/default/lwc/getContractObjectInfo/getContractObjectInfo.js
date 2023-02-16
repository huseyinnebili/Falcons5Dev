import { LightningElement, wire, track } from "lwc";
import CONTRACT from "@salesforce/schema/Contract";
import Status from "@salesforce/schema/Contract.Status";
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

export default class GetContractObjectInfo extends LightningElement {
  @track value;

  @wire(getObjectInfo, { objectApiName: CONTRACT })
  objectInfo;
  //({ data, error }) {
  //     if (data) {
  //       this.newRecordTypeId = data.defaultRecordTypeId;

  //       const recordTypeIDs = data.recordTypeInfos;
  //       this.renewalRecordTypeId = Object.keys(recordTypeIDs).find(
  //         (recordTypeID) => recordTypeIDs[recordTypeID].name === "Renewal"
  //       );
  //     }

  //     if (error) {
  //       this.error = error;
  //     }
  //   }

  @wire(getPicklistValues, {
    recordId: "0128V000001NunkQAC",
    fieldName: Status
  })
  statusPicklistValues;

  //   ({ data, error }) {
  //     this.industryOptions = undefined;
  //     if (data) {
  //       this.industryOptions = this.picklistGenerator(data);
  //     }

  //     if (error) this.error = error;
  //   }

  //   picklistGenerator(data) {
  //     return data.values.map((item) => ({
  //       value: item.value,
  //       label: item.value
  //     }));
  //}

  handleChange(event) {
    this.value = event.detail.value;
  }
}