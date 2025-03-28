trigger OpportunityTrigger on Opportunity (before update, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            OpportunityTriggerHelper.validateAmount(Trigger.new);
            OpportunityTriggerHelper.setPrimaryContact(Trigger.new);
        }
        if (Trigger.isDelete) {
            OpportunityTriggerHelper.preventDeletion(Trigger.old);
        }
    }
}