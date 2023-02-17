module Weather
  require './date'
  require 'colorize'

  class WeatherMan
    def populate(path)
      file = File.open(path, 'r')

      month = {}
      headings = []
      raw_data = file.readlines
      raw_data.each_with_index do |v, i|
        raw_data.delete_at(i) if v.length < 20
      end
      data = raw_data

      data.each_with_index do |v, i|
        headings = v.split(',') if i.zero?

        splitted_data = v.split(',')
        date = splitted_data[0].split('-') if i.positive?
        next unless i.positive?

        d = Date.new(date[0], date[1], date[2])

        month[d] = splitted_data.each_with_index.map do |value, index|
          [headings[index], value]
        end.to_h

        splitted_data.clear
      end
      month
    end

    def month(i)
      y = %w[JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC]
      y[i - 1]
    end

    def average_val(hash, key)
      avg_humidity = 0
      n = 0

      hash.each do |_k, v|
        v.each do |k1, v1|
          next unless k1 == key && !v1.empty?

          avg_humidity += v1.to_i
          n += 1
        end
      end
      avg_humidity /= n
    end

    def highest_val(hash, key)
      highest = 0
      day = 0
      month = nil
      hash.each do |k, v|
        v.each do |k1, v1|
          next unless k1 == key && v1.to_i > highest

          day = k.day
          month = month(k.month.to_i)

          highest = v1.to_i
        end
      end
      [highest, day, month]
    end

    def lowest_val(hash, key)
      lowest = 100
      day = 0
      month = nil
      hash.each do |k, v|
        v.each do |k1, v1|
          next unless k1 == key && v1.to_i < lowest

          day = k.day
          month = month(k.month.to_i)

          lowest = v1.to_i
        end
      end
      [lowest, day, month]
    end

    def monthly_report(file_path)
      unless File.file? file_path
        puts 'File Not Found'
        return
      end

      highest_avg_temp = 0
      lowest_avg_temp = 0

      m = populate(file_path)

      avg_humidity = average_val(m, ' Mean Humidity')
      highest_avg_temp = average_val(m, 'Max TemperatureC')
      lowest_avg_temp = average_val(m, 'Min TemperatureC')

      puts "Highest Average temp: #{highest_avg_temp}C"
      puts "Lowest Average temp: #{lowest_avg_temp}C"
      puts "Average Humid: #{avg_humidity}% "
    end

    def bar_chart(file_path, is_bonus)
      unless File.file? file_path
        puts 'File Not Found'
        return
      end
      min_t, max_t = 0

      m = populate(file_path)

      day = 1

      m.each do |_k, v|
        v.each do |k1, v1|
          max_t = v1.to_i if k1 == 'Max TemperatureC'
          min_t = v1.to_i if k1 == 'Min TemperatureC'
        end

        print "#{day} "

        if is_bonus.zero?
          max_t.times { print '+'.red }
          puts " #{max_t}C"
          print "#{day} "
          min_t.times { print '+'.blue }
          puts " #{min_t}C"
        else
          min_t.times { print '+'.red }
          max_t.times { print '+'.blue }
          print " #{min_t}C - #{max_t}C\n"
        end

        day += 1
      end
    end

    def yearly_report(year, folder_path)
      unless File.directory? folder_path
        puts 'Folder Not Found'
        return
      end

      # Store all files in an array and then extract the required files from the array
      all_files = Dir.entries(folder_path)
      req_files = []

      all_files.each do |file|
        req_files.push(file) if file.include? year
      end

      # Terminate the program if wrong year is entered
      if req_files.length.zero?
        puts 'Wrong Year Entered'
        return
      end

      days = ['', '', ''] # Array of highest_temp, lowest_temp and max_humidity days
      highest_temp = -100
      lowest_temp = 100
      max_humidity = -100
      m1 = {}
      m = {}

      # Now traverse each line of each file and find the required data
      req_files.each do |file|
        m1 = populate(folder_path + '/' + file)

        m = m1.merge
      end
      # puts m
      k1 = 'Max TemperatureC'
      k2 = 'Min TemperatureC'
      k3 = 'Max Humidity'

      puts "Highest temp: #{highest_val(m, k1)[0]}C on #{highest_val(m, k1)[2]} #{highest_val(m, k1)[1]}"
      puts "Lowest temp: #{lowest_val(m, k2)[0]}C on #{lowest_val(m, k2)[2]} #{lowest_val(m, k2)[1]}"
      puts "Highest Humid: #{highest_val(m, k3)[0]}% on #{highest_val(m, k3)[2]} #{highest_val(m, k3)[1]}"
    end
  end
end
