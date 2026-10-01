# Lite större begrepp som bara är en typ. Inte en specifik planet
class HimlaKropp
  attr_accessor :typ, :planet

  def HimlaKropp.random(scenario, planet=nil)
    return HimlaKropp.new(scenario, planet).typ
  end

  def initialize(scenario, planet=nil)
    @scenario = scenario
    @planet = planet if planet.present?
    @typ = self.get_type
  end
  
  def to_a
    out = [@typ]
    return out
  end
  
  def to_s
    return self.to_a.join("\r\n")
  end
  
  def get_type
#65-68 Månggenerationsrymdraket [Tab. 13]
    @planet ||= @scenario.random_planet              if rand(100) < 25
    return "#{@planet.planettyp} (#{@planet.name})"  if @planet.present?
    return "en stjärna som strålar #{@scenario.ray}" if rand(100) < 5
    options ||= ["en röd sol", "en jättestjärna", 'en supernova','en vanlig sol', 'en vanlig stjärna', "ett system av #{(rand(6)+2)} solar", 
               "ett svart hål",'en asteroid av sten','en hotfull komet','en dvärgplanet',
               "en nebulosa",'en iskomet','en eldkomet','en stor asteroid','en liten asteroid','en kringflygande hög av skrot','en planetoid','ett asteroidbälte']
    options << 'en asteroid av ' + @scenario.material_hard
    options << 'en komet av fryst ' + @scenario.material_floating
    return options.sample
  end
end