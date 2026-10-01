# ruby script/runner 'script/slump/slump.rb'

class Scenario
  require 'script/slump/diverse'
  
  require 'script/slump/random_name'
  require 'script/slump/bem'
  require 'script/slump/planet'
  require 'script/slump/himlakropp'
  require 'script/slump/person'
  require 'script/slump/monster'
  
  include Diverse

  #  01-15 Kidnappning [Tab 1]
  #  15-30 Invasion        [Tab 2]
  #  31-45 Krig            [Tab 3] 
  #  46-55 Naturkatastrof  [Tab 4]
  #  56-60 Upptäckter      [Tab 5]
  #  61-75 Brott           [Tab 6]
  #  76-80 Fälla           [Tab 7]
  #  81-85 Olycka          [Tab 8]
  #  86-95 Övernaturligt   [Tab 9]
  #  96-00 Annat           [Tab 10]
  def initialize(seed = nil)
    if seed.present?
      srand(seed)
    else
      puts srand
    end
#    @planets = Hash.new
#    @npcer = Hash.new
#    @raser = Hash.new
  end
  
  # Hämta ett scenarioförslag
  def go
    @planets = Hash.new
    @npcer = Hash.new
    @raser = Hash.new
    @unika_raser ||= Array.new
    
#    10.times do
#      puts self.katastroftyp
#      puts
#    end
#    puts self.ras
#    puts
#    puts '....'
#    puts
    2.times do
      puts self.plats
      puts self.musik
#      puts self.ond_gud
#      puts self.skidsport
#      puts self.plats
#      puts self.djur(true)
#      puts self.djur(false)
    end
#    puts
#    self.ny_person
#    self.ny_person
#    self.ny_person
    self.ny_person
    self.ny_person(:ar_rymdskurk => true)
    self.ny_person(:ar_magiker => true)
#    self.ny_planet
#    self.ny_planet
#    self.ny_planet
#    self.ny_planet
#    self.ny_ras
#    self.ny_ras
#    self.ny_ras
#    self.ny_ras


    if @npcer.present?
      puts
      puts 'Personer:'
      @npcer.each_key do |key|
        puts @npcer[key].to_s
        puts
      end
    end
    if @planets.present?
      puts
      puts 'Planeter:'
      puts "Observera att en befolkning på en planet kan ha en annan nivå av civilisation än resten av rasen. Det gäller speciellt människor som har spritt sig mycket genom årtusendena."
      puts
      @planets.each_key do |key|
        puts @planets[key].to_s
        puts
      end
    end
    if @raser.present?
      puts
      puts 'Raser:'
      @raser.each_key do |key|
        puts '== ' + @raser[key].to_s
        puts
      end
    end
  end
  
  def kidnappning
    lines = Array.new
    what = %w(bortrövad kidnappad kidnappad bortförd stulen 'kidnappad').sample
    victim, singular = offer
    lines << [victim, 'har blivit', what]
    texts = lines.map{|text| text.join(' ') + '.'}
    return texts
  end
  
  # Returnerar vad som är offer och om det är en eller flera
  def offer
    rnd = rand(100)
    if rnd < 25
      # Person
      # is_man, is_ond, har_relation, ar_magiker, ar_rymdskurk
      person =  self.ny_person({:is_man => (rand(10)<3), :is_ond => (rand(10)<2), :har_relation => true, 
                                    :typ => 'Samma som personen i gruppen', :skp_bonus => -Person.get_skp})
      return person.name, true
    elsif rnd < 50
      # diverse
      stad = RandomName.stad
      return "#{stad} med alla husen", true if rand(100) < 50
      return "Alla som bor i #{stad}", false
    elsif rnd < 80
      # Sak
      planet = self.random_planet
      planet.civilisation ||= self.historie_niva
      planet.attributes << 'Befolkningen saknas'
      return 'Befolkningen på planeten ' + planet.name + ' som har ' + planet.civilisation, false
    else
      # Sak
      planet = self.ny_planet
      planet_selections = ['Planeten','Allt av värde på planeten','Allt vatten på planten','Alla fordon på','Alla föräldrar',"Allt av #{self.material_hard}"]
      selection = planet_selections.sample
      planet.attributes << selection + ' är borta'
      return "#{selection} #{planet.name}", true
    end
  end

# is_man, is_ond, har_relation, ar_magiker, ar_rymdskurk
  def ny_person(options=Hash.new)
    options ||= Hash.new
    options[:scenario] ||= self
    if rand(100) < 95
      person = Person.new(options)
    else
      person = Monster.overnat_varelse(options)
    end
    add_npc(person)
    return person
  end
#  def nytt_monster(options=Hash.new)
#    person = Monster.overnat_varelse(options)
#    @npcer[person.name] = person
#    return person
#  end
  def ny_planet
    planet = Planet.new(self)
    @planets[planet.name] = planet
    return planet
  end
  def ny_ras(is_befolkning=false, set_fortplantning=true)
    bem = Bem.new(self, is_befolkning, set_fortplantning)
    @raser[bem.name] = bem
    return bem
  end

  # Lägg till en NPC till scenariot
  def add_npc(person)
    @npcer[person.name] = person
  end

  def random_person(boplats=nil, forbidden_name=nil, options=Hash.new)
    if @npcer.length > 2 && rand(100) < 90
      sample = @npcer.to_a.sample
      if forbidden_name.nil? || (sample[0] != forbidden_name)
        sample[1].boplatser << boplats if boplats.present?
        return sample[1]
      end
    end

    return self.ny_person(options.merge({:boplats => boplats}))
  end
  def random_planet(forbidden_name=nil)
    if @planets.length > 2 && rand(100) < 90
      sample = @planets.to_a.sample
      return sample[1] if forbidden_name.nil? || (sample[0] != forbidden_name)
    end
    return self.ny_planet
  end
  # Plocka fram en slumpmässigt ny eller existerande ras
  def random_ras(forbidden_name=nil, is_befolkning=true)
    if @raser.length > 1 && rand(100) < 75
      sample = @raser.to_a.sample
      if !@unika_raser.include?(sample[1]) && !(!is_befolkning && sample[1].is_befolkning?) # Om det inte är befolkning i arg och sample är befolkning ska den inte väljas
        return sample[1] if forbidden_name.nil? || (sample[0] != forbidden_name)
      end
    end
    return self.ny_ras(is_befolkning)
  end
  # Plocka fram en unik ras som inte används på andra ställen
  def ny_unik_ras
    bem = ny_ras
    while @unika_raser.include? bem 
      bem = ny_ras
    end
    @unika_raser << bem
    @raser[bem.name] = bem
  end
  
end   



# Krig är ofta förekommande
class Krig
  attr_accessor :type
  def initialize
    @type = ['Krig','Krig','Krig','Krig','Inbördeskrig','Krig som egentligen är ett missförstånd','Hemligt krig','Krig som dom deltagande inte känner till'].sample
  end
  
  def to_a
    out = [@type]
#      out << "Kön: " + (@is_man ? "Man" : "Kvinna")
#      out << "Relation: " + [han_hon.capitalize, 'är', @relation].join(' ')
    return out
  end
  
  def to_s
    return self.to_a.join("\r\n")
  end
  
  def part
    return 'Rymdmonsterras med civ '
  end
end