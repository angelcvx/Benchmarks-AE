use File::Copy;
use Scalar::Util qw(looks_like_number);


print "Welcome to the Xposed Proxy Application Benchmark configurator. \n

This program allows the configuration of the number of adapted methods using Xposed. To specify them, simply write the number and push the intro button. As result, the program returns an application configured with this parameter, ready to be opened using Android Studio to be compiled and, finally, be launched in an Android phone.\n\n";


print "Number of adapted methods using Xposed: ";
$nMethods = <>;
chomp $nMethods;

if (looks_like_number($nMethods)) {

  my $filename = 'app/src/main/java/reconfiguration/CodeInjection.java';       
  my $data = read_file($filename);
  $data =~ s/private int numberOfMethods = 1;/private int numberOfMethods = ${nMethods};/g;
  write_file($filename, $data);

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