public with sharing class OpportunityTriggerHandler {
    
    private List<Opportunity> newOpp = Trigger.new;
    private Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;

    public void run (){
        if(Trigger.isAfter){
            if (Trigger.isUpdate) { afterUpdate(); }
        }
    }

    private void afterUpdate(){

        for (Opportunity opp : newOpp){

            Opportunity old = oldMap.get(opp.Id);
            if(opp.StageName == 'Closed Won'){
                if(opp.StageName != old.StageName){
                    OnboardingService.processOnboarding(newOpp);
                }
            }
        }
    }
}