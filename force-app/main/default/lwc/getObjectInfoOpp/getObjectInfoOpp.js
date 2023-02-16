import { LightningElement, wire } from "lwc";

//import OPPORTUNITY from "@salesforce/schema/Opportunity";
import Type from "@salesforce/schema/Opportunity.Type";

import { getPicklistValues } from "lightning/uiObjectInfoApi";

export default class GetObjectInfoOpp extends LightningElement {
  //   homeRecordTypeId;
  //   kitchenRecordTypeId;
  //   error;
  //   industryOptions = [];
  //   selectedIndustry;

  //   @wire(getObjectInfo, { objectApiName: OPPORTUNITY })
  //   opportunityInfoHandler({ data, error }) {
  //     if (data) {
  //       this.homeRecordTypeId = data.defaultRecordTypeId;

  //       const recordTypeIds = data.recordTypeInfos;

  //       this.kitchenRecordTypeId = Object.keys(recordTypeIds).find(
  //         (recordTypeId) =>
  //           recordTypeIds[recordTypeId].name === "Kitchen Appliances"
  //       );
  //     }

  //     if (error) {
  //       this.error = error;
  //     }
  //   }

  @wire(getPicklistValues, {
    fieldName: Type,
    recordTypeId: "0128b000000dCmCAAU"
  })
  picklistValue;
  //   picklistHandler({ data, error }) {
  //     if (data) {
  //       console.log(data);
  //       this.industryOptions = this.picklistGenerator(data);
  //     }

  //     if (error) {
  //       console.log(error);
  //       this.error = error;
  //     }
  //   }

  //   picklistGenerator(data) {
  //     return data.values.map((item) => ({
  //       label: item.label,
  //       value: item.value
  //     }));
}