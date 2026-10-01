# Också känt som ' + 'Aliens'
# Tabell 20 - BeM
class Bem
  attr_accessor :description, :name, :attributes, :planet, :fortplantning, :no_skills
  
  ANIMAL_INTELLIGENS = %w(Intelligenta Människolika Civilisationsskapande Superintelligenta Telepatiska Kloka Begåvade Logiska Aggresiva Djuriska Boklärda Visa Humana Smarta 
                          Empatiska Lättirriterade Visa Grälsjuka Gatusmarta Instinktiva)
  HORRORS = ['fasansfulla','hemska','iskalla','fruktansvärda','skrämmande','skräckingjagande','skoningslösa','osårbara','ostoppbara','obevekliga','outtröttliga','kusliga']
  
  ALIENS_COLORS = %w(gröna gröna blå grå grå rosa röda blodröda halvgenomskinliga guldfärgade silverfärgade skinande vibrerande regnbågsfärgade)
  
  def initialize(scenario, is_befolkning, set_fortplantning=false)
    @scenario = scenario
    @is_befolkning = is_befolkning
    @attributes = Array.new
    @attributes_with_my_name = Array.new
    @no_skills = Array.new
    special_rnd = rand 100
    @description, name_suggestions = special_bem(special_rnd, is_befolkning) # Returnerar nil, nil om inget är specialare
    @name ||= RandomName.bem(name_suggestions)
    if @description.nil?
      @siz           = self.storlek.capitalize
      @int           = self.intelligens
      @kommunikation = self.get_kommunikation if rand(100) < 50
      @env           = self.get_livsmiljo     if rand(100) < 60 || !is_befolkning
      self.set_estetik
      @description   = self.special_attribute(is_befolkning)
      @description ||= ['BEM','Bug Eyed Monsters','Aliens','Rymdvarelser','Utomjordingar','Utomjordingar','Varelser från yttre rymden','Humanoider','Humanoid-liknande'].sample
    end
    @fortplantning   = self.get_fortplantning if set_fortplantning
    @dod             = self.death
    @forflyttning    = self.movement
    if special_rnd > 5 # Se till att sådant som "Gigantiska dammoln" inte får attributes. Det blir för konstigt.
      # Vi borde ha någon form av attributes där man kan lägga till saker utefrån, Bland annat finns val att rasen har speciell magi
      num_attributes = rand(4) + rand(2) + 1
      while @attributes.length < num_attributes
        nytt_attribute = get_attribute
        @attributes << nytt_attribute
        @no_skills << nytt_attribute.gsub(/^Kan /,'') if nytt_attribute.start_with?('Kan ')
      end
    end
    self.set_no_skills
  end
  
  def to_a
    @fortplantning ||= self.get_fortplantning
    out = [@name]
    out << 'Beskrivning:   ' + @description
    out << 'Storlek:       ' + @siz  if @siz.present?
    out << 'Förflyttning   ' + @forflyttning
    out << 'Intelligens:   ' + (@int  || 'Normal').capitalize
    out << 'kommunikation: ' + (@kommunikation || 'Normalt')
    if @env.present?
      out << 'Trivs bäst:    ' + @env
    elsif @planet.present?
      out << 'Trivs bäst:    ' + "#{@planet.planettyp} (#{@planet.name})"
    else
      out << 'Trivs bäst:    Under jordliknande förhållanden'
    end
    out << 'Är vanligen:  ' + ((rand(100) < 30) ? @scenario.livsaskadning(false, false).capitalize : @scenario.livsaskadning(false, true).capitalize) # Konstig kod för minska antalet 'Onda'
    out << 'Fortplantning: ' + @fortplantning
    out << 'Dödssätt:      ' + @dod
    if @attributes.present?
      out << 'Information:'
      @attributes.uniq.each do |attribute|
        out << ' - ' + attribute
      end
    end
    if @no_skills.present?
      out << 'Ofärdigheter:'
      @no_skills.each do |no_skill|
        out << ' * ' + no_skill
      end
    end
    return out
  end
  
  def to_s
    return self.to_a.join("\r\n")
  end  
  
  def is_befolkning?
    return @is_befolkning
  end
  
  #  Tabell 20 - BeM
  #  Slå först på den här tabellen för att se om det är ett specialmonster.
  #  Om det inte blir det, fortsätt då med tabell 20.1 - 20.11
  #  i nummerordning, utan att hoppa över någon av tabellerna
  def special_bem(rnd, is_befolkning)
    #  17-19 Levande rymdraket [Tab 13]
    # Andra kan vara 'blobbar','hyperintelligent ljus'
    rnd += 5 unless is_befolkning
