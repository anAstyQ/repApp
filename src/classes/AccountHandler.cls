public class AccountHandler {
	String strAccountName = '';
    public static Account insertNewAccount(String strAccountName){
        try{
        	Account acct = new Account(Name = strAccountName);
        	insert acct;
        	return acct;
        } catch (DmlException e){
    		return null;
        }      
    }
}