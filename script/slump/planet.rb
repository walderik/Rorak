# Allt som finns att veta om en viss planet
# Tabell 23
#  Slå först på [Tab. 23.1] där planettypen avslöjas. Sedan skall du
#  slå en gång på [Tab. 23.2] för att ge planeten attribut. Efter det
#  på [Tab. 23.3] för att se om den är bebodd och med vad i så fall.
class Planet
  
  KOLONITYPER = ['provins','ny koloni','koloni','koloni','koloni','straffkoloni','straffkoloni','jordbrukskoloni','hemlig koloni','bortglömd kolini','militär utpost',
                 'slavjägarkoloni', 'protektorat','trädgårdskoloni','vetenskapskoloni']
  
  attr_accessor :name, :civilisation, :attributes, :befolkningar, :planettyp, :bem
  
  def initialize(scenario, bem = nil)
    @scenario = scenario
    @attributes = Array.new
    @befolkningar = Array.new
    
    @name = RandomName.planet
    @planettyp = self.get_planettyp
    if bem.present?
      @befolkningar << bem.name
    elsif rand(100) < 83
      @befolkningar << self.get_befolkning
    end
    while rand(100) < 10 # Fler befolkningar
      @befolkningar << self.get_befolkning
    end
    (rand(3)+1).times do
      @attributes << self.attribute
    end
#    puts 'PANG ' + @name
#    i = 0
#    caller.each do |call|
#      puts call.inspect
#      i += 1
#      break if i > 3
#    end
#    krasch
  end
  
  def to_a
    out = [@name]
    out << 'Typ: ' + @planettyp
    out << 'Befolkning: ' + self.befolkning
    out << 'Civilisation: ' + @civilisation.capitalize if @civilisation.present?
    out << 'Information: '
    @attributes.uniq.each do |attr|
      out << ' - ' + attr
    end
    return out
  end
  
  def to_s
    return self.to_a.join("\r\n")
  end  
  
  def befolkning
    return 'Obefolkad' if @befolkningar.blank?
    return @befolkningar.join(' och ')
  end
  
  def get_planettyp
    types  = ['utslocknad sol','gasjätte','jätteplanet','vattenplanet','isplanet','ökenplanet','tundraplanet','skogsplanet','djungelplanet','asteroid','planet utan sol',
              'isjätte','träskplanet']
    type   = 'jordliknande planet' if rand(100) < 33
    type ||= types.sample
    type  = 'måne till en ' + type if rand(100) < 10
    type  = %w(stor jättestor liten jätteliten).sample + ' ' + type if rand(100) < 50
    type += ' med excentrisk bana' if rand(100) < 5
    type += ' med fina ringar' if rand(100) < 5
    return 'En ' + type
  end
  
  def attribute
    #  15 Krigsplats [Tab. 3]
    #  18 Mutagena effekter [Tab. 21]
    #  20 Livsmiljö [Tab. 20.7]
    #  21 Annat attribut [Tab. 13.3]
    #  22 Saktillverkning [Tab. 17]
    #  23 I brist av saker [Tab. 17]
    #  24 Har en gigantisk härjande... [Tab. 16.2]
    #  25 Består av mycket [Tab. 13.3.1]
    #  26 Okänt högkvarter för en rymdskurk [Tab. 12]
    #  27 Har en fälla [Tab. 7]
    #  28 Gömställe för en skurk [Tab. 11]
    #  29 Annat attribut [Tab. 20.6] ??? Vet inte hur det ska funka. Det är andra attributes på Bems inte en planet.
    #  31 En släkting till någon i gruppen bor här [Tab. 1.1]
    #  32 Enkönad befolkning [Tab. 1.2]
    #  33 Befolkningen är... [Tab. 3.2.2]
    #  36 Majoriteten är [Tab. 3.3.2]

    #  62 Ond ledare [Tab. 1.3]
    #  66 Hotande krig [Tab. 3]
    #  67 Rymdraketsvarv [Tab. 13]
    #  70 Här har gjorts en upptäckt [Tab. 5]
    #  71 Samlande ledare [Tab. 17] och [Tab. 1.3]
    #  79 Revolt p.g.a. något som hänt nyligen [Tab. 3.3]
    #  81 Många övernaturliga varelser [Tab. 9.1]
    #  96 Många försäljare [Tab. 17]
    befolkad = @befolkningar.present? && @befolkningar.length > 0
    rnd = rand(132)
    if rnd < 2
      planet = @scenario.random_planet(self.name)
      if rand(100) < 50
