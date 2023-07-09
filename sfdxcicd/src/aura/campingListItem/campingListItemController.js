({
    packItem  : function(component, event, helper) {
        var item = component.get("v.item");
        item.Packed__c = true;
        component.set("v.item", item);
        var btnClick = event.getSource();
        btnClick.set("v.disabled", true);
    }
})