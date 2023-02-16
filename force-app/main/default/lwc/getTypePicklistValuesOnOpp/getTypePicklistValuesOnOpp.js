import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import OPPORTUNITY_OBJECT from "@salesforce/schema/Opportunity";
import Type_Field from "@salesforce/schema/Opportunity.Type";

export default class GetTypePicklistValuesOnOpp extends LightningElement {
  error;
  customRecordTypeId;
  homeRecordTypeId;
  typeOptions = [];
  value;
  kithcenRecordTypeId;

  @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
  oppObjectInfo({ data, error }) {
    if (data) {
      console.log(data);
      this.customRecordTypeId = data.defaultRecordTypeId;

      const recordTypeIDs = data.recordTypeInfos;
      this.homeRecordTypeId = Object.keys(recordTypeIDs).find(
        (recordTypeID) => recordTypeIDs[recordTypeID].name === "Home Appliances"
      );
      this.kithcenRecordTypeId = Object.keys(recordTypeIDs).find(
        (recordTypeID) =>
          recordTypeIDs[recordTypeID].name === "Kitchen Appliances"
      );
    }

    if (error) {
      console.error(error);
      this.error = error;
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$kithcenRecordTypeId",
    fieldApiName: Type_Field
  })
  typePcklistValues({ data, error }) {
    if (data) {
      this.typeOptions = this.picklistGenerator(data);
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