#    return nil, nil if rnd < 33
    storprefixes = %w(Diplicus Giganticus Härskar Mega Superior Super Kejsar Döds Mörker Dark Biggus Riesenisk Regeln Vorgesetzter Dödsmörker Imperator Todesfinsternis Tod Dunkelheit 
                      Ténèbres Swartze Règles Mort Grand Gros)
    color = ALIENS_COLORS.sample
    horror_how = HORRORS.sample
    animal_how = ANIMAL_INTELLIGENS.sample
    animal_how = ['Mycket ','Ganska ','Väldigt '].sample + animal_how if rand(100) < 30
    if rnd < 2
      djur = @scenario.urtidsdjur(false)
      storprefixes << RandomName.last
      name_suggestions = [djur, "#{djur}ius"].concat(storprefixes.collect{|p| "#{p} #{djur}"})
      name_suggestions.concat storprefixes.collect{|p| "#{djur} #{p}"}
      name_suggestions = name_suggestions.map{ |s| s.capitalize }
      @int = self.intelligens
      @no_skills << 'Krossa'                 if rand(100) < 20
      @no_skills << 'Äta fiender'
      @no_skills << 'Osårbar'                if rand(100) < 20
      @no_skills << 'Pansar'                 if rand(100) < 20
      return "Jättelika planetätande #{djur}", name_suggestions
    elsif rnd < 4
      size = ['','','','','','Supergigantiska ','Gigantiska ','Stora ','Små ','Mikroskopiska '].sample
      what = ["#{Person::ROBOTAR.sample}robotar",'maskiner','mördarmaskiner','utrotningsmaskiner','dödsautomater','elektronhjärnor','bärsärkarmaskiner','avrättningsmaskiner'].sample
      name_suggestions = storprefixes.collect{|p| "#{p} #{horror_how} #{what}"}
      @int = self.intelligens
      @no_skills << 'Äta fiender'            if rand(100) < 30
      @no_skills << 'Osårbar'                if rand(100) < 50
      @no_skills << 'Målsöka'                if rand(100) < 40
      @no_skills << 'Pansar'                 if rand(100) < 40
      ray = ['Jordbävnings','Döds','Värme','Kyl','Pest','Maser','X','Lasso','Livsenergi','Radioktivitets','Svaghets','Förvirrings','Galenskaps','Förstorings','Förminskning',
              'Laser','Explosions','Aggresivitetsskapande'].sample
      @no_skills << "Skjuta #{ray}-strålar"
      return "#{size}#{horror_how} #{what} som önskar utplåna allt levande".capitalize, name_suggestions
    elsif rnd < 5
      size = ['','','Supergigantiska ','Gigantiska ','Stora ','Små ','Galaxomspännande '].sample
      what = "interstellära "+['svarta',ALIENS_COLORS.sample].sample + [" dammoln",' gasmoln',' moln av partiklar'].sample
      name_suggestions = nil
      @int = self.intelligens
      @no_skills << 'Dela sig'
      @no_skills << 'Osårbar'                if rand(100) < 20
      @no_skills << 'Osynlighet'             if rand(100) < 30
      @no_skills << 'Krympa/Svälla'          if rand(100) < 70
      @no_skills << 'Tunna ut sig'           if rand(100) < 30
      @no_skills << 'Explodera'              if rand(100) < 30
      return "#{size}#{what}".capitalize, name_suggestions
    elsif rnd < 7
      storprefixes.concat %w(Sjumila Mörka Djupa Dark Gröna Grönare Schumila Grün Vert Greener Healthy Bladdernut Wretched Stormiga Stormy Whimsical Impulsiva Skräckens Horror Fuktiga Moist)
      skogar = %w(Woodland Wood Skog Djungel Thicket Timberland Wilds Timmermark Vildmark Mark Grove Woods Libres Royale Wald Brume Brillante Dschungel Wildnis stürmisch Manjana)
      name_suggestions = Array.new
      storprefixes.each do |p|
        name_suggestions.concat skogar.collect{ |s| "#{p} #{s}"}
      end
      @int = self.intelligens
      @no_skills << 'Dela sig'               if rand(100) < 80
      @no_skills << 'Äta fiender'            if rand(100) < 50
      @no_skills << 'Månggenerationsminne'   if rand(100) < 10
      @no_skills << 'Skjuta projektiler'     if rand(100) < 20
      what = ['växtlighet','skog','tänkande jordlager','mossa','lavar','myselium','nätverk av kanaler','nätverk av skogsdungar','korallrev','slem','regnskog'].sample
      return 'Kollektiv planettäckande '+what, name_suggestions
    elsif rnd < 11
      @int = self.intelligens
      @kommunikation = self.get_kommunikation if rand(100) < 10
      self.set_estetik
      how  = %w(Små Små Stora Långa Smala Tunga Pyttesmå Tjocka).sample
      @siz = ['','','','Ganska ','Väldigt ','Mycket '].sample + how
      @no_skills << 'Osynlighet'             if rand(100) < 30
      @no_skills << 'Telepati'               if rand(100) < 50
      @no_skills << @scenario.psi_egenskap+'-PSI'
      return "#{how} #{color} #{%w(män män humanioder humanioder kvinnor).sample}", %w(blippblipp kling blipp bip bing blong blopp glipp poing ping bling poing biong pling plirr blirr bzzt zapp papp plopp plipp blipp)
    elsif rnd < 14
      how = %w(Jättelika Enorma Gigantiska Stora Människostora).sample
      atr = ['hotfulla','kramande','telepatiska','aggresiva',color,'kletiga','kriminella','gängbildande','svärmande','hyperintelligenta','missbrukande','svällande','slippriga'].sample
      atr = 'mycket ' + atr if rand(100) < 30
      @int = self.intelligens
      @siz = ['','','','Ganska ','Väldigt ','Mycket '].sample + how
      @kommunikation = self.get_kommunikation if rand(100) < 35
      slem = %w(amöbor amöbor iglar sniglar urslem slemsvampar sjögurkor blobbar globbar).sample
      @no_skills << 'Regenerera'             if rand(100) < 50
      @no_skills << 'Slemma' 
      @no_skills << 'Äta fiender'            if rand(100) < 30
      @no_skills << 'Skjuta projektiler'     if rand(100) < 30
      return "#{how} #{atr} #{slem}", ['blob','glob','blub','glub','blobobob','globobob','glolobob','puff','bluff','flupp','pluff','gloff','lobb','blobb','glubbibubb']
    elsif rnd < 16
      horrors = HORRORS + ['snälla','välmenande','fantastiska','normbrytande','omtänksamma','frestande','givmilda','omtänksamma','hjälpsamma','roliga','spexiga','flitiga och produktiva']
      atr = ['',' med raketer',' som flyter',' som drivs av kol',' som slukar uran',' som bara vill väl'," som drivs av #{@scenario.material_floating}"].sample
      @int = self.intelligens
      self.set_estetik
      @siz = ['Stora','Jättestora','Fotbollsplansstora','Stor som en stad','Stora som hus'].sample
      @no_skills << 'Bygga kopior av sig själv'
      @no_skills << 'Skjuta projektiler'     if rand(100) < 90
      @no_skills << 'Mångdimensionalogi'     if rand(100) < 20
      @no_skills << 'Osårbar'                if rand(100) < 30
      @no_skills << 'Ostoppbar'              if rand(100) < 40
      @no_skills << 'Räkna svåra tal'        if rand(100) < 30
      @no_skills << 'Pansar'                 if rand(100) < 20
      @no_skills << 'Regenerera'             if rand(100) < 60
      @no_skills << 'Ge energi'              if rand(100) < 40
      return "Levande #{horrors.sample.capitalize} fabrikskomplex#{atr}", nil
    elsif rnd < 19
      @no_skills << 'Flyga'
      @no_skills << 'Ignorera gravitationen' if rand(100) < 90
      @no_skills << 'Skjuta projektiler'     if rand(100) < 90
      @no_skills << 'Mångdimensionalogi'     if rand(100) < 20
      @no_skills << 'Pansar'                 if rand(100) < 20
      return "Levande rymdraket [Tab 13]", nil
    elsif rnd < 21
      @int = self.intelligens
      self.set_estetik
      @no_skills << 'Skapa liv'
      @no_skills << 'Ignorera gravitationen' if rand(100) < 30
      @no_skills << 'Bygga kopior av sig själv' if rand(100) < 30
      @no_skills << 'Osårbar'                if rand(100) < 30
      @no_skills << 'Regenerera'             if rand(100) < 30
      @no_skills << 'Ge energi'              if rand(100) < 20
      @no_skills << 'Gudsemulering'          if rand(100) < 20
      return "Genetisk fabrik som bygger massor av #{@scenario.random_ras(self.name).name}", storprefixes if is_befolkning
      return "Genetisk fabrik som svävar runt i rymden och bygger massor av #{@scenario.random_ras(self.name).name}", storprefixes
    elsif rnd < 25
      energi = %w(energi energi ljus ljusfälts elektricitet magnetism radioaktivitets röntgen värme köld elektromagnetism gravitations känsloenergi).sample
      @int = self.intelligens
      @kommunikation = self.get_kommunikation if rand(100) < 15
      self.set_estetik
      @siz = ['','','','Ganska ','Väldigt ','Mycket '].sample + self.storlek.capitalize
      @no_skills << 'Ge ' + energi
      @no_skills << 'Neutralisera '+energi   if rand(100) < 40
      @no_skills << 'Regenerera'             if rand(100) < 30
      return "#{color.capitalize} #{energi}-varelser"
    elsif rnd < 27
      @no_skills << 'Resa i tiden'
      @no_skills << 'Regenerera'             if rand(100) < 30
      @int = self.intelligens(animal_how)
      riktning = %w(runt genom framåt hit hit uppåt).sample
      return "#{animal_how} #{@scenario.djur(false)} som färdats #{riktning} tiden från en '#{@scenario.historie_niva}'-nivå", nil
    elsif rnd < 29
      @int = self.intelligens(animal_how)
      liknande = ['','','','-liknande'].sample
      return "#{animal_how} #{@scenario.djur(false)}#{liknande}", nil
    elsif rnd < 30
      @int = self.intelligens(animal_how)
      liknande = ['','','','-liknande'].sample
      @no_skills << 'Studsa'                 if rand(100) < 20
      return "#{animal_how} #{@scenario.mamalian(true)}#{liknande}-människor", nil
    elsif rnd < 32
      riktning = %w(runt genom framåt hit hit uppåt).sample
      monster = Monster.overnat_varelse(:scenario => @scenario, :stubb => true)
      @int = 'Normal för sin sort'
      @no_skills << 'Resa i tiden'           if rand(100) < 30
      @no_skills << 'Äta fiender'
      @no_skills << 'Osårbar'                if rand(100) < 90
      @no_skills << @scenario.magityp(true)  if rand(100) < 70
      return "Övernaturlig varelser (#{monster.typ}) som färdats #{riktning} tiden från en '#{@scenario.historie_niva}'-nivå"
    elsif rnd < 33
      thing = ['träd','växter','svampar','blommor','köttätande växter','lianer','orkideer','ekar','gigantiska träd','giftig murgröna'].sample
      @int = self.intelligens(animal_how)
      @kommunikation = self.get_kommunikation if rand(100) < 20
      self.set_estetik
      @no_skills << 'Telepati'
      @no_skills << 'Regenerera'             if rand(100) < 50
      @no_skills << 'Månggenerationsminne'   if rand(100) < 70
      @no_skills << @scenario.magityp(true)  if rand(100) < 40
      return "#{animal_how} #{thing}", nil
    elsif rnd < 34
      # Här måse vi sätta namnet direkt.
      prefixes = %w(Kollektivet kollektiva Gemensamma Assimilationen Konfederationen Gemenskapen Gruppen Mängden Alla Stora Bara Förenade United Join Annex Consort
                    Harmoniska Harmony Allierade Fredliga Kombinerade Vereinigt Zusammen Uni Unionen Unis Enkla Basic Pacifique Friedlich)+storprefixes
      self.name = RandomName.bem(prefixes)
      ut = "Kollektiv av assimilerade raser. Däribland "
      raser = Array.new
  #    2.times do 
      (rand(4)+1).times do 
        ras = @scenario.random_ras(self.name, is_befolkning)
        ras = @scenario.ny_ras(is_befolkning, false) if raser.include? ras
        asim = ['Helt','De flesta individer är','Alla produktiva individer är ','Fullständigt','Några är','Alla kvinnor är','Alla män är','Alla vetenskapsmän','Alla barn',
                'Alla militärer','Alla forskare'].sample
        ras.attributes << "#{asim} assimilerade av #{self.name}"
        raser << ras
      end
      ut << raser.collect{ |ras| ras.name }.join(' och ')+'.'
      @int = self.intelligens(animal_how)
      @kommunikation = self.get_kommunikation if rand(100) < 20
      @no_skills << 'Telepati'               if rand(100) < 80
      @no_skills << 'Månggenerationsminne'
      @no_skills << 'Byta kropp'             if rand(100) < 50
      return ut
    end
    return nil, nil
  end
  
  
  def set_estetik
    estetik = @scenario.estetik
    @attributes << estetik if estetik.downcase != 'normala'
  end
  
  # Tabell 20.1 - Storlek
  def storlek
    rnd = rand 110
    if rnd < 3
      @no_skills << 'Osårbar'
      @no_skills << 'Förtunnna sig'          if rand(100) < 20
      return 'odefinierbar storlek'
    end
    if rnd < 9
      @no_skills << 'Svälla'                 if rand(100) < 50
      @no_skills << 'Krympa'                 if rand(100) < 50
      return 'växlande storlek'
    end
    if rnd < 11
      @no_skills << 'Dela sig'               if rand(100) < 50
      return 'mikroskopiskt små'
    end
    return 'förstoringsglas behövs' if rnd < 13
    return 'tummstora'              if rnd < 18
    return 'pyttesmå'               if rnd < 25
    return 'mindre än människor'    if rnd < 35
    return 'människostora'          if rnd < 50
    return 'medelstora'             if rnd < 60
    return 'större än människor'    if rnd < 67
    if rnd < 70
      @no_skills << 'Svälla'                 if rand(100) < 30
      return 'tjocka'
    end
    if rnd >= 76 && rnd < 98
      @no_skills << 'Krossa'
      @no_skills << 'Ostoppbar'              if rand(100) < 70
      @no_skills << 'Ignorera gravitationen' if rand(100) < 30
    end
    return 'jättestora'             if rnd < 75
    return 'stora som hus'          if rnd < 78
    return 'fotbollsplansstora'     if rnd < 82
    return 'jättelika'              if rnd < 86
    return 'stora som en stad'      if rnd < 91
    return 'gigantiska'             if rnd < 95
    return 'större än gigantiska'   if rnd < 98
    if rnd < 100
      @no_skills << 'Osårbar'                if rand(100) < 70
      @no_skills << 'Osynlighet'             if rand(100) < 50
      @no_skills << 'Förtunnna sig'          if rand(100) < 30
      return 'ej av fast materia'
    end
    return 'människostora'
  end
  
  # Tabell 20.2 - Intelligens
  def intelligens(animal_how = nil)
    # 73-87 Vetenskapliga genier [Tab. 5.1]
    rnd = rand 100
    how = ['Mycket ','Ganska ','Väldigt ','Otroligt ','Lite ','','','','','','',''].sample
    return "#{how}instinktiva"               if rnd < 6
    return "#{how}dumma"                     if rnd < 16
    if rnd < 25
      if animal_how.nil?
        animal_how = ANIMAL_INTELLIGENS.sample
      end
      return how + how + animal_how if rand(100) < 25
      return how + animal_how
    end
    return 'kollektiv intelligens'           if rnd < 31
    return 'normalhög intelligenta'          if rnd < 40
    return 'mänsklig intelligens'            if rnd < 50
    return 'anpassar sig efter omgivningen'  if rnd < 53
    return "#{how}smarta"                    if rnd < 70
    if rnd < 72
      return "blir smartare genom att #{['äta','dricka','konsumera','lösa upp och suga i sig','lura i sig','klösa i sig'].sample} andras " + 
             %w(intelligens hjärnor känslor ryggmärgsvätska tankar hjärtan).sample
    end
    if rnd >= 87 && rnd < 90
      @no_skills << 'Räkna svåra tal'
      @no_skills << 'Mångdimensionalogi'     if rand(100) < 5
    end
    return "vetenskapliga genier [Tab. 5.1]" if rnd < 87
    return "otroliga genier"                 if rnd < 90
    if rnd < 95
      @no_skills << @scenario.magityp(true)  if rand(100) < 70
      @no_skills << 'Gudsemulering'          if rand(100) < 20
      @no_skills << 'Spå framtiden'          if rand(100) < 70
      return "övernaturliga genier"
    end
    return "deras intelligens går inte att definiera enligt våra mått."
  end
  
  # Tabell 20.4 - Kommunikation
  def get_kommunikation
    rnd = rand 60
    how = ['','','','','','','','','fnittrande ','pipigt ','mullrande ','snabbt ','långsamt ','skorrande ','stelt ','surrande ','hest ','viskande ','skrikande ','tutande '].sample
    return "Talar #{how}som i " + @scenario.land              if rnd < 3
    return "Talar #{how}en urgammal variant av det man talar i " + @scenario.land if rnd < 5
    return "Talar #{how}språket i " + @scenario.land          if rnd < 10
    return "Kommunicerar inte på något begripligt sätt"       if rnd < 18
    if rnd < 23
      via = "en #{how}blandning av språken på #{@scenario.land} och #{@scenario.land_el_planet}"
    elsif rnd < 25
      via = 'teckenspråk från ' + @scenario.land_el_planet
    elsif rnd < 26
      via = "#{['utbyte av','viftande med','förflyttning av'].sample} #{@scenario.material_hard}"
    end
    via ||= ['lukter','ljussignaler','gester','hopprörelser','antydningar','feromoner','skrivtecken','drickande','mutationer','beröringar','kroppsspråk','gåvor','elektriska stötar',
             'danssteg','beröringar','matematiska uttryck','logiska konstruktioner','minspel','eget teckenspråk','radiovågor','radioaktivitet','lerkastning','strider',
             'doftmarkeringar','poesi','ristade symboler','hudfärg','vislingar'].sample
    
    via = 'mycket exakta ' + via                       if rand(100) < 10
    via = 'rytmiska ' + via                            if rand(100) < 10
    via << ' på vers'                                  if rand(100) < 10
    via << ' utan ' + ['verb','substanstiv','pluralformer','första person','räkneord','räkneord högre än två'].sample if rand(100) < 10
    if via.include?('mutationer')
      @attributes << "Använder #{@scenario.mutation} för kommunikation"
    end
    return "Kommunicerar via " + via
  end
  
  
  # Tabell 20.5 - Special attribut
  def special_attribute(is_befolkning)
    rnd = rand(90)+10
    return nil if rnd < 58
    return "#{%w(Avkomma Barn Utalstringar Yngel).sample} av #{@scenario.ond_gud}" if rnd < 61
    return "En himlakroppsvarelse - #{HimlaKropp.random(@scenario)}"               if !is_befolkning && rnd < 63
    return ALIENS_COLORS.sample + ' intelligenta nyanser'                          if rnd < 64
    description   = 'Varelser som liknar ' + @scenario.djur(false).capitalize      if rnd < 71
    description ||= "Varelser av #{@scenario.material_hard}"                       if rnd < 73
    description ||= ['Dimensionsskiftare','Elektricitetsvarelser','Skapare','Kollektiv intelligens','Rymdhålsantikroppar','Kattliknande varelser','Drakliknande varelser',
                     'Grodliknande varelser','Hundliknande varelser','Människolika','Växtvarelser','Musselliknande, ev med ben','Nästan humanoida','Dinosaurievarelse',
                     'Balongliknande varelser'].sample
            
    description = 'Kiselbaserade ' + description                                   if rand(100) < 5
    description = 'Mångdimensionella ' + description                               if rand(100) < 5
    description = 'Maskinella ' + description                                      if rand(100) < 5
    return description
  end
  
  # Tabell 20.6 Attribut
  def get_attribute
    #  Verktygsförsedda [Tab. 17.2]
    #  Soldater [Tab. 19]
    max = 116
    if rand(max) < 1
      no_skill = "#{@scenario.mutationsperiod} #{@scenario.mutation}"
      @no_skills << no_skill
      return "Kan #{no_skill}" 
    end
    return "Kan regerenrera"           if rand(max) < 1
    return "Kan regerenrera #{@scenario.kroppsdel}"           if rand(max) < 1
    return "Består devlis av #{@scenario.material_hard}"      if rand(max) < 1
    return "#{%w(Bra Mästare Älskar Gillar Ogillar).sample} på #{@scenario.musik}" if rand(max) < 1
    return "Kan #{@scenario.magityp(true)}"                   if rand(max) < 1
    return "Har #{rand(6)+rand(6)+2} armar"                   if rand(max) < 1 && self.attributes.none?{ |str| str.include?(' armar')}
    return "Har #{rand(6)+rand(6)+rand(6)} ben"               if rand(max) < 1 && self.attributes.none?{ |str| str.include?(' ben')}
    return "Har #{rand(6)} huvuden"                           if rand(max) < 1 && self.attributes.none?{ |str| str.include?(' huvud')}
    return "Har #{rand(6)+rand(6)+rand(100)} ögon"            if rand(max) < 1 && self.attributes.none?{ |str| str.include?(' ögon')}
    return "Har #{rand(3)+rand(3)+1} svansar"                 if rand(max) < 1 && self.attributes.none?{ |str| str.include?(' svansar')}
    return "#{Person::SAMLA.sample}samlare"                   if rand(max) < 1
    return "#{%w(Dreglar Slemmar Spottar Utsöndrar Svettandes Gråter Dricker Kräks).sample} #{@scenario.material_floating}" if rand(max) < 4
    return "Vätskeupbyggda av #{@scenario.material_floating}" if rand(max) < 1
    return "Kan spruta #{@scenario.material_floating}"        if rand(max) < 1
    return ['politik',@scenario.musik,'handel','logistik','retorik','kurragömma','sprängämnes','terror','vapen'].sample.capitalize + '-genier' if rand(max) < 1

    if rand(max) < 1
      askadning = @scenario.livsaskadning(false)
      return askadning.capitalize + ' religiösa fanatiker som dyrkar ' + @scenario.ond_gud if askadning.include? 'ond'
      return askadning.capitalize + ' religiösa fanatiker'
    end
    if rand(max) < 1
      ras = @scenario.random_ras(self.name, false)
      ras.attributes  << "Har förslavat #{self.name}"
      self.attributes << "Slavras till #{ras.name}"
    end
    if rand(max) < 4 && self.attributes.none?{ |str| str.include?('symbios')}
      ras = @scenario.random_ras(self.name, true)
      ras.attributes  << "Är i en symbios till #{self.name}"
      self.attributes << "Är i en symbios till #{ras.name}"
    end
    if rand(max) < 1 
      psis = Array.new
      (rand(4)+1).times do
        psis << @scenario.psi_egenskap
      end
      return 'Kan '+psis.join('-PSI och ')+'-PSI'
    end
    if rand(max) < 1
      mat   = @scenario.ray if rand(100) < 5
      mat ||= ['rost','radioaktivitet','insekter','växter','kött','olja','arsenik',@scenario.material_hard, 'böcker','kläder','rått kött','allt möjligt','levande föda',
               'gräs','maskar','ostron','saker med stark lukt','gammalt kött','solstrålar','fett',@scenario.material_floating,'ost','ljud','skräck'].sample 
      return ['Äter ','Äter ','Lever på ','Älskar äta ','Blir illamående av ','Frossar på '].sample + mat
    end
    if rand(max) < 1 && self.attributes.none?{ |attr| attr.include?('parasit')}
      if rand(100) < 30
        ras = @scenario.random_ras(self.name, false)
        ras.attributes  << "Har #{self.name} som parasiter"
        return "Är parasiter till (lever av) #{ras.name}"
      else
        return 'Lever som parasit på ' + [@scenario.djur(false),'träd','människor','andra av sin sort',@scenario.djur(false),'stora havsdjur','stora däggdjur',
                'rymdhål','vattenvarelser','natten','drömmar'].sample
      end
    end
    return ['Svimmar','Flyr','Kräks','Anfaller vilt','Skriker','Gömmer sig','Anfaller blint','Springer iväg'].sample + ' vid stress eller fara' if rand(max) < 1
    
    if rand(max) < 2
      return ['Älskar','Hatar','Tycker om','Ogillar'].sample + ' ' + 
             ['mörker','skönhet','järnvägar','rymden','barn','skog','stress','att gräva','jakt','strid','äventyr','pengar','fred',@scenario.djur(false),@scenario.material_hard,
             @scenario.idrott,@scenario.land,'planera','stå i kö','rättvisa','bada bastu'].sample
    end
    
    return "Strålar " + @scenario.ray if rand(max) < 1
    
    return ['Metallvarelser','Tentaketförsedda','Vårtiga','Bubblande','Vingförsedda','Huvudlösa','Ormboliknande','Platta','Gröna',ALIENS_COLORS.sample,'Rakbladsförsedda',
            'Mycket tänder','Klor','Håriga','Pratglada','Ulliga','Ögon på skaft','Hovar','Smala lemmar','Skelettansiken','Skrynkliga','Prickiga','Syrautsöndrande',
            'Gummiliknande','Vitmenade','Illaluktande','Gillar handel','Gillar gömma saker för bättre tider','Pung på magen','Gasuppbyggda','Hundratals ben',
            'Upprättstående','Juridiska genier','Affärsmässiga','Saknar känslor','Amorfa','Smidiga','Graciösa','Kameleonter','Forförändrare','Hjulförsedda','Fyrkantiga',
            'Trädliknande','Vill bli Galactiv Overlords','Kubiska','Har sugkoppar','Benrangel','Saknar skellet','Har exoskellet','Zeppelinarliknande','Kräks ofta',
            'Hypnotiserande','Halvgenomskinliga','Har propeller','Ormlika','Fjälliga','Snabbrörliga','Betar','Giftiga','Radioaktiva','Fruktansvärt starka','Nomader',
            'Väldigt svaga','Orkar inte gå själva','Sexgalna','Kalla','Har kroppstemperatur under fryspunkten','Har kroppstemperatur över 100 grader','Eldsprutande',
            'Lättare äm luft','Radarsinne','Röntgenblick','Svampartade','Piprökande','Stenliknande','Roterande','Superhörsel','Hungriga','Matfixerade','Har raketer',
            'Konstintresserade','Spinner nät','Vansinniga','Blodsugare','Spelgalna','Filosofiskt lagda','Depressivt lagda','Mångfacetterade ögon','Humorlösa','Lättantända',
            'Byråkrater','Självlysande','Antenner','Snabbförökande','Kan bli flytande','Skör kropp','Elektriska','Glasliknande kropp','Mjuk kropp','Kannibaler',
            'Skägg','Långt hår','Vill göra allt med långa ceremonier','Förstår inte konceptet "egendom"','Anser ära väldigt viktigt','Ser ära i bra stölder','Lekfulla',
            'Ser ära i att lura andra','Kan öppna maskål','Kan förlänga sina lemmar','Har snabel','Flockvarelser','Ärver minnet från sina föräldrar',
            'Har ett kollektivt minne','Alla honor har dött ut','Alla hanar har dött ut','Kan inte längre få barn','Saknar begreppet "jag"','Kan leva i vacuum',
            'Totala individualister','Kan jungfrufödas','Slemmiga','Behöver inte vaccineras','Orsakar allergi hos de flesta','Flintskalliga','Tycker inte om att vara stilla',
            'Kan lyssna på radiovågor','Vill vara vänner','Nattaktiva','Pung på ryggen','Är så bra på matte att de inte behöver räknestickor','Lever i århundraden',
            'Blir bara ett par år gamla','Tycker inte om att säga ja till saker','Äventyrliga','Dreglar när de äter','Pasifister','Teologer','Revirägande',
            'Behöver dykardräkt i normal atmosfär','Kan aldrig byta åsikt','Behöver vara fuktiga','Drar gärna ordvitsar','Blir lätt distraherade','psykopater','scisofrena',
            'Behöver ingen sömn','Tål nästan alla gifter','Asätare','Jagar med fällor','Krigiska','Svårt att lite på andra','Uppfinningsrika','Har stora ögon',
            'Har simhud mellan fingrar och tår','Har stora, slaka öron','Öronen är spetsiga','Består mest av fett','Dör om deras partner dör','Kapitalister','Vallar skog',
            'Speciellt minne: Oviktigt glöms direkt och viktigt glöms aldrig','Snåla','Generösa'].sample
  end
  
  # Tabell 20.7 - Livsmiljö
  def livsmiljo
    rnd = rand 100
    return 'I vatten'                         if rnd < 5
    return 'I ' + @scenario.material_floating if rnd < 10
    return 'Under stort tryck'                if rnd < 13
    return 'Under hög gravitation'            if rnd < 18
    return 'Vid jordliknande förhållanden'    if rnd < 28
    return 'I lava'                           if rnd < 32
    if rnd < 36
      himlakropp = HimlaKropp.new(@scenario, @planet)
      if himlakropp.planet.present? && !himlakropp.planet.befolkningar.include?(self.name)
        himlakropp.planet.befolkningar << self.name
      end
      return 'På ' + himlakropp.typ
    end
    return 'I hetta'                          if rnd < 40
    return 'På en isplanet'                   if rnd < 44
    return 'I absoluta nollpunkten'           if rnd < 48
    return 'I luften'                         if rnd < 57
    return 'Vid lågt tryck'                   if rnd < 61
    return 'I vakum'                          if rnd < 65
    return "I #{%w(låg hög ingen).sample} gravitation" if rnd < 74
    return 'I en syre/väte-stmosfär'          if rnd < 78
    return 'I dimma'                          if rnd < 79
    return 'I radioaktivitet'                 if rnd < 83
    return 'Överallt'                         if rnd < 89
    return 'I grottor'                        if rnd < 94
    return 'I absolut mörker'                 if rnd < 97
    return "I magisk omgivning (#{@scenario.magityp(true)})"
  end
  
  def get_livsmiljo
    return self.livsmiljo + ', ' + self.livsmiljo if rand(100) < 30
    return self.livsmiljo
  end
  
  # Tabell 20.9 - Fortplantning
  def get_fortplantning
    max = 77
    agg = ['','','','','','','','','','Äggläggande, ','Äggläggande, ','Befruktar andras ägg, ','Med sporer, ','Med pollen, '].sample
    return "#{agg}Har två olika kön"                  if rand(max) < 33
    return "#{agg}Har #{rand(6)+1} kön"               if rand(max) < 10
    return "#{agg}Har #{rand(40)+3} kön"              if rand(max) < 3
    return "#{agg}Varje individ har #{rand(3)+2} kön" if rand(max) < 7
    return "Genom delning"                            if rand(max) < 7
    return "Varje individ bygger sin egen avkomma"    if rand(max) < 4
    return "Dom byggs och skapas av andra"            if rand(max) < 4
    return "#{agg}Har ett kön / Jungfrufödande"       if rand(max) < 4
    return "Fortplantar sig inte"                     if rand(max) < 3
    if rand(max) < 2
      text ="#{agg}Flerfasgenerationer. Olika varelser i varje cykel. Första generationen är " + self.name + '. Sedan följer '
      bems = Array.new
      (rand(4)+2).times do
        bem = @scenario.random_ras(self.name, self.is_befolkning?)
        if bem.fortplantning.present? && bem.fortplantning.include?('Flerfasgen')
          bem = @scenario.ny_ras(self.is_befolkning?, false)
        end
        bems << bem
      end
      text << bems.map{ |bem| bem.name }.compact.join(', ')
      bems.each do |bem|
        bem.fortplantning = text
      end
      return text
    end
    return "#{agg}Har två olika kön" 
  end
  
  # Tabell 20.10 - Dödshändelse
  def death
    rnd = rand 106
    extra =['','','','','','','','','Skriker sorgset och ', 'Springer runt brinnande och ','Dör långsamt och sedan ','Gör en kraftfull attack mot närmaste fiende och ',
            "Utsöndrar en massa #{@scenario.material_floating} och sedan ",'Skickar ut ett varningsrop och '].sample
    return extra+'Exploderar'                        if rnd < 6
    return extra+"Exploderar till flygande fragment av #{@scenario.material_hard}" if rnd < 10
    return extra+'Imploderar'                        if rnd < 16
    return extra+"Smälter till #{@scenario.material_floating}" if rnd < 24
    return extra+"Förgasas"                          if rnd < 29
    return extra+"Förstenas"                         if rnd < 32
    return extra+"Faller i bitar"                    if rnd < 35
    return extra+"Blir en våt fläck"                 if rnd < 44
    return extra+"Blir frätande syrapöl"             if rnd < 40
    return extra+"#{%w(Exploderar Sprängs Delas Kvantsplittas Fördelas).sample} till #{rand(6)+1} #{%w(mindre mindre argare större).sample} #{self.name}" if rnd < 48
    return extra+"Luften åker ur dom som en ballong" if rnd < 56
    return extra+"Fattar eld"                        if rnd < 64
    return extra+"Upplöses till stoft"               if rnd < 73
    if rnd < 76
      planet = @scenario.random_planet
      planet.attributes << "Sista vilan för alla #{self.name}"
      return extra+"Förflyttas för en sista vila på #{planet.name}"
    end
    return extra+"Liket teleporteras till #{@scenario.plats}" if rnd < 77
    return extra+"Faller ihop (vanlig död)"
  end
  
  
  # Tabell 20.11 - Förflyttning
  def movement
    rnd = rand 124
    return 'Går'                     if rnd < 15
    return 'Springer'                if rnd < 25
    return 'Hoppar'                  if rnd < 30
    return 'Studsar'                 if rnd < 35
    return 'Klättrar'                if rnd < 45
    return 'Svingar'                 if rnd < 50
    return 'Krälar'                  if rnd < 55
    return 'Slingrar'                if rnd < 60
    return 'Rullar'                  if rnd < 65
    return 'Slipprar'                if rnd < 70
    return 'Flyger, tyngre än luft'  if rnd < 80
    return 'Glidflyger'              if rnd < 85
    return 'Flyger, lättare än luft' if rnd < 90
    return 'Gräver sig fram'         if rnd < 95
    return 'Voltar'                  if rnd < 100
    return 'Går'                     if rnd < 120
    return 'Teleporterar sig'
  end
  
  def set_no_skills
    how_many_times = 1
    how_many_times +=1 if rand(100) < 30
    how_many_times +=1 if rand(100) < 10
    how_many_times +=1 if rand(100) < 3
    @no_skills.uniq!
    while @no_skills.length < how_many_times
      no_skill = @scenario.no_skill
      @no_skills << no_skill unless @no_skills.include? no_skill
    end
  end
end