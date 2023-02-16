import { LightningElement, wire, track } from "lwc";
import getAccounts from "@salesforce/apex/contactListViewHelper.getAccounts";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { updateRecord } from "lightning/uiRecordApi";
import { refreshApex } from "@salesforce/apex";
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import Account_Object from "@salesforce/schema/Opportunity";
import Industry_Field from "@salesforce/schema/Opportunity.LeadSource";

const ACTIONS = [{ label: "Delete", name: "delete" }];

const COLUMNS = [
  {
    label: "Name",
    fieldName: "Name",
    type: "text",
    editable: true
  },
  {
    label: "Phone",
    fieldName: "Phone",
    type: "phone",
    editable: true
  },
  {
    label: "Industry",
    fieldName: "Industry",
    type: "industryPicklist",
    editable: true,
    typeAttributes: {
      options: { fieldName: "picklistOptions" },
      value: { fieldName: "Industry" },
      placeholder: "Choose Industry",
      context: { fieldName: 'Id' }
    }
  },
  {
    label: "Type",
    fieldName: "Type",
    type: "List",
    editable: true
  },
  {
    label: "Continent",
    fieldName: "Continent__c",
    type: "List",
    editable: true
  },
  {
    label: "Countries",
    fieldName: "Countries__c",
    type: "List",
    editable: true
  },
  {
    label: "Description",
    fieldName: "Type",
    type: "text",
    editable: true
  },
  {
    label: "Employee Shift",
    fieldName: "Employee_Shift",
    type: "text",
    editable: true
  },
  {
    label: "SLA Expiration Date",
    fieldName: "SLAExpirationDate__c",
    type: "date",
    editable: true
  },
  {
    fieldName: "actions",
    type: "action",
    editable: true,
    typeAttributes: { rowActions: ACTIONS }
  }
];
export default class ContactListViewHelper extends LightningElement {
  columns = COLUMNS;
  fldsItemValues = [];
  accountIndustry = [];
  @track accObj;

  @wire(getObjectInfo, { objectApiName: Account_Object })
  objectInfo;

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: Industry_Field
  })
  TypePicklistValues({ data, error }) {
    if (data) {
      this.accountIndustry = data.values;
      this.fetchAccounts();
    } else if (error) {
      console.error(error);
    }
  }

  fetchAccounts() {}
  @wire(getAccounts)
  cons(result) {
    this.accObj = result;
    if (result.error) {
      this.accObj = undefined;
    }
  }

  saveHandleAction(event) {
    this.fldsItemValues = event.detail.draftValues;

    const inputItems = this.fldsItemValues.slice().map((draft) => {
      const fields = Object.assign({}, draft);
      return { fields };
    });

    const promises = inputItems.map((recordInput) => updateRecord(recordInput));
    Promise.all(promises)
      .then((result) => {
        console.log(result);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Records Updated Successfully!!",
            variant: "success"
          })
        );
        this.fieldItemValues = [];
        return this.refresh();
      })
      .catch((error) => {
        console.error(error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: "An Error Occured!!",
            variant: "error"
          })
        );
      })
      .finally(() => {
        this.fldsItemValues = [];
      });
  }

  async refresh() {
    await refreshApex(this.accObj);
  }
}