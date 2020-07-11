class Application

  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        @@items.each do |item|
          resp.write "#{item}\n"
        end
      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
      elsif req.path.match(/cart/)
        if @@cart.empty?  # checking if the cart is empty
          resp.write "Your cart is empty" # if so returns as such
        else
          @@cart.each do |item| # otherwise we loop through the cart
            resp.write "#{item}\n" # and RESP WRITE the items
          end                       # resp.write is like 'puts'
        end
      elsif req.path.match(/add/)
        item_to_add = req.params["item"] # here we are setting the 'search item' 
        if @@items.include? item_to_add   # here we are checking if the '@@items' array has the 'search item'
          @@cart << item_to_add # if it does we shovel it into the cart
          resp.write "added #{item_to_add}" # and return a message saying we added it
        else
          resp.write "We don't have that item!" # if the 'search item' is not in the '@@items' array
        end
      else
        resp.write "Path Not Found"
      end
  
      resp.finish
    end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
