import { LightningElement, wire, track } from "lwc";

import { getPicklistValues } from "lightning/uiObjectInfoApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import Opportunity_Object from "@salesforce/schema/Opportunity";
import LeadSource from "@salesforce/schema/Opportunity.LeadSource";
export default class GetPicklistValueSample extends LightningElement {
  @track value;

  @wire(getObjectInfo, { objectApiName: Opportunity_Object })
  objectInfo;

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: LeadSource
  })
  TypePicklistValues;

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: LeadSource
  })
  IndustryPicklistValues({ data, error }) {
    if (data) {
      console.log(data);
    }

    if (error) {
      this.error = error;
    }
  }

  handleChange(event) {
    this.value = event.target.value;
  }
}