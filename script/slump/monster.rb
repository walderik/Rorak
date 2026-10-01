class Monster < Person
  
  # Tabell 9.1 - Övernat. varelse
  def Monster.overnat_varelse(options = Hash.new)
    options ||= Hash.new
    scenario = options[:scenario]
    # 10 Osalig ande [Tab. 5.2]
    # 12 Zombie [Tab. 5.2]
    # 18 Besatt sak [Tab. 17]
    # Besatt verktyg [Tab. 17.2]
    # 24 Gengångare [Tab. 5.2] (+20 SkP)
    # 32 Varelse från annan dimension [Tab. 20]
    # 67 Besatt kroppsdel [Tab. 21.1] som är på en människa [Tab. 5.2] (+10 SkP)
    # 69 Odöd ond soldat [Tab. 19] (+ [Tab. 11.3] SkP)
    #  72 Spökrymdraket [Tab. 13]
    #  73 Kriminellt spöke [Tab. 11] (+ 15 SkP)
    #  74 Forskare som gjort experiment på sig själv [Tab. 5.1]
    #  77 Ond ande (+ [Tab. 11.3] SkP)
    #  78 Levande sak [Tab. 17]
    rnd = rand(114)    # Ändra när du lägger till fler
    return Monster.new(options.merge({:is_ond => (rand(100) < 90), :typ => 'vampyr', :ar_rymdskurk => true}) )                  if rnd < 1
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'katt från Saturnus'}) )                             if rnd < 2
    return Monster.new(options.merge({:is_ond => true, :typ => 'shoggoth', :ar_rymdskurk => false, :skp_bonus => 60}) )         if rnd < 3
    return Monster.new(options.merge({:is_ond => (rand(100) < 70), :typ => 'varulv', :ar_rymdskurk => true}) )                  if rnd < 4
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'basilisk'}) )                                       if rnd < 5
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => 'mumie', :ar_rymdskurk => true, :skp_bonus => 15}) ) if rnd < 6
    if rnd < 9
      bonus = 0
      gud = scenario.ond_gud.capitalize
      matchdata = gud.match(/\+(\d+) (skp)/i)
      if rand(100) < 50
        bonus = (matchdata[1].to_i/50).to_i  if matchdata.present? && matchdata[1].present?
        return Person.new(options.merge({:is_ond => (rand(100) < 50), :typ => "avkomma av #{gud}", :ar_rymdskurk => true, :skp_bonus => 20+bonus}) )
      else
        bonus = matchdata[1].to_i if matchdata.present? && matchdata[1].present?
        matchdata = gud.match(/^((\w|-)+)/)
        name = matchdata[1] if matchdata.present? && matchdata[1].present?
        return Person.new(options.merge({:is_ond => true, :typ => gud, :ar_rymdskurk => true, :skp_bonus => bonus, :name => name}) )
      end
    end
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'poltergeist'}) )                                    if rnd < 10
    return Monster.new(options.merge({:is_ond => true, :typ => 'ghoul', :skp_bonus => 10}) )                                    if rnd < 11
    return Monster.new(options.merge({:is_ond => true, :typ => 'demon', :ar_rymdskurk => true, :skp_bonus => 40}) )             if rnd < 12
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => 'liten djävul', :ar_rymdskurk => false, :skp_bonus => (rand(11)+rand(11)+rand(11)+rand(11))}) )  if rnd < 13
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => "flygande köttätande #{scenario.djur(true)}"}) )     if rnd < 14
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => "rovdjurs #{scenario.djur(true)}"}) )                if rnd < 15
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'djupvarelse (Cthulhu)',:skp_bonus => Monster.get_skp_bonus}) ) if rnd < 16
    return Monster.new(options.merge({:is_ond => true, :typ => 'häxa', :ar_rymdskurk => true, :is_man => (rand(100) < 10)}) )   if rnd < 17
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'svart katt'}) )                                     if rnd < 18
    return Monster.new(options.merge({:is_ond => true, :typ => "köttätande #{scenario.urtidsdjur(true)}", :ar_rymdskurk => true}) ) if rnd < 19
    return Monster.new(options.merge({:is_ond => true, :typ => 'kraken', :skp_bonus => 150}) )                                  if rnd < 20
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'elektriskt spöke'}) )                               if rnd < 21
    return Monster.new(options.merge({:is_ond => true, :typ => 'nekromantiker', :ar_rymdskurk => true}) )                       if rnd < 22
    if rnd < 23
      magi = scenario.magityp(true)
      return Monster.new(options.merge({:is_ond => true, :typ => "elak magiker med #{magi}", :attributes => ["Mästare i #{magi}"], :skp_bonus => 15}) )
    end
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "var-#{scenario.mamalian(true)}", :skp_bonus => 10}) ) if rnd < 24
    return Monster.new(options.merge({:is_ond => false, :typ => "ängel (inga Skp funkar i närheten av en ängel)", :skp_bonus => -Monster.get_skp_bonus}) ) if rnd < 25
    return Monster.new(options.merge({:is_ond => false, :typ => "skyddsängel"}) )                                               if rnd < 26
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'skuggvarelse'}) )                                   if rnd < 27
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'älva', :is_man => false}) )                         if rnd < 28
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'tomte'}) )                                          if rnd < 29
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "gargoyle", :skp_bonus => 20}) )                     if rnd < 30
    return Monster.new(options.merge({:is_ond => true, :typ => "drake", :ar_rymdskurk => true}) )                               if rnd < 31
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'alf'}) )                                            if rnd < 32
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => "svartalf", :skp_bonus => 10}) )                     if rnd < 33
    return Monster.new(options.merge({:typ => "halvlängdsman"}) )                                                               if rnd < 34
    return Monster.new(options.merge({:is_ond => (rand(100) < 70), :typ => 'jätte'}) )                                          if rnd < 35
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => 'troll', :skp_bonus => 15}) )                        if rnd < 36
    return Monster.new(options.merge({:is_ond => (rand(100) < 70), :typ => 'elementarvarelse'}) )                               if rnd < 37
    return Monster.new(options.merge({:is_ond => true, :typ => 'elddemon', :skp_bonus => (rand(6)+rand(6)+2)}) )                if rnd < 38
    return Monster.new(options.merge({:is_ond => false, :typ => "enhörning"}) )                                                 if rnd < 39
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'grip'}) )                                           if rnd < 40
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => 'mantikora', :skp_bonus => 15}) )                    if rnd < 41
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'kentaur'}) )                                        if rnd < 42
    return Monster.new(options.merge({:is_ond => (rand(100) < 90), :typ => 'minotaur'}) )                                       if rnd < 43
    return Monster.new(options.merge({:is_ond => true, :typ => "harpya"}) )                                                     if rnd < 44
    return Monster.new(options.merge({:is_ond => true, :typ => 'hydra', :skp_bonus => 40}) )                                    if rnd < 45
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'blobb'}) )                                          if rnd < 46
    return Monster.new(options.merge({:is_ond => (rand(100) < 40), :typ => 'rymdlämmel'}) )                                     if rnd < 47
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'havsman'}) )                                        if rnd < 48
    return Monster.new(options.merge({:is_ond => true, :typ => 'succubi/Incubi', :skp_bonus => Monster.get_skp_bonus}) )        if rnd < 49
    return Monster.new(options.merge({:is_ond => true, :typ => 'gug (Cthulhu)', :skp_bonus => 30}) )                            if rnd < 50
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'pyssling'}) )                                       if rnd < 51
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'jättemask'}) )                                      if rnd < 52
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'amazon'}) )                                         if rnd < 53
    return Monster.new(options.merge({:is_ond => (rand(100) < 30), :typ => 'amorin'}) )                                         if rnd < 54
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "spöke från #{scenario.historie_niva}-tid"}) )       if rnd < 55
    return Monster.new(options.merge({:is_ond => (rand(100) < 30), :typ => "lieman"}) )                                         if rnd < 56
    return Monster.new(options.merge({:is_ond => (rand(100) < 90), :typ => "cyklop"}) )                                         if rnd < 57
    return Monster.new(options.merge({:is_ond => (rand(100) < 90), :typ => "skelett"}) )                                        if rnd < 58
    return Monster.new(options.merge({:is_ond => true, :typ => "naga", :skp_bonus => Monster.get_skp_bonus}) )                  if rnd < 59
    return Monster.new(options.merge({:is_ond => (rand(100) < 30), :typ => "spöke"}) )                                          if rnd < 60
    return Monster.new(options.merge({:is_ond => true, :typ => "Chupacabra"}) )                                                 if rnd < 61
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'satyr'}) )                                          if rnd < 62
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'marshmallowgubbe', :skp_bonus => 10}) )             if rnd < 63
    return Monster.new(options.merge({:is_ond => true, :typ => "gengångar himlakropp (#{HimlaKropp.random(scenario)})", :ar_rymdskurk => true}) ) if rnd < 64
    if rnd < 67
      options.merge({:stubb => true})
      varelse = Monster.overnat_varelse(options)
      while varelse.typ.downcase.include?('utomjordisk')
        varelse = Monster.overnat_varelse(options)
      end
      return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "utomjordisk #{varelse.typ}", :skp_bonus => varelse.skp, :stubb => false}) )
    end
    if rnd < 70
      options.merge({:stubb => true})
      varelse = Monster.overnat_varelse(options)
      while varelse.typ.downcase.include?('från ett annat universum')
        varelse = Monster.overnat_varelse(options)
      end
      return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "#{varelse.typ} från ett annat universum", :skp_bonus => varelse.skp, :stubb => false}) )
    end
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "spök-#{scenario.djur(true)}"}) )                    if rnd < 71
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'kaosvarelse', :ar_rymdskurk => true}) )             if rnd < 72
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'eldvarelse'}) )                                     if rnd < 73
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "levande klump av #{scenario.material_hard}"}) )     if rnd < 74
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => "blobb av #{scenario.material_floating}"}) )         if rnd < 75
    return Monster.new(options.merge({:is_ond => true, :typ => 'mara', :skp_bonus => 35, :is_man => false}) )                   if rnd < 76
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => 'rimturs', :skp_bonus => 20}) )                      if rnd < 77
    return Monster.new(options.merge({:is_ond => (rand(100) < 10), :typ => 'valkyria', :is_man => false}) )                     if rnd < 78
    return Monster.new(options.merge({:is_ond => true, :typ => 'banshee', :is_man => false, :skp_bonus => 30}) )                if rnd < 79
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'formväxlare'}) )                                    if rnd < 80
    return Monster.new(options.merge({:is_ond => (rand(100) < 10), :typ => 'kerub', :is_man => true}) )                         if rnd < 81
    if rnd < 82
      hist = scenario.historie_niva
      if rand(100) < 95
        traveller = Person.new(:scenario => scenario, :attributes => ["Tidsresenär från #{hist}-period"],:stubb => true)
      else
        traveller = Monster.overnat_varelse(:scenario => scenario, :attributes => ["Tidsresenär från #{hist}-period"],:stubb => true)
      end
