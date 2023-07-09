import { LightningElement } from 'lwc';
import retriveNews from '@salesforce/apex/NewsController.retriveNews';

export default class NewsComponent extends LightningElement {

    connectedCallback(){
        this.fetchNews();
    }

    fetchNews(){
        retriveNews()
        .then( response => {
            console.log(response);
        })
        .catch(error => {
            console.log(error);
        });
    }
}