import {LightningElement, api, wire} from 'lwc';
import searchContactList from '@salesforce/apex/CreateOpportunityRecord.createOpportunity';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class ListViewButton extends LightningElement {
	@api listViewIds;

}