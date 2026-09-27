# Weather Man

A Ruby command-line app that turns daily weather records into reports: yearly extremes, monthly averages and colored temperature bar charts. Written as a Ruby skills assignment during onboarding at Devsinc, using 13 years of Dubai weather data (2004–2016).

## Reports

| Flag | Input | Output |
|---|---|---|
| `-e` | a year and the data folder | Highest temperature, lowest temperature and highest humidity of the year, with dates |
| `-a` | a month file | Highest average temperature, lowest average temperature and average humidity of the month |
| `-c` | a month file | Two bar charts per day, red for the highest and blue for the lowest temperature |
| `-b` | a month file | One combined bar per day showing the lowest to highest temperature |

## Getting started

Requires Ruby and the `colorize` gem.

```bash
gem install colorize
ruby Main.rb -e 2004 Dubai_weather
ruby Main.rb -a 2005/6 Dubai_weather/Dubai_weather_2005_Jun.txt
ruby Main.rb -c 2005/6 Dubai_weather/Dubai_weather_2005_Jun.txt
ruby Main.rb -b 2005/6 Dubai_weather/Dubai_weather_2005_Jun.txt
```

Example output of `ruby Main.rb -e 2004 Dubai_weather`:

```
Highest temp: 18C on DEC 7
Lowest temp: 0C on DEC 17
Highest Humid: 100% on DEC 16
```

## Project structure

```
Main.rb          Command-line entry point and argument handling
weather_man.rb   Parsing and report logic
date.rb          Date value object
Dubai_weather/   Monthly weather files, 2004–2016
```
