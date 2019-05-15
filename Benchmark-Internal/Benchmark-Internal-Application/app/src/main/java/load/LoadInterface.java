package load;

import java.io.File;

public interface LoadInterface {

    boolean  loadLeagues();
    void read (File f);
    int positionOf (String league);
    String getLeague (int pos);

}
