package generator;

import java.lang.reflect.Proxy;
import load.LoadInterface;
import handler.MyInvocationHandler;

public class Generator {

    public Object generateObjectsFunction (){

        //Array of managed classes that share an interface
        Class<?> [] list = new Class<?>[2];
        try {
            list[0] = Class.forName("load.LoadLeagues");
            list[1] = Class.forName("load.LoadLeaguesAdaptation");

        } catch (ClassNotFoundException e) {
            android.util.Log.d("LeaguesOfTheWorld", e.getMessage());
        }

        try {
            LoadInterface myProxy = (LoadInterface) Proxy.newProxyInstance(
                    LoadInterface.class.getClassLoader(), new Class[]{LoadInterface.class},
                    new MyInvocationHandler(list));

            return myProxy;
        } catch (Exception e){
            android.util.Log.d("LeaguesOfTheWorld", e.getMessage());
        }

        return null;
    }
}
