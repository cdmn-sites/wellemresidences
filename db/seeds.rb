supa = RoomType.where(id: 107519).first_or_create!( amenities: {
  queen_size_bed: 1,
  bathtub: 1
}, name: 'Superior Apartment', description: 'With spacious 59-63 sqm with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchen, a spacious bathroom with shower, living- and dining area with a small balcony as well as a separate bedroom with a king sized bed')
supa.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'supa', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  supa.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

exap = RoomType.where(id: 107521).first_or_create!(amenities: {
  king_size_bed: 1,
  queen_size_bed: 1,
  bathtub: 1
}, name: 'Executive Apartment', description: 'On 90 - 111 sqm with entrance area, a utility room with washing machine & dryer, a fully equipped kitchen, a spacious bathroom with shower, an additional guest toilet, a light-flooded living- and dining are with balcony as well as a separate bedroom with a king sized bed')
exap.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'exap', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  exap.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

exap2br = RoomType.where(id: 107520).first_or_create!(amenities: {
  king_size_bed: 1,
  queen_size_bed: 1,
  bathtub: 1
}, name: 'Executive Apartment 2BR', description: 'On 90 - 111 sqm with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchen, a spacious bathroom with shower, an additional  guest toilet, a light-flooded living- and dining area with balcony as well as two separate sleeping rooms, one with a king sized bed and another one with a single bed')
exap2br.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'exap2br', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  exap2br.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

ep2br = RoomType.where(id: 107529).first_or_create!(amenities: {
  king_size_bed: 1,
  queen_size_bed: 1,
  bathtub: 1
}, name: 'Executive Penthouse 2BR', description: 'Exclusive and urban styled executive maisonette penthouses with fully furnished roof terraces above the Düsseldorf roof tops. Elegant and stylish with a generous living and dining areas, high-quality, fully equipped kitchens, highly fitted out bathrooms with bathtubs and showers, separate utility rooms with washing machine and dryer. Two double bedrooms.')
ep2br.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'ep2br', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  ep2br.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

ph = RoomType.where(id: 107526).first_or_create!(amenities: {
  king_size_bed: 1,
  bathtub: 1
}, name: 'Penthouse', description: 'Generous and bright 123 -127 sqm mark out our premium maisonette penthouses with their almost 50 sqm furnished roof terraces. Spacious entrance areas with HK rooms and additional toilets, lightflooded living- and dining areas with fully equipped kitchens and balconies, separate bedrooms and luxurous bathrooms with tubs and showers create a unique sense of living.')
ph.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'ph', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  ph.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

pa = RoomType.where(id: 107522).first_or_create!(amenities: {
  king_size_bed: 1,
  queen_size_bed: 1,
  bathtub: 1
}, name: 'Premium Apartment', description: 'On 70 - 90 sqm with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchenette, a spacious bathroom with shower, an additional toilet, living- and dining area as well as a separate bedroom with a king sized bed')
pa.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'pa', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  pa.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

studio = RoomType.where(id: 107523).first_or_create!(amenities: {
  king_size_bed: 1,
  bathtub: 1
}, name: 'Studio', description: 'Small but precious, a comfortable studio on 46 sqm, with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchenette, a spacious bathroom with shower, living- and dining area as well as a separated sleeping area with a queen sized bed')
studio.images.purge
Dir.glob(Rails.root.join('db', 'seed', 'studio', '*.jpg'), File::FNM_CASEFOLD).each do |file|
  studio.images.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpg')
end

