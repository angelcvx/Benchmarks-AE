use File::Copy;
use Scalar::Util qw(looks_like_number);


print "Welcome to the Xposed Proxy Application Benchmark configurator. \n

This program allows the configuration of the number of adapted methods using Xposed. In addition, it allows the configuration of an user behaviour with the application, in order to run the experiments. To specify them, simply write the number and push the intro button. As result, the program returns an application configured with this parameter, ready to be opened using Android Studio to be compiled and, finally, be launched in an Android phone.\n\n";


print "Number of adapted methods using Xposed: ";
$nMethods = <>;
chomp $nMethods;

if (looks_like_number($nMethods)) {

  my $filename = 'app/src/main/java/reconfiguration/CodeInjection.java';       
  my $data = read_file($filename);
  $data =~ s/private int numberOfMethods = 1;/private int numberOfMethods = ${nMethods};/g;
  write_file($filename, $data);

}


print "Do you want to configure your experiment? (y/n)";
$experimentB = <>;
chomp $experimentB;
$experimentB =~ tr/A-Z/a-z/;.

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
  
  my $filename = 'Benchmark-Internal/Benchmark-External/app/src/main/java/registry/com/selectmenu/MainActivity.java';
  my $dataGen = read_file("${filename}");
  $dataGen =~ s/\/\/IMPORTS/import load.LoadInterface;\nimport android.content.Context;\nimport android.content.SharedPreferences;\n/g;
  $dataGen =~ s/\/\/RUN EXPERIMENT/runExperiment();\n/g;
  $dataGen =~ s/\/\/BENCHMARK EXPERIMENT/$stringToInsert/g;
  write_file(${filename}, $dataGen);

}

print "*** Application Configured!! ***";

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