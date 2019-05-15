# Internal Classes Proxy Application Benchmark configurator

Code reconfiguration module implementation by UMA.

## Information

This program allows the configuration of the number of adaptation rules of the application, the number of adaptable classes and the number of adaptation alternatives. In addition, it allows the generation of user interactions. To specify them, simply write the number and push the intro button. As result, the program returns an application configured with these parameters, ready to be compiled using Android Studio and, finally, be runned on an Android phone.

- Number of adaptation rules: total amount of conditions that the system checks in order to decide if a change must be made in the application in order to being adapted to the user behaviour.

- Number of adaptable classes: determines the number of functionalities (classes) that can be adapted at runtime. These classes are monitored by handlers and monitors, that are increased in a 1 to 1 relation.

- Number of adaptation alternatives: the possibilities of adaptation of the adaptable classes are named adaptation alternatives, that are set by this value.

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
