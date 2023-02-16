import { LightningElement, track, wire } from "lwc";
import fetchAccounts from "@salesforce/apex/AccountDataController.fetchAccounts";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import TYPE_FIELD from "@salesforce/schema/Account.Type";
import Industry_FIELD from "@salesforce/schema/Account.Industry";
import Continent_FIELD from "@salesforce/schema/Account.Continent__c";
import Countries_FIELD from "@salesforce/schema/Account.Countries__c";
import { updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";
import { getPicklistValues, getObjectInfo } from "lightning/uiObjectInfoApi";

const columns = [
  { label: "Name", fieldName: "Name", editable: true },
  { label: "Phone", fieldName: "Phone", type: "phone", editable: true },
  {
    label: "Industry",
    fieldName: "Industry",
    type: "picklistColumn",
    editable: true,
    typeAttributes: {
      placeholder: "Choose Industry",
      options: { fieldName: "IndustrypickListOptions" },
      value: { fieldName: "Industry" }, // default value for picklist,
      context: { fieldName: "Id" } // binding account Id with context variable to be returned back
    }
  },
  {
    label: "Type",
    fieldName: "Type",
    type: "picklistColumn",
    editable: true,
    typeAttributes: {
      placeholder: "Choose Type",
      options: { fieldName: "pickListOptions" },
      value: { fieldName: "Type" }, // default value for picklist,
      context: { fieldName: "Id" } // binding account Id with context variable to be returned back
    }
  },
  {
    label: "Continent",
    fieldName: "softinnovas144__Continent__c",
    type: "picklistColumn",
    editable: true,
    typeAttributes: {
      placeholder: "Choose Continent",
      options: { fieldName: "ContinentpickListOptions" },
      value: { fieldName: "softinnovas144__Continent__c" }, // default value for picklist,
      context: { fieldName: "Id" } // binding account Id with context variable to be returned back
    }
  },
  {
    label: "Countries",
    fieldName: "softinnovas144__Countries__c",
    type: "picklistColumn",
    editable: true,
    typeAttributes: {
      placeholder: "Choose Country",
      options: { fieldName: "CountriespickListOptions" },
      value: { fieldName: "softinnovas144__Countries__c" }, // default value for picklist,
      context: { fieldName: "Id" } // binding account Id with context variable to be returned back
    }
  },
  {
    label: "Description",
    fieldName: "Type",
    type: "text",
    editable: true
  }
];

export default class CustomDatatableDemo extends LightningElement {
  columns = columns;
  showSpinner = false;
  @track data = [];
  @track accountData;
  @track draftValues = [];
  lastSavedData = [];
  @track pickListOptions;
  @track IndustrypickListOptions;
  @track ContinentpickListOptions;
  @track CountriespickListOptions;
  @track CountriespickListData;

  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  objectInfo;

  //fetch picklist options
  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: TYPE_FIELD
  })
  wirePickList({ error, data }) {
    if (data) {
      console.log("HI");
      console.log(data.values);
      this.pickListOptions = data.values;
    } else if (error) {
      console.log("HI ERROR");
      console.log(error);
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: Industry_FIELD
  })
  wirePickList2({ error, data }) {
    if (data) {
      console.log("HI");
      console.log(data.values);
      this.IndustrypickListOptions = data.values;
    } else if (error) {
      console.log("HI ERROR");
      console.log(error);
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: Continent_FIELD
  })
  wirePickList3({ error, data }) {
    if (data) {
      console.log("HI");
      console.log(data.values);
      this.ContinentpickListOptions = data.values;
    } else if (error) {
      console.log("HI ERROR");
      console.log(error);
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: Countries_FIELD
  })
  wirePickList4({ error, data }) {
    if (data) {
      console.log("HI");
      this.CountriespickListData = data;
      console.log(data.values);
      //this.CountriespickListOptions = data.values;
    } else if (error) {
      console.log("HI ERROR");
      console.log(error);
    }
  }

  //here I pass picklist option so that this wire method call after above method
  @wire(fetchAccounts, { pickList: "$pickListOptions" })
  accountData(result) {
    this.accountData = result;
    if (result.data) {
      this.data = JSON.parse(JSON.stringify(result.data));

      this.data.forEach((ele) => {
        ele.pickListOptions = this.pickListOptions;
        ele.IndustrypickListOptions = this.IndustrypickListOptions;
        ele.ContinentpickListOptions = this.ContinentpickListOptions;
        //ele.CountriespickListOptions = this.CountriespickListOptions;
      });

      this.lastSavedData = JSON.parse(JSON.stringify(this.data));
    } else if (result.error) {
      this.data = undefined;
    }
  }

  /*@wire(fetchAccounts, { pickList: '$pickListOptions2' })
    accountData2(result) {
        this.accountData = result;
        if (result.data) {
            this.data = JSON.parse(JSON.stringify(result.data));
 
            this.data.forEach(ele => {
                ele.pickListOptions = this.pickListOptions2;
            })
 
            this.lastSavedData = JSON.parse(JSON.stringify(this.data));
 
        } else if (result.error) {
            this.data = undefined;
        }
    };*/

  updateDataValues(updateItem) {
    let copyData = JSON.parse(JSON.stringify(this.data));

    copyData.forEach((item) => {
      if (item.Id === updateItem.Id) {
        for (let field in updateItem) {
          item[field] = updateItem[field];
        }
      }
    });

    //write changes back to original data
    this.data = [...copyData];
  }

  updateDraftValues(updateItem) {
    let draftValueChanged = false;
    let copyDraftValues = [...this.draftValues];
    //store changed value to do operations
    //on save. This will enable inline editing &
    //show standard cancel & save button
    copyDraftValues.forEach((item) => {
      if (item.Id === updateItem.Id) {
        for (let field in updateItem) {
          item[field] = updateItem[field];
        }
        draftValueChanged = true;
      }
    });

    if (draftValueChanged) {
      this.draftValues = [...copyDraftValues];
    } else {
      this.draftValues = [...copyDraftValues, updateItem];
    }
  }

  //handler to handle cell changes & update values in draft values
  handleCellChange(event) {
    //this.updateDraftValues(event.detail.draftValues[0]);

    let draftValues = event.detail.draftValues;
    if (
      draftValues &&
      Array.isArray(draftValues) &&
      draftValues.length == 1 &&
      draftValues[0].softinnovas144__Continent__c
    ) {
      let key =
        this.CountriespickListData.controllerValues[
          draftValues[0].softinnovas144__Continent__c
        ];
      this.CountriespickListOptions = this.CountriespickListData.values.filter(
        (opt) => opt.validFor.includes(key)
      );
      this.data.forEach((ele) => {
        if (ele.Id == draftValues[0].Id) {
          ele.CountriespickListOptions = this.CountriespickListOptions;
        }
      });

      this.lastSavedData = JSON.parse(JSON.stringify(this.data));
    }

    draftValues.forEach((ele) => {
      this.updateDraftValues(ele);
    });
  }

  handleSave(event) {
    this.showSpinner = true;
    this.saveDraftValues = this.draftValues;
    const recordInputs = this.saveDraftValues.slice().map((draft) => {
      const fields = Object.assign({}, draft);
      return { fields };
    });
    // Updateing the records using the UiRecordAPi
    const promises = recordInputs.map((recordInput) =>
      updateRecord(recordInput)
    );
    Promise.all(promises)
      .then((res) => {
        this.showToast(
          "Success",
          "Records Updated Successfully!",
          "success",
          "dismissable"
        );
        this.draftValues = [];
        return this.refresh();
      })
      .catch((error) => {
        console.log(error);
        this.showToast("Error", "An Error Occured!!", "error", "dismissable");
      })
      .finally(() => {
        this.draftValues = [];
        this.showSpinner = false;
      });
  }

  handleCancel(event) {
    //remove draftValues & revert data changes
    this.data = JSON.parse(JSON.stringify(this.lastSavedData));
    this.draftValues = [];
  }

  showToast(title, message, variant, mode) {
    const evt = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant,
      mode: mode
    });
    this.dispatchEvent(evt);
  }

  // This function is used to refresh the table once data updated
  async refresh() {
    await refreshApex(this.accountData);
  }
}