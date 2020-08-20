module UsersHelper
  
  def price_one(size, number)
    if size == "B0"
      1600 * number
    elsif size == "B1"
      800 * number
    elsif size == "B2"
      400 * number
    elsif size == "A0"
      1000 * number
    elsif size == "A1"
      500 * number
    elsif size == "A2"
      300 * number
    else
      200 * number
    end
  end
end
