import { LightningElement, api } from 'lwc';

export default class CustomTypeName extends LightningElement {
    @api recordId;
    @api name;

    fireCustomTypeName() {

        const event = new CustomEvent('redirect', {
            composed: true,
            bubbles: true,
            cancelable: true,
            detail: {
                recordId: this.recordId
            },
        });

        this.dispatchEvent(event);
    }
}