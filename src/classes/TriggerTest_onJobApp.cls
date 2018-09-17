@isTest
public class TriggerTest_onJobApp {
    
    @isTest static void jobAppTriggerTest1(){
        List<Task> tasks1 = [SELECT Id, Subject, Status, OwnerId FROM Task];
		System.assert(tasks1.size() == 0);
        //Name = 'APP-12345'
        Job_Application__c ja = new Job_Application__c();
        	ja.Candidate__c = 'a0C1r00003R2iEaEAJ';														//C-0000          - Candidate__c.Name
        	ja.Position__c = 'a0F1r0000286R63EAE';														//Super Sales Rep - Position__c.Name
            
        insert ja;
        	ja.Status__c = 'Closed';
        	ja.Stage__c = 'Closed - Rejected';
        	
        update ja;
        
        ID ownId = ja.OwnerId;
         
        tasks1 = [SELECT Id, Subject, Status, OwnerId FROM Task];
        System.assert(tasks1.size() == 1);
        System.assert(tasks1[0].Status == 'Not Started');
        system.debug('@@@@@@@@@@@@  ' + tasks1[0]);
        System.assert(tasks1[0].Subject == 'Send Rejection Letter');
    }
    
    @isTest static void jobAppTriggerTest2(){															
        List<Task> tasks1 = [SELECT Id, Subject, Status, OwnerId FROM Task];
		System.assert(tasks1.size() == 0);
        Job_Application__c ja = new Job_Application__c();
        	ja.Candidate__c = 'a0C1r00003R2iEaEAJ';														//C-0000          - Candidate__c.Name
        	ja.Position__c = 'a0F1r0000286R63EAE';														//Super Sales Rep - Position__c.Name
            
        insert ja;
        
        	ja.Status__c = 'Hold';
        	ja.Stage__c = 'Offer Extended';
        update ja;
        
        ID ownId = ja.OwnerId;
         
        tasks1 = [SELECT Id, Subject, Status, OwnerId FROM Task];
        System.assert(tasks1.size() == 1);
        System.assert(tasks1[0].Status == 'Not Started');
        system.debug('@@@@@@@@@@@@  ' + tasks1[0]);
        System.assert(tasks1[0].Subject == 'Extend an Offer');
    }

}