trigger OpportunityTrigger on Opportunity (after update) {
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    handler.run();
}