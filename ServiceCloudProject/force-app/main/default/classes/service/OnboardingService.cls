public with sharing class OnboardingService {
    
    public static void processOnboarding(List<Opportunity> opps){

        List<Entitlement> entToInsert = new List<Entitlement>();
        List<Case> caseToInsert = new List<Case>();


        //Query para buscar os Processos de Direitos
        SlaProcess standard = [SELECT Id, Name FROM SlaProcess WHERE Name = 'Processo de Onboarding Padrão'];
        SlaProcess premium = [SELECT Id, Name FROM SlaProcess WHERE Name = 'Processo de Onboarding Premium'];

        /* Itera sobre a Lista de Oportunidades recebidas do Handler 
           Cria um Direito e Atribui um Processo de acordo com o valor da Oportunidade
        **/
        for(Opportunity opportunities : opps){
            
            Entitlement ent = new Entitlement(
                Name = 'Direito de Suporte - ' + opportunities.Name,
                AccountId = opportunities.AccountId,
                StartDate = System.today(),
                EndDate = System.today().addYears(1)
                
            );

                if(opportunities.Amount >= 50000){
                    ent.SlaProcessId = premium.Id;
                } else {
                    ent.SlaProcessId = standard.Id;
                }
                entToInsert.add(ent);
                
                //Processo de criação do Case de Onboarding
                Case onboardingCase = new Case();
                onboardingCase.Subject = 'Onboarding ' + opportunities.Name;
                onboardingCase.Origin = 'Close Won Deal';
                onboardingCase.AccountId = opportunities.AccountId;
                onboardingCase.Status = 'New';
                caseToInsert.add(onboardingCase);
        }
        //DML único 
        insert entToInsert;
        insert caseToInsert;

        createOnboardingChecklist(caseToInsert);
    }
    
    //Criação das tarefas de onboarding
    public static void createOnboardingChecklist(List<Case> cases){

        List<Onboarding_Checklist__c> checklistToInsert = new List<Onboarding_Checklist__c>();

        for(Case cs : cases){

            Onboarding_Checklist__c check = new Onboarding_Checklist__c(
                Name = 'Kick-off',
                Caso__c = cs.Id,
                Conta__c = cs.AccountId,
                Due_Date__c = System.today().addDays(3),
                Status__c = 'Pending'
            );
            checklistToInsert.add(check);
            Onboarding_Checklist__c check2 = new Onboarding_Checklist__c(
                Name = 'Liberação de Acesso',
                Caso__c = cs.Id,
                Conta__c = cs.AccountId,
                Due_Date__c = System.today().addDays(7),
                Status__c = 'Pending'
            );
            checklistToInsert.add(check2);
        }
        insert checklistToInsert;

    }
}