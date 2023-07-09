import LightningDatatable from 'lightning/datatable';
import customTypeName from './templates/customTypeName.html';

export default class CustomDatatable extends LightningDatatable {
    static customTypes = {
        customTypeName: {
            template: customTypeName,
            typeAttributes: ['name', 'Id']
        }
    }
}