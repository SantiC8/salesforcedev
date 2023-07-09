import { LightningElement, api, track } from 'lwc';
import{OmniscriptBaseMixin} from 'omnistudio/omniscriptBaseMixin'

export default class DatatableSelectable extends OmniscriptBaseMixin(LightningElement) {
    selectedRows = [];
    @api myrecords;
    @track records;

    
    connectedCallback() {
        let data = {selectedRows:this.selectedRows};
        this.omniApplyCallResp(data);

        this.template.addEventListener('selectrow', evt =>{
            console.log('selectrow event', JSON.stringify(evt.detail.result));            
            if(evt.detail.result.selectrow){
                this.selectedRows.push(evt.detail.result);                
            }
            else if(evt.detail.result === "none"){
                this.selectedRows = [];                              
            }
            else if(evt.detail.result === "all"){               
                this.allSelected();                              
            }
            else{
                this.selectedRows.forEach(function(item, index, object){
                    if(item.uniqueKey === evt.detail.result.uniqueKey){
                        object.splice(index,1);
                    }
                });               
            }
            data = {selectedRows:this.selectedRows};
            console.log('SelectedRows ', JSON.stringify(data));            
            this.omniApplyCallResp(data);
        });       
    }
   
    
    allSelected(){
      if( this.records == undefined|| this.records == null ){
         this.setRecords();
      }
      this.selectedRows = [...this.records];

    }
    
    setRecords(){
      this.records =[];

      if(Array.isArray(this.myrecords)){      
         this.selectedRows = [];
         for (let index = 0; index < this.myrecords.length; index++) {
            let item ={};
            let record = this.myrecords[index];
            let uniqueKey = 'REC'+ index;
            let flex = {"uniqueKey": uniqueKey }
            item['uniqueKey'] = uniqueKey;
            item["originalIndex"] = index;
            item["_flex"] = flex;
            item["selectrow"] = true;
            item = {...item, ...record};
            this.records.push(item);
         }
      }
    }

}