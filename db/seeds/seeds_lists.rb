
unless List.find_by_name 'Federal Legislators'
  l = List.new
  l.name = 'Federal Legislators'
  l.description = 'US Federal Senators and Congressmen'
  l.save!
end

unless List.find_by_name 'Industry'
  l = List.new
  l.name = 'Industry'
  l.description = 'Important industry figures'
  l.save!
end

unless List.find_by_name 'State Governors'
  l = List.new
  l.name = 'State Governors'
  l.description = 'State Governors'
  l.save!
end

unless List.find_by_name 'Federal Agency'
  l = List.new
  l.name = 'Federal Agency'
  l.description = 'Members of a federal agency'
  l.save!
end