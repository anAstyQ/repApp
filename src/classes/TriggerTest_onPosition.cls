@isTest
public class TriggerTest_onPosition {
	
    @isTest static void positionTriggerTest1() {
        Position__c p = new Position__c(Name='dude1');
        p.Status__c = 'Closed';
        insert p;
    }
    @isTest static void positionTriggerTest2() {
        Position__c p = new Position__c(Name='dude2');
        p.RecordTypeId = '0121r000000e9SNAAY';    //tech position
        p.Department__c = 'IT';				
        insert p;
	}
    @isTest static void positionTriggerTest3() {
        Position__c p = new Position__c(Name='dude3');
        p.RecordTypeId = '0121r000000e9SSAAY';    //NONtech position
        p.Department__c = 'Support';				
        insert p;
	}
    
    @isTest static void runAsRecruiter(){
        Group newQueue = new Group();
        	newQueue.Name = 'Unclaimed Positions Queue';
        	newQueue.Type = 'Queue';
        insert newQueue;
        System.debug('@@@@@@@@@@        ' + newQueue);
        
        List<User> recruiter = [SELECT id, Name FROM User WHERE Name LIKE 'Renee Moreau' LIMIT 1];
 		System.assert(recruiter.size() == 1);
        User u = recruiter[0];
        System.debug('@@@@@@@@@@       u.Id:  ' + u.Id);
        
        ID hiringID = [SELECT Id, Name FROM User WHERE Name LIKE 'Kathy Cooper' LIMIT 1].Id;
        
        System.runAs(u){
        
        	Position__c p = new Position__c(Name='dude2', Hiring_Manager__c = hiringID, OwnerId = u.Id);
        	insert p;
        	
            List<Position__c> posL = [SELECT Id, Name, CreatedById, OwnerId FROM Position__c];
            
            System.assert(posL.size() == 1);
            System.debug('@@@@@@@@@@       p.OwnerId:  ' + p.OwnerId);
            System.assert(p.OwnerId == u.Id);       
        }        
    }
    @isTest static void runAsSysAdm(){
        Group newQueue = new Group();
        	newQueue.Name = 'Unclaimed Positions Queue';
        	newQueue.Type = 'Queue';
        insert newQueue;     
        
        List<User> sysAdminL = [SELECT id, Name FROM User WHERE Name LIKE 'Anastasia Bezrukava' LIMIT 1];
 		System.assert(sysAdminL.size() == 1);
        User sysAdmin = sysAdminL[0];
        System.debug('@@@@@@@@@@       sysAdmin.Id:  ' + sysAdmin.Id);
        
        ID hiringID = [SELECT Id, Name FROM User WHERE Name LIKE 'Kathy Cooper' LIMIT 1].Id;
        
        System.runAs(sysAdmin){
            Position__c p = new Position__c(
            Name='dude2', 
            Hiring_Manager__c = hiringID
            );
         insert p;
        
        List<Position__c> posL = [SELECT Id, Name, CreatedById, OwnerId FROM Position__c];
            
        System.assert(posL.size() == 1);
        System.debug('@@@@@@@@@@       p.OwnerId:  ' + p.OwnerId);
        System.debug('@@@@@@@@@@       newQueue.Id:  ' + newQueue.Id);
        //System.assert(p.OwnerId == newQueue.Id);  
        
        }            
    }   
}