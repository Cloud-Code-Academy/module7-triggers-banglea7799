trigger AccountTrigger on Account (before insert, after insert) {
    if (Trigger.isBefore) {
        AccountTriggerHelper.setDefaultValues(Trigger.new);
    }
    
    if (Trigger.isAfter) {
        AccountTriggerHelper.createDefaultContacts(Trigger.new);
    }
}