#      traveller = scenario.ny_person(:scenario => scenario, :attributes => ["Tidsresenär från #{hist}-period"])
      return Monster.new(options.merge({:is_ond => (rand(100) < 30), :typ => "förbannad tidsresande #{traveller.typ} från #{hist}-period."}) ) 
    end
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'vätte', :skp_bonus => 20}) )                        if rnd < 83
    return Monster.new(options.merge({:is_ond => true, :typ => 'vildvittra', :is_man => false, :skp_bonus => 15}) )             if rnd < 84
    return Monster.new(options.merge({:is_ond => (rand(100) < 40), :typ => 'Levande fågelskrämma'}) )                           if rnd < 85
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "Gengångar-#{scenario.random_ras.name}"}) )          if rnd < 86
    return Monster.new(options.merge({:is_ond => (rand(100) < 40), :typ => 'golem', :is_man => (rand(100) < 90)}) )             if rnd < 87
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'homunculus'}) )                                     if rnd < 88
    return Monster.new(options.merge({:typ => 'smöman', :is_man => (rand(100) < 90)}) )                                         if rnd < 89
    return Monster.new(options.merge({:typ => 'yeti'}) )                                                                        if rnd < 90
    return Monster.new(options.merge({:typ => 'bigfoot'}) )                                                                     if rnd < 91
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'reservdelsmänniska'}) )                             if rnd < 92
    return Monster.new(options.merge({:typ => 'Tillverkat monster (som Frankensteins monster)'}) )                              if rnd < 93
    return Monster.new(options.merge({:is_ond => true, :typ => 'besatt robot', :is_man => false, :skp_bonus => Monster.get_skp_bonus}) ) if rnd < 94
    return Monster.new(options.merge({:is_ond => true, :typ => 'antimänniska', :skp_bonus => 30}) )                             if rnd < 95
    return Monster.new(options.merge({:is_ond => true, :typ => 'näcken', :skp_bonus => 120}) )                                  if rnd < 96
    return Monster.new(options.merge({:is_ond => true, :typ => 'skogsrå', :skp_bonus => 20}) )                                  if rnd < 97
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'havsmonster'}) )                                    if rnd < 98
    return Monster.new(options.merge({:is_ond => true, :typ => 'chimera', :skp_bonus => rand(30)}) )                            if rnd < 99
    return Monster.new(options.merge({:is_ond => true, :typ => 'landmanet'}) )                                                  if rnd < 100
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => "en flock jätte-#{scenario.insekt(false)} som fått kollektiv intelligense"}) ) if rnd < 101
    if rnd < 102
      options.merge({:stubb => true})
      varelse = Monster.overnat_varelse(options)
      while varelse.typ.downcase.include?('radioaktiv och lysande')
        varelse = Monster.overnat_varelse(options)
      end
      return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => "radioaktiv och lysande #{varelse.typ}", :skp_bonus => varelse.skp, :stubb => false}) )
    end
    return Monster.new(options.merge({:is_ond => true, :typ => 'myrling', :skp_bonus => 20}) )                                  if rnd < 103
    return Monster.new(options.merge({:is_ond => (rand(100) < 15), :typ => "#{scenario.random_ras.name} med negativ energi"}) ) if rnd < 104
    return Monster.new(options.merge({:is_ond => (rand(100) < 85), :typ => 'Imp', :skp_bonus => rand(30), :ar_rymdskurk => (rand(100) < 30) })) if rnd < 105
    return Monster.new(options.merge({:is_ond => (rand(100) < 95), :typ => 'träsktroll', :skp_bonus => 25}) )                   if rnd < 106
    return Monster.new(options.merge({:is_ond => true, :typ => "lindorm", :ar_rymdskurk => true}) )                             if rnd < 107
    return Monster.new(options.merge({:is_ond => (rand(100) < 50), :typ => 'hippogriff', :ar_rymdskurk => false}) )             if rnd < 108
    return Monster.new(options.merge({:is_ond => (rand(100) < 15), :typ => 'questing beast', :ar_rymdskurk => false}) )         if rnd < 109
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'salamander'}) )                                     if rnd < 110
    return Monster.new(options.merge({:typ => 'kelpie'}) )                                                                      if rnd < 111
    return Monster.new(options.merge({:is_ond => (rand(100) < 60), :typ => 'leprechaun', :is_man => (rand(100) < 90)}) )        if rnd < 112
    return Monster.new(options.merge({:is_ond => (rand(100) < 80), :typ => 'banshee', :is_man => (rand(100) < 5)}) )            if rnd < 113
    return Monster.new(options.merge({:is_ond => (rand(100) < 20), :typ => 'liten söt ullboll, något likt en hamster'}) )
    
  end
  
  def Monster.get_skp_bonus
    rnd = rand(100)
    if rnd < 10
      rnd = rand(100)
      return 4 if rnd < 10
      return 6 if rnd < 25
      return 8 if rnd < 35
      return 12 if rnd < 60
      return 14 if rnd < 80
      return 16 if rnd < 90
    end
    return 18 if rnd < 40
    return 20 if rnd < 60
    return 25 if rnd < 80
    return 30 if rnd < 90
    return 40 if rnd < 95
    return 70 if rnd < 98
    return 101 + rand(100)
  end
  
end
