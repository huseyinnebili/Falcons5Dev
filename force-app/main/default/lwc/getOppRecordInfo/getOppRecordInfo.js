import { LightningElement, wire, track } from "lwc";

import Opportunity from "@salesforce/schema/Opportunity";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

export default class GetOppRecordInfo extends LightningElement {
  @wire(getObjectInfo, { objectApiName: Opportunity })
  objectInfoHandler(data, error) {
    if (data) {
      console.log(data);
    }
    if (error) {
      console.log(error);
    }
  }
}