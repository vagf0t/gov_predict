
unless Person.where(name: 'Princess').where(surname: 'Amidala').first
  p = Person.new
  p.name = 'Princess'
  p.surname = 'Amidala'
  p.lists << List.find_by_name('Federal Legislators')
  p.lists << List.find_by_name('State Governors')
  p.save!
end

unless Person.where(name: 'Master').where(surname: 'Yoda').first
  p = Person.new
  p.name = 'Master'
  p.surname = 'Yoda'
  p.lists << List.find_by_name('Federal Legislators')
  p.lists << List.find_by_name('State Governors')
  p.lists << List.find_by_name('Federal Agency')
  p.save!
end

unless Person.where(name: 'Darth').where(surname: 'Vader').first
  p = Person.new
  p.name = 'Darth'
  p.surname = 'Vader'
  p.lists << List.find_by_name('Industry')
  p.save!
end

unless Person.where(name: 'Luke').where(surname: 'Skywalker').first
  p = Person.new
  p.name = 'Luke'
  p.surname = 'Skywalker'
  p.lists << List.find_by_name('Federal Agency')
  p.save!
end