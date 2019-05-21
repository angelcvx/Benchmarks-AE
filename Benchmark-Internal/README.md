# Internal Classes Proxy Application Benchmark Configurator

Code reconfiguration module implementation by UMA.

## Information

This program allows the configuration of the number of adaptation rules of the application, number of adaptable classes and number of adaptation alternatives. In addition, it allows generating random user interactions. To specify them, simply write the number and push intro button. As result, the program returns an application configured with these parameters, ready to be compiled using Android Studio and, finally, be executed on an Android phone.

- Number of adaptation rules: total number of conditions checked by the system in order to decide if a change must be done or not in the application in order to being adapted to user behavior.

- Number of adaptable classes: determines the number of functionalities (classes) that can be adapted at runtime. These classes are monitored by handlers and monitors, that are increased in a 1 to 1 relation.

- Number of adaptation alternatives: the possibilities of adaptation of the adaptable classes are named adaptation alternatives, that are set by this number.

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

- Install the app and run it

## License

-GNU GPLv3
