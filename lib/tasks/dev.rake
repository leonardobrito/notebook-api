namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts 'Database reset...'
    %x(rails db:drop db:create db:migrate)

    puts "Cadastrando os tipos de contatos..."
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos de contatos cadastrados com sucesso!"

    puts "Cadastrando os contatos..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts "Contatos cadastrados com sucesso!"

    puts "Cadastrando os phones..."
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        contact.phones.create!(number: Faker::PhoneNumber.cell_phone)
        contact.save!
      end
    end
    puts "Phones cadastrados com sucesso!"

    puts "Cadastrando os Address..."
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
    puts "Address cadastrados com sucesso!"
  end

end
