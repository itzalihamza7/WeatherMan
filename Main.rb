# require 'colorize'

require './Weather_man'
include Weather

def main
  # Firstly check the corectness of arguments
  w1 = WeatherMan.new
  if ARGV.length != 3
    puts 'Incorrect Arguments'
    puts 'Use this format: ruby weather_man.rb {-e | -a | -c | -b} {year | year/month} {path_to_Folder | path_to_file }'
    return
  end

  # call function as per the requirment
  case ARGV[0]
  when '-e'
    w1.yearly_report(ARGV[1], ARGV[2])
  when '-a'
    w1.monthly_report(ARGV[2])
  when '-c'
    w1.bar_chart(ARGV[2], 0) # 0 means task 3
  when '-b'
    w1.bar_chart(ARGV[2], 1) # 1 means bonus task
  else
    puts 'Incorrect Arguments'
    puts puts 'Use this format: ruby weather_man.rb {-e | -a | -c | -b} {year | year/month} {path_to_Folder | path_to_file }'
  end
end

main
