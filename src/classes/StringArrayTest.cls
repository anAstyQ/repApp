public class StringArrayTest {
    public static List<String> generateStringArray(Integer n){
        if(n == 0) System.debug('n = 0 -> an empty List!');
        List<String> res = new List<String>();
        for(Integer i=0; i<n; i++){
            res.add('Test ' + i);
            //System.debug(res[i]);
        }
        return res;
    }
}