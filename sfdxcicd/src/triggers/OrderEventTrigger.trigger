trigger OrderEventTrigger on Order_Event__e (after insert) {
	// List to hold all cases to be created.
    List<Task> tareas = new List<Task>();
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create task to dispatch new team.
            Task tarea = new Task();
            tarea.Priority = 'Medium';
            tarea.Subject =  'Follow up on shipped order 105';
            tarea.OwnerId = event.CreatedById;
            tareas.add(tarea);
        }
   }
    // Insert all task corresponding to events received.
    insert tareas;
}