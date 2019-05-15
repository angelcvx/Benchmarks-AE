package generator;

import java.lang.reflect.Proxy;
import load.LoadInterface;
import handler.MyInvocationHandler;

public class Generator {

    public Object generateObjectsFunction (){

        Class<?> [] list = new Class<?>[1]; //Array of managed classes that share an interface
        try {
            list[0] = Class.forName("load.LoadLeagues");
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
