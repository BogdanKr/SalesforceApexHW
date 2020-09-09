/**
 * Created by Bogdan on 09.09.2020.
 */

public with sharing class LeadProcessor implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    public void execute(Database.BatchableContext param1, List<Lead> param2) {
//        List<Lead> leads = new List<Lead>();
        for (Lead lead : param2){
            lead.LeadSource = 'Dreamforce';
//            leads.add(lead);
        }
        update param2;
    }

    public void finish(Database.BatchableContext param1) {
    }

}