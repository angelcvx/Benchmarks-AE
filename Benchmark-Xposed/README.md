# Xposed Application Benchmark Configurator

Code reconfiguration module implementation by UMA.

## Information

This program allows the configuration of the number of adapted methods of the application using Xposed. To specify them, simply write the number and push the intro button. As result, the program returns an application configured with this parameter, ready to be opened using Android Studio to be compiled and, finally, be launched in an Android phone.

## Requirements

- Perl 
- Android Studio
- Android SDK
- Android device (version 4.0 or above)

## Usage

In order to configure the benchmark application:

- Download these files in any directory of your computer

- Run the script configureBenchmark.pl and follow the steps to create the app

- Open the application using Android Studio and install it in an Android device

- Copy the input leagues folder named "InfoLeagues" in the external
storage directory of your device, typically in "mnt/sdcard/"

- Copy the external classes to load (classes.dex file) in the "data/local/tmp/footballLoaders/"
directory of your device

- Install the app and run it

## License

-GNU GPLv3
