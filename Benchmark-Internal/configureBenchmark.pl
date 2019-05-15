
use File::Copy;
use Scalar::Util qw(looks_like_number);

print "Welcome to the Internal Classes Proxy Application Benchmark Configurator. \n

This program allows the configuration of the number of adaptation rules of the application, the number of adaptable classes and the number of adaptation alternatives. In addition, it allows the configuration of an user behaviour with the application, in order to run the experiments. To specify them, simply write the number and push the intro button. As result, the program returns an application configured accroding to these parameters, ready to be opened using Android Studio to be compiled and, finally, be launched in an Android phone.

- Number of adaptation rules: total amount of conditions that the system checks in order to decide if a change must be made in the applciation in order to being adapted to the user behaviour.\n

- Number of adaptable classes: determines the number of functionalities (classes) that can be adapted at runtime. These classes are monitored by handlers and monitors, that are increased in a 1 to 1 relation.\n

- Number of adaptation alternatives: the posibilities of adaptation of the adaptable classes are named adaptation alternatives, that is changed by this value.\n\n";



print "Number of adaptation rules: ";
$nRules = <>;
chomp $nRules;

if (looks_like_number($nRules)) {

   my $filename = 'Benchmark-Internal/app/src/main/java/analysis/Analysis.java';
   my $data = read_file($filename);
   $data =~ s/private int nRules = 1;/private int nRules = ${nRules};/g;
   write_file($filename, $data);

}



print "Number of adaptable classes: ";
$nAdaptable = <>;
chomp $nAdaptable;

my $handlerUrl = 'Benchmark-Internal/app/src/main/java/handler/';
my $handlerFile = 'MyInvocationHandler';

my $generatorUrl = 'Benchmark-Internal/app/src/main/java/generator/';
my $generatorFile = 'Generator';

if (looks_like_number($nAdaptable)) {

   for (my $i=0; $i <= $nAdaptable-2; $i++) {

       $filenameHandler = "${handlerUrl}${handlerFile}$i.java";
       $filenameGenerator = "${generatorUrl}${generatorFile}$i.java";


       copy("${handlerUrl}${handlerFile}.java","${filenameHandler}") or die "Copy failed: $!";
       copy("${generatorUrl}${generatorFile}.java","${filenameGenerator}") or die "Copy failed: $!";
       my $dataHandler = read_file($filenameHandler);
       my $dataGenerator = read_file($filenameGenerator);

       $dataHandler =~ s/public class MyInvocationHandler implements InvocationHandler/public class MyInvocationHandler$i implements InvocationHandler/g;
       $dataHandler =~ s/public MyInvocationHandler\(Class<\?> \[] objectProxied\)/public MyInvocationHandler$i\(Class<\?> \[] objectProxied\)/g;


       $dataGenerator =~ s/public class Generator/public class Generator$i/g;
       $dataGenerator =~ s/import handler\.MyInvocationHandler;/import handler\.MyInvocationHandler$i;/g;
       $dataGenerator =~ s/new MyInvocationHandler\(list\)\);/new MyInvocationHandler$i\(list\)\);/g;
       write_file($filenameHandler, $dataHandler);
       write_file($filenameGenerator, $dataGenerator);

   }

   my $mainFile = 'Benchmark-Internal/app/src/main/java/registry/com/selectmenu/MainActivity.java';
   my $stringToInsert = '';
   my $stringToInsert2 = '';
   my $stringToInsert3 = '';

   my $data = read_file($mainFile);

   for (my $i=0; $i <= $nAdaptable-2; $i++) {
       $stringToInsert .= "private LoadInterface myProxy$i;\n";
       $stringToInsert2 .= "myProxy${i} = (LoadInterface) new Generator$i().generateObjectsFunction();\n";
       $stringToInsert3 .= "import generator.Generator$i;\n";
   }

   $data =~ s/private LoadInterface myProxy;/private LoadInterface myProxy;\n${stringToInsert}/g;
   $data =~ s/myProxy = \(LoadInterface\) new Generator\(\)\.generateObjectsFunction\(\);/myProxy = \(LoadInterface\) new Generator\(\).generateObjectsFunction\(\);\n${stringToInsert2}/g;
   $data =~ s/import generator\.Generator;/import generator\.Generator;\n${stringToInsert3}/g;

   write_file($mainFile, $data);

}



print "Number of adaptation alternatives: ";
$nAlternatives = <>;
chomp $nAlternatives;
my $loaderUrl = 'Benchmark-Internal/app/src/main/java/load/';
my $loaderFile = 'LoadLeaguesAdaptation';

