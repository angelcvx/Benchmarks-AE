# External Classes Proxy Application Benchmark Configurator

Code reconfiguration module implementation by UMA.

## Information

This program allows the configuration of the number of adaptation rules of the application, the number of adaptable classes and the number of adaptation alternatives. In addition, it allows the generation of user interactions. To specify them, simply write the number and push the intro button. As result, the program returns an application configured according to these parameters, ready to be compiled using Android Studio and, finally, be executed on an Android phone. The content of the directory "External classes" must be copied in the directory "data/local/tmp/footballLoaders/" of the smartphone.

- Number of adaptation rules: total amount of conditions that the system checks in order to decide if a change must be made in the application in order to being adapted to the user behaviour.

- Number of adaptable classes: determines the number of functionalities (classes) that can be adapted at runtime. These classes are monitored by handlers and monitors, that are increased in a 1 to 1 relation.

- Number of adaptation alternatives: the posibilities of adaptation of the adaptable classes are named adaptation alternatives, that are set by this value. All of these alternatives, external to the application in this case, will be loaded by the application in order to being used if neccesary.

## Requirements

- Perl 
- Android Studio
- Android SDK
- Android device (version 4.0 or above)

## Usage

In order to configure the benchmark application:

- Download these files in any directory in your computer

- Run the script configureBenchmark.pl and follow the steps to create the app

- Open the application using Android Studio and install it in an Android device

- Copy the input leagues folder named "InfoLeagues" in the external
storage directory of your device, typically in "mnt/sdcard/"

- Copy the external classes to load (classes.dex file) in the "data/local/tmp/footballLoaders/"
directory of your device

- Install the app and run it

## License

-GNU GPLv3