#        xtr = %w(stort välkänt dolt hemligt viktigt vanligt krypterat)
        planet.attributes << "Har ett maskhål till #{self.name}"
        return "Har ett maskhål till #{planet.name}"
      end
      planet.attributes << "Har en portal till #{self.name}"
      return "Har en portal till  #{planet.name}"
    elsif rnd < 4 && befolkad
      tro = @scenario.livsaskadning
      return 'Ont religiöst centrum där man dyrkar ' + @scenario.ond_gud if tro == 'ond'
      return 'Religiöst centrum (' + tro + ')'
    end
    if rnd < 6 && befolkad
      musik = @scenario.musik
      @bem.attributes << "Känd för sin #{musik}" if @bem.present?
      return "Känd för sin #{musik}" if rnd < 5
      return "Överallt hör man störande #{musik}" 
    end
    return "Stora fyndigheter av #{@scenario.material_hard}" if rnd < 7
    return "Befolkningen kan i hemlighet PSI-förmågan #{@scenario.psi_egenskap}" if rnd < 8 && befolkad
    return "Har bubblande sjöar av #{@scenario.material_floating}" if rnd < 9
    if rnd < 13
      planet = @scenario.random_planet(self.name)
      planet.attributes << "Är tvillingplanet till #{self.name}"
      return "Tvillingplanet till #{planet.name}"
    end
    return "Ibland regnar det #{@scenario.material_floating}" if rnd < 14
    if rnd < 16 && befolkad
      tro = @scenario.livsaskadning
      return 'Är mitt uppe i en religiös helgdag åt ' + @scenario.ond_gud if tro == 'ond'
      return 'Är mitt uppe i en religiös helgdag (' + tro + ')'
    end
    if rnd < 19 && befolkad
      things_to_love = ['potatis','klassisk musik', @scenario.musik, @scenario.djur(false),'stadsplanering','tvätta sig','utbilda sig','höga ljud','pengar','mat','vadslagning',
                        'cyklar','sin släkt','kaffe','the','bilar','krig','vetenskap','androider','stora shower','konflikter','debatter','vulkaner','heta källor','naturen',
                        'sina grannar','litteratur','slapstick','uteliv','växtlighet och grönska','kyla','vin','budgetarbete',@scenario.idrott,'sig själva']
      texts = things_to_love.map{|h| 'Nästan alla hatar ' + h}
      texts.concat things_to_love.map{|h| 'Nästan alla älskar ' + h}
      love_hate = texts.sample
      @bem.attributes << love_hate if @bem.present?
      return love_hate
    end
    if rnd < 21 && befolkad
      planet = @scenario.random_planet(self.name)
      planet.attributes << "Har alltid haft folket på #{self.name} som fiender"
      if planet.bem.present? && @bem.present? && planet.bem.name != @bem.name
        planet.bem.attributes << "Har i alla tider alltid haft #{@bem.name} som fiender"
        @bem.attributes       << "Har alltid varit fientliga till #{planet.bem.name}"
      end
      return "Har traditionellt alltid varit fientliga till folket på #{planet.name}"
    end
    if rnd < 22 && befolkad
      if rand(100) < 50
        @bem.attributes << 'Tycker om att jaga vilda djur' if @bem.present?
        return 'Det förekommer en hel del jakt av alla vilda djur'
      end
      djur = @scenario.djur(false)
      @bem.attributes << 'Tycker om jakt av ' + djur if @bem.present?
      return 'Det förekommer mycket jakt på ' + djur
    end
    if rnd < 23
      planet = @scenario.random_planet(self.name)
      krig = ['förödande krig','utnötningskrig','kärnvapenkrig','atombombskrig'].sample
      planet.attributes << "Var tidigare i ett #{krig} med #{self.name}"
      return "Har många radioaktiva glödande kratrar. Var tidigare i ett #{krig} med #{planet.name}."
    end
    if rnd < 25
      feelings = %w{ond ond välmenande hungrig god arg aggresiv gudalik hjälpsam glupsk ensam deprimerad spexig elak bossig manipulativ dominerande lömsk tystlåten mediterande}
      feelings.concat ["känslosam (#{@scenario.kanslor})","känslosam (#{@scenario.kanslor})"]
      return "Själva planeten är en #{feelings.sample} intelligens."
    end
    if rnd < 26 && befolkad
      fobi = Person::FOBITYPER.sample
      @bem.attributes << 'Har fobi mot ' + fobi if @bem.present?
      return 'De flesta här har fobi mot ' + fobi
    end
    return "Är en idrottsplats för #{@scenario.idrott}" if rnd < 27
    if rnd < 28 && befolkad
      idrott = @scenario.idrott
      @bem.attributes << 'Traditionellt älskar dom ' + idrott if @bem.present?
      return 'De flesta här älskar ' + idrott
    end
    if rnd < 29
      monster = Monster.overnat_varelse(:scenario => @scenario, :ar_rymdskurk => true, :skp_bonus => rand(40)+rand(40)+rand(20))
      @scenario.add_npc monster
      return "Härjas av en #{monster.typ} som heter #{monster.name}"
    end
    return "Befolkningen har nyligen blivit #{@scenario.estetik}" if rnd < 30 && befolkad
    return "Många övernaturliga varelser (#{Monster.overnat_varelse(:scenario => @scenario, :stubb => true).typ})." if rnd < 31 && befolkad

    
    texts = ['Har intelligenta ' + @scenario.djur(false), 'Har gigantiska ' + @scenario.djur(false), 'Har urtidsfauna, bland annat ' + @scenario.urtidsdjur(false),
             'Det kryllar av ' + @scenario.insekt(false), 'Vattnet kryllar av ' + @scenario.fisk(false)]
    # Har
    har = ['ett viktigt turistmål','ständigt regn','mycket jordbävningar','låg gravitation','hög gravitation','mycket hett klimat','mycket radioaktivitet',
           'fascinerande värmeväxlings system','köttätande propellerplantor','oceaner av attackfärg','mångmiljonpublik','naturliga raketväxter','inga rovdjur',
           'Flera solar, så att ljuset skiftar hela tiden och allt blir konstigt','många rovdjur','gigantiska maskar','geleaktig yta','många aktiva vulkaner','fantastiska vyer',
           'stora casinon','stora svampar','plötsliga starka skyfall','väldigt kort dygn','mystiska rester av en utdöd civilisation','ett planettäckande nätverk av stora kanaler',
           'hallucinogen atmosfär','ett maskhål till Jorden','fungerar inte strålar','märkliga underjordiska jäsprocesser','kort omloppstid','stora förekomster av gödningsmedel',
           'vacka solönedgångar','massor av sopor','oregelbunden bana','fluktuerande tid i olika zoner på planeten','gummiliknande mark',
           'Kvicksand','många fina vägar','gamla ointagbara fort','många månar','piratradiostation','en mörk och en ljust sida',
           'en ljus och en mörk sida', 'förändligt magnefält','ett väldigt, väldigt starkt magnefält','kryddor','mycket bördig jord',
           'lera','massor av gegga','tryckande atmosfär','hög temperatur','många myrar el träsk','moln av myggliknande varelser','rymdpirater','fuktig atmosfär',
           'årstider som är längre än en generation','flygande öar','många underjordiska floder']
    if befolkad
      har.concat ['gruvbrytning','kryptiskt alfabet','en planekonomi','för många hus','inte uppfunnit begreppet husnummer','många mammor','stor underjordisk fiskeindustri',
                   'inställsam befolkning','girig befolkning','otroligt rik befolkning','urfattig befolkning','bara slavar','viktiga bibliotek',
                   'en stor skogsindustri','linbanor istället för motorvägar','hårdhänta poliser',
                   'en stark militär','en stor flotta','en stor rymdstridsstyrka','en stark säkerhetstjänst','ingen yttrandefrihet',
                   'just nu en större festival','just nu landssorg','politiskt engagerad befolkning',
                   'massor av trafik','befolkning med många konstiga vanor',
                   'mycket vapentillverkning','en rik smyckesindustri','måste man ständigt le',
                   'bygger man dåliga bostäder','skickliga journalister',
                   'rövare','åldrad befolkning','tyraniska banker','viktiga kryddor','myrstacksliknande byggnader']
      if rand(100) < 50
        best = ['universums','galaxens','omgivande planeters','universums'].sample + ' ' + ['bästa','näst bästa','värsta','vackraste','tuffaste','märkligaste'].sample
        har.concat ["#{best} glass", "#{best} vin","#{best} underhållning","#{best} bröd","#{best} mat","#{best} tempererade bad","#{best} massage","#{best} musikproduktion",
                    "#{best} godis","#{best} raketbränsle","#{best} mekaniker","#{best} militär","#{best} smaksinne","#{best} ekologi","#{best} öl","#{best} rymdkrigsflotta",
                    "#{best} litteratur","#{best} cocktails","#{best} rymdbaser","#{best} rymdförsvar","#{best} toaletter"]
      end
      nyans = %w(undermålig liberal sträng icke-existerande stenhård kaotisk stark annorlunda komplicerad).sample
      har.concat ["#{nyans} alkholpolitik","#{nyans} tullkontroll","#{nyans} byråkrati","#{nyans} trafikpolis","#{nyans} utbildning","#{nyans} regering","#{nyans} moral"]
      texts.concat har.map{|h| 'Har ' + h}
    end
    # Är 
    ar = ['ett turistmål','osynlig','ihålig med ett spännande inre','olandningsbar','självlysande','farligt radioaktiv',
          'kraftigt nedsmutsad','skräpig','kall','en stor illusion','rastplats för rymdnomader',
          'tillhåll för rymdpirater','gjord av guld','en begravningsplats','dammig']
    if befolkad
      ar.concat ['ett handelscentrum','ett bildningscentrum','hemplanet till någon i gruppen','en monarki','ett furstdömme','en teokrati',
                 'gyttjig','täckt av gelatin','med i rymd-ping-pong (som ex boll)','överbefolkad','ett fängelse']
    end
    texts.concat ar.map{|h| 'Är ' + h}
    
    # Här är
    har_ar = ['evolutionen racersnabb','många regnbågar','atmostfären narkotisk','inte döden fungerande längre','raketbränsle nästan omöjligt att få tag i']
    if befolkad
      har_ar.concat ['alla kaffeberoende','mutor det normala','man galen i gladiatorspel','alla grotesksnälla - Gulligullplanet','vapen förbjudna','smuggling viktigt',
                    'befolkningen är klädsamt tystlåten','folket vegetarianer','det många personrån','hög skatt på det mesta','teknik mer avvancerad än hästdroska förbjudet',
                    'sport viktigt','såpoperor populära','alla beroende av föryngringsdroger','språket omöjligt att förstå','pengar inte viktigt','bidrag viktigaste inkomstkällan',
                    'modet jätteviktigt','många ekologiskt medvetna']
    end
    texts.concat har_ar.map{|h| 'Här är ' + h}
    
    other = ['Energin förvinner från planeten','Planten ligger lite fel i tiden','Planeten neutraliserar mutationer','Här rostar metall snabbt','Spådomar har en tendens att slå in här',
             'Allt rostar i atmosfären','Här blir drömmar verklighet','Här bränns böcker','Nya uppfinningar är förbjudna',
             'Här saknas gravitationen på vissa platser','Här kryllar det av små sjöar']
    texts.concat other
    if befolkad
      other = ['Skratt är förbjudet','Sorg är förbjudet','Man bor i stora svampar','Här bränns böcker','Befolkningen har en konstig dialekt','Trummor är inne',
               'Bra författare hyllas högst','Litteratur är väldigt viktigt',
               'Alla förväntas föra dagbok','Det pågår ett viktigt val här','Det är tillåtet att låna pengar från framtida generationer','All planering sker på minst 100 år sikt']
    end
    
    res = texts.sample
    while @attributes.include? res
      res = texts.sample
    end
    return res
    # Och så ska alla med egen tabell in också
  end
  
  # Tabell 23.3 - Befolkning - Obefolkad kommer fram genom att man inte slår på den här tabellen
  def get_befolkning
    rnd = rand(100)
    kolonityp = KOLONITYPER.sample
    if rnd < 25
      @civilisation = @scenario.historie_niva if rand(100) < 30
      return ["Människor","Människor","Människor","Människor",'Androider',"Robotar (mest #{Person::ROBOTAR.sample}robotar)"].sample
    elsif rnd < 50
      # Kolla så inte rasen redan är befolkning
      bem = @scenario.random_ras(nil,true)
      while @befolkningar.any?{ |befolkning| befolkning.include?(bem.name) }
        bem = @scenario.random_ras(nil,true)
      end
      @bem = bem
      @civilisation = @scenario.historie_niva
      return @bem.name 
    elsif rnd < 65
      @bem = @scenario.ny_ras(true)
      @bem.attributes << ("Kommer ursprungligen från " + self.name)
      @bem.planet = self
      @civilisation = @scenario.historie_niva
      return 'Ursprungsbefolkningen ' + @bem.name 
    elsif rnd < 70
      return "En #{kolonityp} från #{@scenario.land}"
    elsif rnd < 75
      return "En #{kolonityp} från #{@scenario.land_el_planet}"
    end
    return @scenario.ras
  end
end 
