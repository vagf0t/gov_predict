
unless Country.find_by_two_digit_code 'US'
  c = Country.new
  c.name = 'U.S.A'
  c.two_digit_code = 'US'
  c.three_digit_code = 'USA'
  c.save!
end

unless Country.find_by_two_digit_code 'GR'
  c = Country.new
  c.name = 'Greece'
  c.two_digit_code = 'GR'
  c.three_digit_code = 'GRC'
  c.save!
end
