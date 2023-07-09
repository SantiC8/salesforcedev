import { LightningElement, api } from 'lwc';
import{OmniscriptBaseMixin} from 'omnistudio/omniscriptBaseMixin';

const columns = [
    { label: 'Contact Name', fieldName: 'Name', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
];

export default class IpCallWithParams extends OmniscriptBaseMixin(LightningElement) {

    @api recordId;
    data = [];
    columns = columns;

    connectedCallback() {
        // llamar al Ip obteniendo el recordId de la page
        const input = {
            recordId: this.recordId,
        };

        const params = {
            input: JSON.stringify(input),
            sClassName: `IntegrationProcedureService`,
            sMethodName: `IP_GetContactsByAccountId`,
            options: "{}",
        };

        this.omniRemoteCall(params, false)
            .then((response) => {
                console.log('Result: ' +  JSON.stringify(response.result.IPResult.contacts));
                this.data = response.result.IPResult.contacts;
            })
            .catch((error) => {
                window.console.log(error, "error");
            });
    }
}