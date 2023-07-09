import { LightningElement } from 'lwc';

export default class Augmentor extends LightningElement {
    startCounter = 0;
    counter = 0;
    handleStartChange(event) {
      this.startCounter = parseInt(event.target.value);
    }
    addCounter(event) {
      this.counter = parseInt(event.target.value);
    }
    handleMaximizeCounter() {
      this.template.querySelector('c-numerator').maximizeCounter(this.counter);
    }
}