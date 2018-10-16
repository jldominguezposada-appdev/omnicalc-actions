class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count
    
     minimum = [@numbers.at(0)]
  
          @numbers.each do |subject|
      
                if subject < minimum.at(0)
                  
                  minimum.delete_at(0)
                  minimum.push(subject)
        
                end
          end

    @minimum = minimum.at(0)
  
       maximum = [@numbers.at(0)]
  
          @numbers.each do |subject|
      
                if subject > maximum.at(0)
                  
                  maximum.delete_at(0)
                  maximum.push(subject)
        
                end
          end

    @maximum = maximum.at(0)

    @range = maximum.at(0) - minimum.at(0)

    # Median
    
    total_elements = @numbers.count
    
    even_test = total_elements / 2
      
        if total_elements.even?
          
          median = (@sorted_numbers.at(even_test) + @sorted_numbers.at(even_test - 1)) / 2
          
        else
          
          median = @sorted_numbers.at(even_test.round(0))
          
        end
    
    # ======

    @median = median

      sum = [0]
    
        @numbers.each do |subject|
    
          sum_step = sum.at(0) + subject
          
          sum.delete_at(0)
          sum.push(sum_step)
        
        end
        
    @sum = sum.at(0)

        mean = sum.at(0) / total_elements

    @mean = mean

    # Variance
    
      sum_squares_difference = [0]
      
        @numbers.each do |subject_b|
          
          difference_mean = subject_b - mean
          square_difference = difference_mean**2
          sum_squares_difference_step = sum_squares_difference.at(0) + square_difference
          
          sum_squares_difference.delete_at(0)
          sum_squares_difference.push(sum_squares_difference_step)
          
      end
  
    variance = sum_squares_difference.at(0) / total_elements
    
    
    # ========
  

    @variance = variance
    
    @standard_deviation = variance**0.5

    # Mode
    
    mode_hash = Hash.new(0)
  
        @sorted_numbers.each do |subject_c|
          
            mode_hash[subject_c] +=1
            
        end
      
    mode_array = []

      mode_hash.each do |key,value|
      
        if value == mode_hash.values.max
            mode_array.push(key)
        end
        
    end
    
    # ====

    @mode = mode_array.sort.join(", ")

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end