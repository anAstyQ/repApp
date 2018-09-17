public class ContactSearch {
      
    public static List<Contact> searchForContacts(String lName, String pCode){
        List<Contact> lContact = [SELECT Name, Id FROM Contact WHERE (LastName =: lName AND MailingPostalCode =: pCode)];
        return lContact;
    }
}