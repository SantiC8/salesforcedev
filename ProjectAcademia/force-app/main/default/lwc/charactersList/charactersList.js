import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getData from '@salesforce/apex/PA_ListController.getData';
import NAME_FIELD from '@salesforce/schema/Character__c.Name__c';

const columns = [
    {   label: 'Nombre', 
        fieldName: NAME_FIELD.fieldApiName, 
        type: 'customTypeName', 
        typeAttributes: { 
            name: { fieldName: 'Name__c'},
            Id: {fieldName: 'Id'}
        },
        sortable: "true"
    },
    {   
        label: 'Especie', 
        fieldName: 'Species__c', 
        type: 'text',    
    },
    {   
        label: 'Estado', 
        fieldName: 'Status__c', 
        type: 'text',    
    },
    {   
        label: 'Genero', 
        fieldName: 'Gender__c', 
        type: 'text',    
    },
    {   
        label: 'External Id', 
        fieldName: 'ExtId__c', 
        type: 'text',    
    }
];

export default class CharactersList extends NavigationMixin(LightningElement) {
    @track data = [];
    @track data;
    @track columns = columns;
    @track sortBy;
    @track sortDirection;

    @wire(getData)
    wiredData({error, data}) {
        if (error) {
            // Handle error
        } else if (data) {
            // Process record data
            console.log('data' + data);
            this.data = data;            
        }
    }

    handleRedirect(event) {
        const { recordId } = event.detail;
        console.log('CUSTOM TYPE NAME - ' + recordId);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Character__c',
                recordId: recordId,
                actionName: 'view'
            },
        });
    }

    doSorting(event) {      
        console.log(event.detail, event.detail.value); 
        this.sortBy = event.detail.fieldName;       
        this.sortDirection = event.detail.sortDirection;       
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) { 
        let parseData = JSON.parse(JSON.stringify(this.data));
        let keyValue = (a) => {
            return a[fieldname];
        };
 
       let isReverse = direction === 'asc' ? 1: -1;
           parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; 
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.data = parseData;
    }
}