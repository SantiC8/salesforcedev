public class AccountUtils {
    public static List<Account>	accountsByState(String stateAbreviation){
        List<Account> accountList = new List<Account>([SELECT Id, Name FROM Account Where BillingState =: stateAbreviation]);
        return accountList;
    }
}