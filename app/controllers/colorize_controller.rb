class ColorizeController < ApplicationController
  def colorize
    input = {
      image: params.fetch("image_url")
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    @original_image_url = params.fetch("image_url")
    
  
      client = Algorithmia.client(ENV.fetch("ALGORITHMIA_KEY"))
      
      algo = client.algo('deeplearning/ColorfulImageColorization/1.1.13')
      
      result = algo.pipe(input).result
    
      result_b = result.fetch("output")
      
      result_c = "https://algorithmia.com/v1/data/#{result_b}"
    
    
    @colorized_image_url = result_c

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("colorize_templates/colorize.html.erb")
  end

  def colorize_form
    render("colorize_templates/colorize_form.html.erb")
  end
end
