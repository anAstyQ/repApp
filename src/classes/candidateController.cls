public with sharing class candidateController {

	Candidate__c cand {get; set;}

	public Candidate__c getCand(){
		return cand;
	}

	public Candidate__c setCand(){
		return null;
	}
	public candidateController() {
		cand = [SELECT Legacy_Candidate_Number__c,Mobile__c,Zip_Postal_Code__c, Years_of_Experience__c, State_Province__c,  Phone__c,  Email__c, Country__c,Education__c,  Street_Address_1__c, Street_Address_2__c,City__c,  Name, Id, First_Name__c, Last_Name__c FROM Candidate__c
                WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
				System.debug(cand);

	}


}