if (looks_like_number($nAlternatives) && $nAlternatives > 1) {
    $filenameGenerator = "${generatorUrl}${generatorFile}.java";

    my $dataGen = read_file($filenameGenerator);
    $nToInsert = $nAlternatives+1;
    $dataGen =~ s/Class<\?> \[\] list = new Class<\?>\[2\];/Class<\?> \[\] list = new Class<\?>\[${nToInsert}\];/g;

    for (my $i=2; $i <= $nAlternatives; $i++) {

        $aux = $i - 2;
        $filenameLoader = "${loaderUrl}${loaderFile}.java";
        copy("${filenameLoader}","${loaderUrl}${loaderFile}$aux.java") or die "Copy failed: $!";
            
        my $dataLoader = read_file($filenameLoader);

        $dataLoader =~ s/public class LoadLeaguesAdaptation implements LoadInterface\{/public class LoadLeaguesAdaptation$aux implements LoadInterface\{/g;
        $dataLoader =~ s/LoadLeaguesAdaptation\.leagues = leagues;/LoadLeaguesAdaptation$aux\.leagues = leagues;/g;
        $stringToInsert .= "list[$i] = Class.forName(\"load.LoadLeaguesAdaptation$aux\");\n";
        write_file("${loaderUrl}${loaderFile}$aux.java", $dataLoader);

    }

    $dataGen =~ s/list\[1\] = Class\.forName\("load\.LoadLeaguesAdaptation"\);/list\[1\] = Class\.forName\("load.LoadLeaguesAdaptation"\);\n$stringToInsert/g;
    write_file($filenameGenerator, $dataGen);
}



print "Do you want to configure your experiment? (y/n)";
$experimentB = <>;
chomp $experimentB;
$experimentB =~ tr/A-Z/a-z/;
if ($experimentB eq "y") {
  print "\nNow, you are going to configure an experiment based on the data consulting scenario. The information inserted will be use to create a random user behaviour with the application.\n";

  print "Insert the maximum number of elements consulted by the user in the application in each execution (round):";
  $nMax = <>;
  chomp $nMax;

  print "Insert the minimum number of elements consulted by the user in the application in each execution (round):";
  $nMin = <>;
  chomp $nMin;

  print "Insert the number of rounds (NR). The program will be ready to be launched NR times using ADB commands, in order to complete the experiment:";
  $nRounds = <>;
  chomp $nRounds;

  my $stringToInsert = '';

  $stringToInsert .= "public void runExperiment() {\nSharedPreferences prefs = this.getSharedPreferences(\n\"registry.com.selectmenu\", Context.MODE_PRIVATE);\nSharedPreferences.Editor ed = prefs.edit();\n
  int launch = prefs.getInt(\"launchTime\",0);\n";

if (looks_like_number($nMax) && looks_like_number($nMin) && looks_like_number($nRounds)) {
  for (my $i=0; $i < $nRounds; $i++) {
    if ($i == 0) {
      $stringToInsert .= "if (launch == $i) {\n";
    } else {
      $stringToInsert .= "} else if (launch == $i) {\n";
    }
    my $randomInt = int(rand($nMax-$nMin)) + $nMin;
    my $randomData = int(rand(26));
    for (my $r=0; $r <= $randomInt; $r++) {
      $stringToInsert .= "myProxy.getLeague(${randomData} + OFFSET);\n";
      $randomData = int(rand(26));
    }
    if (${i}+1 == $nRounds ) {
      $stringToInsert .=  "ed.putInt(\"launchTime\", 0);\ned.commit();\nfinish();\n}\n}\n";
    } else {
      $stringToInsert .=  "ed.putInt(\"launchTime\", launch + 1);\ned.commit();\nfinish();\n";
    }
  }
}

my $filename = 'Benchmark-Internal/app/src/main/java/registry/com/selectmenu/MainActivity.java';
my $dataGen = read_file("${filename}");
$dataGen =~ s/\/\/IMPORTS/import load.LoadInterface;\nimport android.content.Context;\nimport android.content.SharedPreferences;\n/g;
$dataGen =~ s/\/\/RUN EXPERIMENT/runExperiment();\n/g;
$dataGen =~ s/\/\/BENCHMARK EXPERIMENT/$stringToInsert/g;
write_file(${filename}, $dataGen);

}

print "\n*** Application Configured!! ***";


exit;
 
sub read_file {
    my ($filename) = @_;
 
    open my $in, '<:encoding(UTF-8)', $filename or die "Could not open '$filename' for reading $!";
    local $/ = undef;
    my $all = <$in>;
    close $in;
 
    return $all;
}
 
sub write_file {
    my ($filename, $content) = @_;
 
    open my $out, '>:encoding(UTF-8)', $filename or die "Could not open '$filename' for writing $!";;
    print $out $content;
    close $out;
 
    return;
}