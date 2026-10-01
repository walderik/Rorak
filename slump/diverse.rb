require "pp"
# Diverse små och okomplicerade saker som mest genererar okomplicerade strängar
module Diverse
  
  PSI_EGENSKAPER = ['Höra avlägsna röster','Höra hjälpande röster','Prekognition (se viktiga händelser i framtiden)','Sanndrömmar','ESP','Höra radiovågor',
                    'Transmutation (förvandla saker till en annan sak)','Se andar','Hypno-suggestioner','Telepati','Telepati','Telepati','Telepati',
                    'Clairvoyante (se avlägsna föremål eller händelser)','Psykokinesi (förflytta föremål)','Fysisk skyddssköld','Psykisk skyddsköld',
                    'Psykisk attack','Göra föremål heta/kalla','Deja vu (framtidsminne)','Paraoptik (se med huden)','Framkalla poltergeists','Levitation (sväva)',
                    'Psykometri (läsa en saks historia eller ägare genom beröring)','Psykopyretik (tända eld på saker)','Göra sig osynlig',
                    'Tankebilder (ta fotografier av andar eller osynliga väsen)', 'Tur eller otursmanipulator','Kreativitet (skapa grejer ur intet, av ingenting)',
                    'Okänslig för smärta','Behöver ej mat, dryck eller annat bränsle','Teleportation','Teleportation',
                    'Påverka centrala kroppsfunktioner, som t ex puls eller andning','Skicka ut hallucinationer','Spränga föremål med tanken',
                    'Spränga varelser med tanken','Få folks hjärnor att koka','Mesmerism, animalisk magnetism','Fantastisk charm','Stigmatisering']
                    
  MTRLS_FLOATING = ['terpentin','syra','slem','gelatin','vatten','alkohol','urin','blod','tid (ja, det är en vätska, kanske)','olja','kvicksilver','brom','fludium',
                    'jod','bensin','tjära','flytande uran','supraledare','Supranäring','Gift','Nitroglycerin','Flytande ondska','Svavelsyra','Kungsvatten','Klor','Saltvatten',
                    'galla','te','kaffe','metanol','flytande entropi','raketbränsle','rengöringsmedel','såpa','träsprit']
  
  FEELINGS       = %w(kärlek hat sorg förälskelse maktbegär dominans ilska glädje beskyddande upphetsning rädsla skräck trötthet empati vrede oro likgiltig)
  
  COUNTRIES       = %w(Mexiko Kanada Irland England Skottland Wales Normadie Frankrike Italien Vatikanstaten Spanien Portugal Tyskland Bayern Schweiz Liechtenstein Ryssland
                       Kina Tibet Turkiet Israel Sahara Arabien Sverige Norge Danmark Island Indien Rajistan Östereuropa Anderna Amazonas Afrika Centralafrika Antarktis
                       Sibirien Kina Grönland Australien Månen Ukraina Monaco Taklamakanöknen Tonga Japan Ukraina Amasonas)
                       
  MYTHIC_COUNTRIES = ['Leng-platån','Shangri-la','Svartalvheim','Nod, landet öster om Eden','Agharta','Atlantis','El Dorado','Mu','Lemuria','Bermudatriangeln','Påskön',
                      'Prästkungen Johannes Rike','Arkadien','Asgård','Jotunheim','Zanzibar','Avalon','Hy-Brazil','Edens trädgård','Hyperborea',
                      'Blåkulla','Andra sidan regnbågen','Helvetet','Månens mörka baksida','Arkadien','Berget Olympus','Jordens insida']
                      
  MYTHIC_PLACES = ['Gamla Bagdad','Dis, satans huvudstad','Sodom','Gomorra','Kheopspyramiden','Värdens tak','Regnbågens slut','Mitten av nästa vecka',"R’lyeh",'Tartarus',
                   'Vindarnas hem','Öster om månen och väster om solen','Västpolen','östpolen','Tidens slut','Camelot','Simrishamn','Melniboné','Dantes inferno','Niflheim',
                   'Den gråaste torsdagen i november','Det svarta hålet i Calcutta','Den blinde barberarens klippsalong','Casablanca','Samarkand','Ultima Thule','Valhall',
                   'Illuminatis högkvarter','Hangar 16','Barsoom (Carters Mars)','Stonehenge','Glastonbury','Tenochtitlan','Ixtlan','Nangiala (Lejonhjärtas hem)',
                   'Oz','Platons Staten','Platons Idévärld','Thomas Moores Utopia','Schlaraffenland','Elefanternas kyrkogård','Lilliputtarnas land','Nirvana','Limbo',
                   'Monsterön','Dödskalleön','Moreaus ö','Axis mundi (center av Jorden mellan Himlen och Helvetet)','Elysium','Livets källa','Hel','Iram','Area 51']
  
  
  # Tabell 3.2.1
  # Olika raser / folk och liknande som kan användas här och där. Mest som parter i krig.
  def ras
#    46-52 Invasionsarme som har kämpat vidare/försöker på annan plats [Tab. 2]
#    60-66 1D6 Rymdskurkar [Tab. 12]
#    67-70 Rymdskurk, 1 st [Tab. 12]
#    71-72 PSI-kunniga människor [Tab. 26] med ursprung från [Tab. 27.1]
#    95-96 Forskargrupp [Tab. 5.1]
    rnd = rand(100)
    if rnd < 13
      ras = self.random_ras(nil, true)
      ras.attributes << "Anses vara rymdmonster"
      return "Rymdmonsterrasen #{ras.name} på #{self.historie_niva}-nivå"
    elsif rnd < 15
      ras = self.ny_unik_ras
      ras.attributes << "Enstöringar"
      ras.attributes << "Fruktansvärda monster som kan terrorisera en hel planet"
      monster = Monster.new(:scenario => self, :is_man => (rand(100) < 50), :is_ond => true, :typ => ras.name, :ar_rymdskurk => true, :skp_bonus => Monster.get_skp_bonus+25)
      monster.ras = ras
      self.add_npc monster
      return "Ett enskilt monster (#{monster.name}) som är en #{ras.name}"
    elsif rnd < 17 # Rymdmonster, 1 st [Tab. 20]
      monster = Monster.overnat_varelse(:scenario => self, :ar_rymdskurk => true, :skp_bonus => 40)
      self.add_npc monster
      return "En #{monster.typ} som heter #{monster.name}"
    elsif rnd < 24
      return "En arme av mutanter som #{self.mutationsperiod} kan " + self.mutation
    elsif rnd < 45
      return "Människor på #{self.historie_niva}-nivå"
    elsif rnd < 59
      monster = Monster.overnat_varelse(:scenario => self)
      monster.name = monster.name + ' (Exempel på befolkning)'
      self.add_npc monster
      return "Övernaturliga varelser (#{monster.typ})"
    elsif rnd < 72
      return "Människor från #{self.land} som kan '#{self.psi_egenskap}'-PSI"
    elsif rnd < 74000
      bem = self.random_ras(nil, false)
      psi = self.psi_egenskap
      bem.attributes << "#{psi}'-PSI kunniga"
      return "#{psi}'-PSI kunnig ras (#{bem.name})"
    elsif rnd < 74
      return "Robotar(mest #{Person::ROBOTAR.sample}robotar), på #{self.historie_niva}-nivå"
    elsif rnd < 83
      return "Förklädda androider som låtsas vara människor"
    elsif rnd < 91
      return "Magiker med #{self.magi}"
    elsif rnd < 94
      return 'En ' + HimlaKropp.random(self, nil)
    end
    return "Maskiner som lyckas ta sig till på #{self.historie_niva}-nivå"
  end
  
  #  Tabell 4 - Naturkatastrof
  #  Slå först på [Tab. 4.1] för typ av katastrof (den hänvisar oftast till
  #  en plats också). Sedan skall du slå på [Tab. 4.2] för orsaken till
  #  katastrofen.
  
  # Tabell 4.1 - Katastroftyp
  def katastroftyp
# -------    Tabell 27 är self.plats
    #  13-15 Fruktansvärd farsot drabbar... [Tab. 4.1.2]
    #  22-24 Den Babyloniska språkförbistringen drabbar [Tab. 4.1.2]
    #  25-27 Universum kolliderar med ett annat universum [Tab. 4.1.1]
    #  31-33 Reklamen uppfinns av falsk företagsledare, [Tab. 1.3] är egentligen [Tab. 11] på plats [Tab. 27]
    #  34-36 Massiv våg av otur drabbar... [Tab. 4.1.2]
    #  37-39 Porrtidningen uppfinns av [Tab. 11] i [Tab. 27]
    #  55-57 Ond Gud [Tab. 9.2] vill börja om från begynnelsen och [Tab. 4.1.1]
    #  58-60 Slå 1D3+1 ggr till på Tabellen, men platsen är densamma
    #  79-81 Regn av purpurstenar som orsakar sjukdom sänds ut av Rymdhärskare (GO?), [Tab. 27] och [Tab. 1.3]
    #  98-00 Vetenskapsman [Tab. 5.1, +25 SkP] tröttnar på livet och sabbar allt [Tab. 4.1.1]
    rnd = rand(32)
    # Ta 3% i varje steg
    return "Harmoniska svängningar i realiteten får universum att börja spricka och gå under. #{self.universums_slut}" if rnd < 3
    if rnd < 7 # Special för om något händer med en planet så vi bara plockar fram en planet i koden.
      rnd = rand(8)
      planet = self.random_planet
      if rnd < 3
        planet2 = self.random_planet(planet.name)
        planet2.attributes << 'Planeten är på väg att kollidera med ' + planet.name
        planet.attributes << 'Planeten är på väg att kollidera med ' + planet2.name
        return planet.name + ' är på väg att kollidera med ' + planet2.name + '.'
      end
      planet.attributes << 'Planeten är på väg att gå under i en katastrof.'
      return "Supernova i närheten av planeten #{planet.name}."                       if rnd < 4
      return "Planeten #{planet.name} börjar explodera."                              if rnd < 5
      return "Atmosfären försvinner från Planeten #{planet.name}."                    if rnd < 6
      return "Gifta utsläpp gör planeten #{planet.name} dödlig."                      if rnd < 7
      return "Kontinentalplattorna löper amok på planeten #{planet.name}."
    end
    return "Befolkningen i #{self.land} börjar hallucinera."                          if rnd < 8
    return "Alla på #{self.plats} börjar förvandlas till folk från #{self.land}."     if rnd < 9
    return "Entropidödan startar på #{self.plats}."                                   if rnd < 10
    return "Storm i rymdtidsväven öppnar hål mellan #{self.plats} och #{self.plats}." if rnd < 11
    regns = ['antimateriameteorer', 'mindre berg', 'meteorer av '+self.material_hard, 'pestspridande bakterier', self.djur(false), 'rött slem som fräter','blod',
             'svarta hål', self.material_floating , 'vatten och så mycket blixtar så att vattnet delas upp i syre och väte', 'odöda andar' ,'brinnande meteorer',
             'purpurstenar som orsakar sjukdom']
    return "Regn av #{regns.sample} drabbar #{self.land_el_planet}."                  if rnd < 14
    return "Verkligheten börjar suddas ut vid #{self.plats}."                         if rnd < 15
    return "Intelligensen börjar försvinna vid #{self.plats}."                        if rnd < 16
    return "Kraftiga jordbävningar drabbar #{self.plats}."                            if rnd < 17
    return "#{%w(Guld Silver Mat Bränsle Vatten).sample} börjar förvandlas till #{self.material_hard} vid #{self.plats}."  if rnd < 18
    return "Universum halveras, processen startar vid #{self.plats}."                 if rnd < 19
    return "Invasion av #{self.djur(false)} vid #{self.plats}."                       if rnd < 20
    return "Gravitationen börjar #{%w(öka öka minska fluktera).sample} i #{self.plats}." if rnd < 21
    return "Översvämning drabbar #{self.land_el_planet}."                             if rnd < 22
    if rnd < 23
      pest = ['pest', 'farsot','lungsjuka','böldpest','sjukdom som smittar vilt','blodsjukdom','våldsam klåda'].sample
      return pest.capitalize + " bryter ut vid #{self.plats}."
    end
    return "Det är matbrist i #{self.land_el_planet}."                                if rnd < 24
    return "En #{HimlaKropp.random(self)} sliter sig loss ur sin bana och seglar mot #{self.plats}." if rnd < 25
    return "Befolkningen i #{self.land_el_planet} börjar att få PSI-kraften '#{self.psi_egenskap}' som de inte kan kontrollera" if rnd < 26
    return "Många och vilda vulkanutbrott drabbar #{self.land_el_planet}."            if rnd < 27
    return "Jordskred och markförskjutningar drabbar #{self.plats}."                  if rnd < 28
    return "En jätteinsektinvasion drabbar #{self.plats} med #{self.insekt(false)}."  if rnd < 29
    return "Jättelika #{self.mamalian(false)} anfaller och invaderar #{self.plats}."  if rnd < 30
    return "Alla i #{self.land} drabbas av ett gasmoln som får dem att #{self.mutation}" if rnd < 31
    return "Alla i #{self.plats} drabbas av ett regn av #{regns.sample} som får dem att #{self.mutationsperiod} kunna #{self.mutation}"
  end
  
  # Tabell 4.1.1 - Universums slut
  #  Slå först på [Tab. 4.1.1.1] för domedagsmetod. Sedan på [Tab.
  #  4.1.1.2], för hur domedagen sprider sig. Sist slår du på [Tab. 27],
  #  för att se var Universums slut börjar visa sig.
  def universums_slut
    return self.domedagsmetod.capitalize + '. Det sprider sig ' + self.spridning + ', ut från ' + self.plats + '.' if rand(100) < 50
    return self.domedagsmetod.capitalize + '. Det sprider sig ' + self.spridning + ' och startar från ' + self.plats + '.'
  end
  
  # Tabell 4.1.1.1 - Domedagssätt
  def domedagsmetod
    rnd = rand(101)
    if rnd < 6
      bem = self.ny_ras(false)
      return "Flerdimensionella #{bem.name.capitalize} fyller upp allt tomrum"
    end
    return "Allt äts upp av #{self.djur(false)} från ett annat universum" if rnd < 10
    return "Flerdimensionella #{self.djur(false)} fyller upp allt tomrum" if rnd < 13
    texts = ['Tiden börjar gå baklänges','Gib Gnab (Big Bang baklänges)','Allt blir damm','Realiteten börjar svikta och allt försvinner','Allt fördubblas gång på gång','Allt exploderar',
             'Varje planet blir en rymdtidsbubbla i sig','Träd stora som universum börjar växa över allt','Elektromagnetismen försvagas och molekyler löses upp','Värmen försvinner',
             'Det osannolika blir sannolikt och det sannolika blir osannolikt. Murphys lag kvadreras','Mörkret sprider sig','Ett annat universum kolliderar med vårt',
             'Tiden tar slut','Universum halveras bit för bit']
    return texts.sample
  end
  
  # Tabell 4.1.1.2 - Spridning
  # Texten 'Det sprids  ...'
  def spridning
    #  81-90 Med en ovetande oskyldig resenär [Tab. 5.2]
    #  96-00 Medvetet av nyfiken forskare [Tab. 5.1]
    if rand(100) < 5
      fanatism = %w(frihetsälskande stirrande dum extrem känslokall mördande rik fattig galen psykopatisk ologisk skrikande lönnmördande fradgetuggande barnhatande barnälskande viskande)
      fanatiker ||= self.ny_person(:attributes => ["#{fanatism.sample} fanatiker"]) if rand(100) < 60
      fanatiker ||= self.ny_person(:attributes => ["#{fanatism.sample} och #{fanatism.sample} fanatiker"])
      if fanatiker.alignment == 'ond'
        fanatiker.ond_religion = 'Dyrkar fanatiskt ' + self.ond_gud
        fanatiker.skp += 10
      end
      return 'Med religiösa fanatikern ' + fanatiker.name
    end
    if rand(100) < 5
      hist = self.historie_niva
      traveller = self.ny_person(:attributes => ["Tidsresenär ifrån #{hist.capitalize}-period"])
      return "med tidsresenären #{traveller.name} (från #{hist.capitalize}-period)"
    end
    texts = ['nästan omärkligt långsamt från ursprungsplatsen','i plötsliga hopp utåt från ursprungsplatsen',"snabbt på #{(rand(7)+rand(8)+1)} dagar",
             'med plötsligt uppdykande här och där', 'med kraftigt accelererande spridande från ursprungsplatsen', "med #{self.djur(false)}", 
             'som en modefluga','bakåt genom tiden','med poesi',"med #{self.musik}","med #{self.musik} spelad av magiker med #{self.magityp(true)}"]
    return texts.sample
  end
  
  
  # Tabell 9.2 - Ond Gud
  def ond_gud
    gudar = ['Shub-Niggurath med de tusen unga (+800 SkP)','Shudde M’ell, jordbävningarnas härskare (+200 SkP)','Tsathogghua, en mörk klet (+800 SkP)']
    gudar.concat ['Yog-Sotthoth, alltets väktare (+80000 SkP)','Azathoth, den galne demonsultanen (+80000 SkP)','Cthulhu, den store (+1100 SkP)']
    gudar.concat ['Cthugha, eldvarelsen (+800 SkP)','Hastur, den onämnbare, häxornas härskare (+1100 SkP)','Ithaqua, Vindmakaren (+800 SkP)']
    gudar.concat ['Thoth, de dödas mörke ledsagare (+800 SkP)','Anubis, underjordens härskare (+700 SkP)','Ra, den brännande solens gud - styrka, kraft (+1000 SkP)']
    gudar.concat ['Seth, ondskans härskare, öknen, fienden (+1100 SkP)','Aapep, alla civilisationers fiende, jätteormen (+1000 SkP)']
    gudar.concat ['Amam, hjärtslukare, dödar alla skyldiga (+400 SkP)','Sekhmet, krigs och öken-gudinnan, lejon (+400 SkP)','Zeus, åskguden (+2000 SkP)']
    gudar.concat ['Kronos, tiden som äter allt, entropin (+3000 SkP)','Saturnus, ond jordgud som äter barn (+3000 SkP)','Poseidon, stormarnas härskare (+600 SkP)']
    gudar.concat ['Hades, underjordens gud (+1100 SkP)','Mars, krigsguden (+800 SkP)','Hecate, dödsgudinnan (+800 SkP)']
    gudar.concat ['Typhon, upprorsmakaren, förintaren, krossaren (+900 SkP)','Loke, ränksmidaren, eldgud (+1100 SkP)','Oden, dödshärskaren (+2000 SkP)']
    gudar.concat ['Surtur, eldjättarnas onde härskare, gigantisk (+400 SkP)','Hel, underjordens gudinna (+800 SkP)','Utgårda-Loke, listigast av jättar (+1100 SkP)']
    gudar.concat ['Fenris Ulven, stor varg, ragnaröksgud (+1100 SkP)','Midgårdsormen, jättestor orm, käkar sig själv (+300 SkP)','Trym, stor, dum, ond jätte (+100 SkP)']
    gudar.concat ['Yama, de dödas härskare, använder Zombier (+1000 SkP)','Kali, dödsgudinnan (+1100 SkP)','Shiva, alltets förstörare (+2000 SkP)']
    gudar.concat ['Rudra, stormgud, dödsgud, sjukdomars gud (+400 SkP)','Garuda, åskfågeln (+80 SkP)','Hari-hara, den ultimata goda förstörelsen (+3000 SkP)']
    gudar.concat ['Ratri, natten & tjuvarna & rånarnas gudinna (+300 SkP)','Ahriman, det mörkas princip (+2000 SkP)','Mictlantecuhtli, dödsgud (+800 SkP)']
    gudar.concat ['Ah Puch, Mayansk dödsgud (+800 SkP)','Ixchel, regngudinna (+300 SkP)','Huhueteotl, eldgud (+400 SkP)']
    gudar.concat ['Old Man Coyote, lurendrejare, trixare (+1100 SkP)','Malsum, Glooskaps bror, jätteond (+4000 SkP)','Nimrod, äregirighetens personifikation, himmelns utmanare (+80 SkP)']
    gudar.concat ['Demiurgen, värdsaltets onde urkraft, skaparen, jätteond (+80000 SkP)','Djävulen (+3000 SkP)','Antikrist, djävulens son på jorden (+1100 SkP)']
    gudar.concat ['Baal, gammal ond gud som bränner barn i sin järnmage (+1100 SkP)','Beelsebub, flugornas herre (+800 SkP)']
    gudar.concat ['Lucifer, morgonstjärnan, himmelns rebell (+4000 SkP)','Satan, han med svans och horn (+1100 SkP)','Morfeus, drömhärskaren (+800 SkP)']
    gudar.concat ['Baron Samedi, voodoo, korsvägarnas herre, ond magigud, har hög hatt (+800 SkP)','Sedna, grönländsk dödsgudinna (+1100 SkP)']
    gudar.concat ['Skuggan av en häst, intets gudomlighet (+800 SkP)','Erlik, sibirisk fallen ängel (+300 SkP)','Tiamat, babylonisk kaosdrake (+1400 SkP)']
    gudar.concat ['Arawn, keltisk dödsgud (+1100 SkP)','Louhi, gammal häxa, den största i världen (+300 SkP)','Kiputytto, sjukdoms och pestmoder (+1100 SkP)']
    gudar.concat ['Loviatar, vacker smärtgivande gudinna (+800 SkP)','Tuonetar, underjordens gudinna, fruktat ful (+1200 SkP)']
    gudar.concat ['Tuoni, Tuonetars make, inte vacker heller (+800 SkP)']
    return gudar.sample if rand(100) < 95
    atribute = ['Den Dolda Mästaren','Mörkrets härskare','Galenskapens försvarare','Demonhärksaren','Smärtans bemästrare','Pestspridaren','Dödsriddaren',
                'Ondskans vänstra hand','Demonernas portal','Den mörka maktens ledsagare','Krigets banerförare','Smärtbevararen'].sample
    ond = rand(100) < 90
    attributes = ['Dyrkas av några som ' + atribute]
    attributes << 'Inte så ond som många antar' unless ond
    skp = ond ? rand(201) : -rand(11)
    person = self.ny_person(:attributes => attributes, :skp_bonus => skp, :is_ond => ond)
    return person.name + ', ' + atribute + ' (+100 SkP)'
  end
  
  # Tabell 10.2 - Känslor
  def kanslor
    return FEELINGS.sample
  end
  
  # Tabell 13.3.1 - Hårt material
  def material_hard
    return "kristalliserade #{ray}" if rand(100) < 3
    return "frusen vätska - #{material_floating}" if rand(100) < 3
    if rand(100) < 7
      mtrl = ['antimateria','Papper','Mörk materia','kondenserad eter','flogiston','transuran','vishets-sten','antigravitationskristall','mineskristaller','mana-kristaller'].sample
    elsif rand(100) < 5
      mtrl = ['nysilver','stål','amalgam','krom','mässing','sterlingsilver','bärnsten'].sample
    elsif rand(100) < 5
      mtrl = ['organiska utsöndring','muskler','tvål','läder','velour','bakelit','gjutjärn','ben'].sample 
    else
      mtrs = ['sten','marmor','gråsten','sandsten','glas','trä','plåt','plast','bly','Platina','koppar','keramiskt material','kisel','zink','rubin','grafit','zaphir',
              'tungsten','diamant','kristall','arsenik','guld','silver','brons','forsfor','pigment','uran','plutonium','pyrit','alluminium','kol',
              'nylon','tellurium','bly','elektrum','guld','osmium','iridium','flinta']
    end
    mtrl ||= mtrs.sample
    
    prefixes = %w{komprimerad svampartad frätande kylande röd röd grön glänsande svart purpurfärgad glödande radioaktiv självlysande oljigt kristalint levande spröd}
    prefix = prefixes.sample
    return (prefix + ' ' + mtrl) if rand(100) < 6
    if rand(100) < 6
      prefix2 = prefix
      while prefix2 == prefix do
        prefix2 = prefixes.sample
      end
      return prefix + ' och ' + prefix2 + ' ' + mtrl
    end
    return mtrl
  end
  
  # Tabell 13.3.2 - Flytande material
  def material_floating
    if rand(100)<4
      mtrl = "vätska med egenskap som #{ray}"
    elsif rand(100)<4
      mtrl = "'#{self.magityp(true)}'-drog"
    else
      mtrl = MTRLS_FLOATING.sample
    end
    mtrl = ['kall','kokande','frätande','illaluktande','giftig','självlysande','oljig','attackerande'].sample + ' ' + mtrl if rand(100) < 13
    return mtrl
  end
  
  # Tabell 14 - Magiker
  def magityp(simple_type = false)
      #  89-92 Naturkatastrofsmagiker [Tab. 4.1]
      #  97-00 Bionisk magiker [Tab. 15]
    if rand(100) < 4
      ras = self.random_ras(false)
      return "'#{ras.name}''-magi"
    end
    if !simple_type && rand(100) < 4
      person = self.ny_person({:ar_magiker => true})
      return "Magiskt med sin andebesätta #{person.name} som i sin tur kan #{person.magi}-magi"
    end
    return "#{Monster.overnat_varelse({:scenario => self, :stubb => true}).typ}-tämjar-magi"    if rand(100) < 4
    return "'Skjuta #{self.ray}'-magi"                         if rand(100) < 4
    return "Ond religiös magi till #{self.ond_gud}"            if rand(100) < 4
    return "Känslosam (#{self.kanslor}) religiös magi"         if rand(100) < 4
    return "'PSI #{self.psi_egenskap}'-magi"                   if rand(100) < 4
    return "Magi som använder #{self.material_hard}"           if rand(100) < 4
    return "'Frammana #{self.djur(false)}'-magi"               if rand(100) < 4
    return "Generell mutageni-magi"                            if rand(100) < 1
    typer = ['Nekromantik','Illusioni','Dimensionsförvrängning','Mutageni (muterar) [Tab. 21]','Blixtskjutning','Mörkermagi','Brinnande misiler-magi','Kaosmagi','Andedjur-magi',
             "Magi som kräver #{self.material_floating}","Formändrarmagi",'Elementarmagi','Luftmagi','Vattenmagi','Växtmagi','Spegelmagi','Vädermagi','Runmagi','Modergudinne-magi',
             'Eldmagi','Portalmagi','Naturmagi','Växtmagi','Förbannelser','Kabbalism','Helning','New Age-magi','God religiös magi','Kristallmagi','Demonologi']
    typer.concat ['Naturkatastrofsmagi [Tab. 4.1]',"#{self.musik}-magi",'Bionisk magi [Tab. 15]']
    return typer.sample
  end
  
  # Tabell 16
  def djur(singular)
    singulars = [self.annat_djur(singular),self.fisk(singular),self.mamalian(singular),self.insekt(singular),self.urtidsdjur(singular)]
    plurals   = [self.annat_djur(singular),self.fisk(singular),self.mamalian(singular),self.insekt(singular),self.urtidsdjur(singular)]
    prefix_s = %w{stor liten jättestor jätteliten gigantisk blixtsnabb svart vit aggresiv lätttränad giftig flytande lång högljudd slemmig grön 
                  blå självlysande superintelligent intelligen talande kiselbaserad jungfrufödd frätande konstgjord}
    prefix_p = %w{stora små jättestora jättesmå gigantiska blixtsnabba svarta vita aggresiva lättränade giftiga flytande långa högljudda slemmiga gröna 
                  blåa självlysande superintelligenta intelligenta talande kiselbaserade jungfrufödda frätande konstgjorda}
    namn = singular ? singulars.sample : plurals.sample
    if rand(100) < 25
      namn = (singular ? prefix_s.sample : prefix_p.sample) + ' ' + namn
      namn = (singular ? prefix_s.sample : prefix_p.sample) + ' och ' + (singular ? prefix_s.sample : prefix_p.sample) + ' ' +namn if rand(100) < 25
      namn = 'mycket ' + namn if rand(100) < 25
    end
    return namn
  end
  
  def annat_djur(singular)
    singulars = ['talande växt','orm','fågel','groda','nyttig mikrob','padda','sköldpadda','struts','hök','kräfta']
    plurals   = ['talande växter','ormar','fåglar','grodor','nyttiga mikrober','paddor','sköldpaddor','strutsar','hökar','kräftor']
    return singular ? singulars.sample : plurals.sample
  end
  
  # Tabell 16.1
  def mamalian(singular)
    singulars = %w{gris elefant häst rovdjur gnagare val apa apmänniska grottmänniska hund katt ekorre flygekorre fladdermus hjort älg mus
                   ko björn gris känguru pungdjur koala lämmel flodhäst råtta näbbdjur räv delfin lämmel varg hyena tiger} 
    plurals = %w{grisar elefanter hästar rovdjur gnagare valar apor apmänniskor grottmänniskor hundar katter ekorrar flygekorrar fladdermös hjortdjur älgar möss
                 kor björnar grisar kängurur pungdjur koalor lämlar flodhästar råttor näbbdjur rävar delfiner lämlar vargar hyenor tigrar}
    return singular ? singulars.sample : plurals.sample
  end

  # Tabell 16.2
  def urtidsdjur(singular)
    singulars = ['brontosaurus','stegosaurus','underjordisk ödla','jätteödla','tyrannosaurus rex','flygödla','trilobit','jättesengångare','mammut','sabeltandad tiger',
                 'godzilla', "#{self.livsaskadning(true)} drake",'korallrev','sjöodjur','pytonorm','flygödla','jätteapa','myskoxe','urslem','svampman','jättekobra']
    plurals = ['brontosaurusar','stegosaurusar','underjordiska ödlor','jätteödlor','tyrannosaurus rexar','flygödlor','trilobiter','jättesengångare','mammutar','sabeltandade tigrar',
               'godzillor',"#{self.livsaskadning(false)} drakar",'korallrev','sjöodjur','pytonormar','flygödlor','jätteapor','myskoxar','urslem','svampmän','jättekobror']
    return singular ? singulars.sample : plurals.sample
  end
  
   # Tabell 16.3
  def insekt(singular)
    singulars = ['myrvarelse','bi','geting','skalbagge','larvliknande-kryp','gråsugga','kackerlacka','fjäril','gräshoppa','bönsyrsa','silverfisk','loppa','fluga','spindel','skorpion',
                 'hummaniod insekt','fästing','termit','araknid','mask','myr-humaniod','silverfisk','gråsugga','dyngbagge','dagslända','tvestjärt',
                 'mal','bokmal','lus','tusenfoting']
    plurals = ['myrvarelser','bin','getingar','skalbaggar','larvliknande-kryp','gråsuggor','kackerlackor','fjärilar','gräshoppor','bönsyrsor','silverfiskar','loppor','flugor','spindlar',
               'skorpioner','hummanioda insekter','fästingar','termiter','araknider','maskar','myr-humanoider','silverfiskar','gråsuggor','dyngbaggar','dagsländor','tvestjärtar',
               'malar','bokmalar','löss','tusenfotingar']
    return singular ? singulars.sample : plurals.sample
  end
  
  def fisk(singular)
    singulars = ['tonfisk','valhaj','haj','ål','gädda','muräna','piraya','guldfisk','lax','flygfisk','slamkrypare','åttaarmad bläckfisk','tioarmad bläckfisk',
                'tonfisk','svärdsfisk','nejonöga','elektrisk ål','marulk','sjöstjärna','manta']
    plurals   = ['tonfiskar','valhajjar','hajjar','ålar','gäddor','muränor','pirayor','guldfiskar','laxar','flygfiskar','slamkrypare','åttaarmade bläckfiskar','tioarmade bläckfiskar',
                'tonfiskar','svärdfiskar','nejonögon','elektriska ålar','marulkar','sjöstjärnor','mantor']
    return singular ? singulars.sample : plurals.sample
  end
  
  
  # Tabell 18 - Musiker
  def musik
    #  Krigsmusiker [Tab. 3]
    #  69-74 Musikkrigare [Tab. 19]
    return "musik som spelas under tävlingar i #{self.idrott}" if rand(100) < 4
    if rand(100) < 5
      varelse = Monster.overnat_varelse({:scenario => self, :stubb => true})
      return '"'+varelse.typ +  '"-musik'
    end
    return 'subtilt medryckande ' + self.psi_egenskap + '-PSI-musik' if rand(100) < 5
    if rand(100) < 5
      psis = Array.new
      typer =%w(vibrafony symfoni jamsession opera operette jamsession)
      (1+rand(3)).times { psis << self.psi_egenskap }
      return psis.join('- och ') + '-psionisk ' + typer.sample
    end
    if rand(100) < 4
      askadning = self.livsaskadning
      return askadning.capitalize + ' religiös musik till ' + self.ond_gud if askadning.include? 'ond'
      return askadning.capitalize + ' religiös musik'
    end
    return "folkmusik från #{self.land}"   if rand(100) < 5
    return "#{self.random_ras.name}-#{%w(folkmusik musik musik populärmusik begravningsmusik opera).sample}" if rand(100) < 6
    musiker = %w{dans lutaspel megastar jättesyntetisk rymdorgel orgel kyrkorgel orkester protest naturhärmande rymdtrubadur rymdopera diggerido panflöjts
                 rock jazz operette opera abstrakt meta fiol cello trum sövande}
#    return "#{musiker.sample}-musik komponerad av magiker med #{self.magityp(true)}" if rand(100) < 4
    return musiker.sample + '-musik'
  end  
  
  # Tabell 20.3 - Estetik
  def estetik
    rnd = rand 100
    #  01-12 Äckliga
    #  13-27 Normala
    #  28-39 Vackra
    #  40-51 Överjordiskt sköna
    #  52-63 Osynliga
    #  64-75 Skräckinjagande
    #  76-87 Gulliga
    #  88-00 Maskinella
    return 'Riktigt Fula'                 if rnd < 6
    return 'Äckliga'                      if rnd < 12
    return 'Normala'                      if rnd < 29
    return 'Anses vara vackra'            if rnd < 40
    return "Är #{%w(himmelskt övermänskligt otroligt sinligt smakfullt överjordiskt).sample} sköna" if rnd < 53
    return "Är mästare i kamoflage"       if rnd < 55
    return 'Är osynliga i vanligt ljus'   if rnd < 57
    return 'Syns inte i skuggor'          if rnd < 59
    return 'Svåra att se'                 if rnd < 63
    return Bem::HORRORS.sample.capitalize if rnd < 75
    return 'Gulliga'                      if rnd < 86
    return 'Är Söta'                      if rnd < 89
    return 'Maskinella'                   if rnd < 95
    return "Maskinlika"
  end
  
  # Tabell 20.8 - Livsåskådning
  def livsaskadning(singular = true, ond_ok = true)
    rnd = rand 100
    return singular ? 'ond' : 'onda' if rnd < 45 && ond_ok
    return singular ? 'god' : 'goda' if (rnd < 70 && ond_ok) || rnd < 10
    return singular ? "känslosam (#{self.kanslor})" : "känslosamma (#{self.kanslor})" if (rnd < 85 && ond_ok) || rnd < 60
    return singular ? 'neutral' : 'neutrala'  if (rnd < 96 && ond_ok) || rnd < 85
    return singular ? 'irrelevant' : 'irrelevanta'
  end
  
  # Tabell 21 - Mutation
  def mutation
    return self.mutera + ' ' + mutationstid
  end
    
  def mutera
    # 83-84 Omforma... till verktyg [Tab. 21.1] + [Tab. 17.2]
    # 87-88 Omforma kroppen till annan sak [Tab. 17]
    rnd = rand 113
    return 'Mutera storleken'                            if rnd < 6
    return 'Mutera färgen'                               if rnd < 14
    return "Mutera längden på #{self.kroppsdel}"         if rnd < 35
    return "Mutera fler eller färre #{self.kroppsdel}"   if rnd < 48
    return "Mutera lukt"                                 if rnd < 50
    return "Mutera synen"                                if rnd < 53
    return "Mutera läten"                                if rnd < 55
    return "Mutera utsöndringar"                         if rnd < 57
    return "Mutera fram utsöndringar av #{self.material_floating}"    if rnd < 58
    return "Transmutera #{self.kroppsdel} till #{self.material_hard}" if rnd < 68
    return "Mutera hårdheten"                            if rnd < 71
    return "Mutera huden till #{self.material_hard}"     if rnd < 73
    return "Mutera fram egenskapen #{self.psi_egenskap}" if rnd < 75
    return "Mutera fram egenskaperna #{self.psi_egenskap} och #{self.psi_egenskap}" if rnd < 77
    return "Mutera till sig #{self.magityp(true)}"       if rnd < 82
    return "Omforma #{self.kroppsdel} till vapen"        if rnd < 86
    return "Omforma #{self.kroppsdel} till verktyg [Tab. 17.2]" if rnd < 89
    return "Omforma hela kroppen till vad som helst"     if rnd < 91
    return "Omforma kroppen till annan sak [Tab.17]"     if rnd < 94
    return "Imitera annan människa"                      if rnd < 99
    return "Omforma hela kroppen och imitera en #{self.djur(true)}" if rnd < 103
    return "Omforma rösten och imitera en #{self.djur(true)}"       if rnd < 105
    return "Omforma hela kroppen och imitera en #{self.random_ras(true).name}" if rnd < 108
    monster = Monster.overnat_varelse(:scenario => self) 
    return "Omforma hela kroppen och imitera en #{monster.typ}"
  end
  
  # Tabell 21.1 - Kroppsdelar
  def kroppsdel
    rnd = rand 110
    return "armar"               if rnd < 7
    return "framdrivningsorgan"  if rnd < 14
    return "hår, fjäll el dyl"   if rnd < 20
    return "händer"              if rnd < 26
    return "centrala nervsystem" if rnd < 32
    return "tentakler"           if rnd < 38
    return "svans"               if rnd < 44
    return "huvud"               if rnd < 50
    return "matsmältningsorgan"  if rnd < 56
    return "andningsorgan"       if rnd < 62
    return "ögon"                if rnd < 68
    return "sinnesorgan"         if rnd < 74
    return "tänder"              if rnd < 80
    return "klor eller naglar"   if rnd < 86
    return "skinn eller hud"     if rnd < 93
    return "benstrukturer"       if rnd < 100
    return "hjärta"              if rnd < 104
    return "antenner"            if rnd < 106
    return "huden"
  end
  
  # Tabell 21.2 - Mutanthållbarhet
  def mutationstid
    rnd = rand 100
    return "lika länge som det tog att mutera"       if rnd < 5
    return "dubbelt så länge som det tog att mutera" if rnd < 10
    return "som slutar efter en användning"          if rnd < 15
    return "i 1/2 min"                               if rnd < 20
    return "i 5 min"                                 if rnd < 25
    return "i en halvtimma"                          if rnd < 29
    return "i en timma"                              if rnd < 31
    return "i en dag"                                if rnd < 35
    return "i en vecka"                              if rnd < 40
    return "i en månad"                              if rnd < 45
    return "i ett halvår"                            if rnd < 50
    return "som har permanent verkan"                if rnd < 75
    return "och det verkar tills mutanten vill upphäva det"
  end
  
  def mutationsperiod
    rnd = rand 64
    return "en gång om dagen"                        if rnd < 4
    return "två gånger om dagen"                     if rnd < 8
    return "en gång i timman"                        if rnd < 12
    return "en gång i veckan"                        if rnd < 16
    return "en gång i månaden"                       if rnd < 20
    return "en gång om året"                         if rnd < 24
    return "vid fara"                                if rnd < 28
    return "när skadad"                              if rnd < 28
    return "när det är fullmåne"                     if rnd < 32
    return "när månen inte syns"                     if rnd < 34
    return "med en timmas vila efteråt"              if rnd < 38
    return "med en minuts vila efteråt"              if rnd < 42
    return "efter att ha ätit"                       if rnd < 46
    return "efter att ha sovit"                      if rnd < 50
    return "efter en längre vila"                    if rnd < 54
    return "i närheten av " + FEELINGS.sample        if rnd < 58
    return "vid ljudet av #{self.musik}"             if rnd < 60
    return "vid tillbedjan av " + self.ond_gud
  end
  
  # Tabell 22 - Idrotter
  def idrott
    # 24-26 Raketkapplöpning [Tab 13]
    rnd = rand 120
    sp   = self.cricket                             if rnd < 4
    sp ||= self.fotboll                             if rnd < 10                           
    sp ||= "kapplöpning med #{self.djur(false)}"    if rnd < 15
    sp ||= "skicklighet i #{self.psi_egenskap}-psi" if rnd < 18
    sp ||= self.djur(true)+'-dressyr'               if rnd < 22
    sp ||= self.skidsport                           if rnd < 27
    sp ||= "surfing på #{self.ray}"                 if rnd < 30
    sp ||= "dueller i #{self.magityp(true)}"        if rnd < 33
    sp ||= ['snottboll','ishockey','landhockey','brottning','vattenpolo','retorik','stöld','kassaskåpsöppning','skytte','megabiljard','planettennis/ping-pong','pilkastning',
          'utrotning','kreativ konst','fäktning','simning','balansering','basket','planetbasket','pingis','orientering','konstsim','gymnastik','matematik','svampplockning',
          'shopping','bågskytte','cykling','tennis','volleyboll','beachvolleyboll','basket','golf','badminton','surfing','meditation','tyngdlyftning','kurragömma','boxning',
          'gång','långlopp','styrkelöpning','stadsplanering','kanot','judo','karate','konstsim','femkamp','rodd','höjdhopping','kulstötning','dragkamp','rodel','spjutkastning',
          'löpning'].sample  
    sp = 'teräng'+sp  if rand(100) < 5
    if rand(100) < 10
      sp = 'proffs'+sp
    elsif rand(100) < 5
      sp = 'amatör'+sp
    end
    sp = 'mega'+sp    if rand(100) < 5
    sp = 'extrem '+sp if rand(100) < 5
    sp = 'improviserad '+sp if rand(100) < 3
    sp = 'mixed '+sp if rand(100) < 5
    sp = sp + ' från ' + self.land_el_planet if rand(100) < 5
    return sp
  end
  
  # Tabell 22.1 - Cricket typer
  def cricket
    rnd = rand 110
    return 'brännboll' if rnd < 17
    return 'cricket'   if rnd < 24
    return 'baseboll'  if rnd < 41
    return 'brockian ultra-cricket'  if rnd < 67
    return 'softball'  if rnd < 83
    return 'pärk'      if rnd < 100
    return 'dodgeball'
  end
  
  # Tabell 22.2 - Fotboll
  def fotboll
    rnd = rand 110
    #  71-75 Raketboll [Tab. 13]
    return "fotboll som det spelades på #{self.historie_niva} nivån" if rnd < 5
    return self.djur(false)+'-polo'                    if rnd < 10
    return self.random_ras(nil, false).name+'-fotboll' if rnd < 15
    return self.magityp(true)+'-fotboll'               if rnd < 20
    return self.psi_egenskap+'-psi förstärkt fotboll'  if rnd < 25
    return self.cricket                                if rnd < 30
    fb = ['amerikansk fotboll','spaceball','australiensisk fotboll','rugby','polo','korpboll','planetboll','gatufotboll','cykelboll','kraftfotboll','medicinboll','byfotboll',
            'anarkistboll','pärl','fotboll','fotboll','spökboll','hinderfotboll','femmannafotboll','inomhusfotboll','strandfotboll','mongolisk fotboll'].sample
    return 'cykel'+fb if rand(100) < 5
    return fb
  end
  
  # Tabell 22.3 - Skidsporter
  def skidsport
    #  66-72 Raketskidor [Tab. 22.3] och [Tab. 13.1]
    rnd = rand 135
    return "slalom"                     if rnd < 6
    return "längdskidor"                if rnd < 12
    return "backhoppning"               if rnd < 18
    return "hastighetstävlan på skidor" if rnd < 24
    return "störtlopp"                  if rnd < 31
    return "#{self.fotboll} på skidor"  if rnd < 35
    return "skid-#{self.cricket}"       if rnd < 41
    return "skidorientering"            if rnd < 47
    return "skidskytte"                 if rnd < 53
    return "skidtolkning bakom " + self.djur(false) if rnd < 59
    if rnd < 65
      txt = self.skidsport
      while txt.include?('vatten') do
        txt = self.skidsport
      end
      return 'vatten'+txt
    end
    return "raketskidor [Tab. 22.3] och [Tab. 13.1]" if rnd < 72 
    return 'skidbrottning'              if rnd < 78
    return 'puckelpiståkning'           if rnd < 83
    return 'trickhoppning med skidor'   if rnd < 88
    return 'snowboardslalom'            if rnd < 94
    return 'snödekorationer'            if rnd < 100
    return 'skidcross'                  if rnd < 105
    return 'terängskidåkning'           if rnd < 110
    return 'snöänglar'                  if rnd < 115
    return 'skiddykning'                if rnd < 120
    if rnd < 125
      txt = self.skidsport
      while txt.include?('parallell') do
        txt = self.skidsport
      end
      return 'parallell'+txt
    end
    return 'skidkamp'                   if rnd < 130
    if rnd < 135
      txt = self.skidsport
      while txt.include?('stafett') do
        txt = self.skidsport
      end
      return 'stafett'+txt
    end
  end
  
  # Tabell 25 finns i Person.rb - Ond Egenskap
  
   # Tabell 26 - PSI-egenskap
  def psi_egenskap
    return PSI_EGENSKAPER.sample
  end
  
  # Tabell 27 - Plats
  def plats
    #  09-10 Något annat [Tab. 6.1]
    #  29-30 En militärmakts högkvarter [Tab. 3.2.1 (befolkning) - 3.2.3] och [Tab. 23]
    #  39-40 En rymdraket [Tab. 13]
    #  45-46 Krigsmaterielförråd [Tab. 3.2.3] och [Tab. 27.4] #{self.land_el_planet}

    #  56-60 Planet med annat civilisationsstadium [Tab. 27.2] plus [Tab. 23.1], [Tab. 23.2]
    #  65-66 Ett forskningslabb [Tab. 5.1] och [Tab. 27.4]
    #  67-68 Ett gigantiskt forskningscentrum [Tab. 5.1] och [Tab. 27.4]

    #  75-76 Boplats för övernaturlig varelse [Tab. 9.1] och [Tab. 27.4]
    #  77-78 Hemsökt plats [Tab. 9.1] och [Tab. 27] igen
    #  83-84 Ett palats för en härskare [Tab. 1.3], [Tab. 20.8], [Tab. 27.4]
    #  87-88 En institution för PSI-studier [Tab. 26] och [Tab. 27.4]
    #  89-90 Skurks högkvarter [Tab. 11, hänvisar vidare till högkvarteret]
    #  91-92 Någons hem [Tab. 5.2] och [Tab. 27.4]
    #  93-94 Fabrik [Tab. 17] och [Tab. 27.4]
    rnd = rand(680)
    if rnd < 160 # Platsen är en planet av något slag
#      rnd2 = rand(100)
      planet = self.random_planet
      if rnd < 20
        planet.attributes << 'Ligger nära vårt solsystem'
        return "planeten #{planet.name} i näheten av vårt solsystem" 
      end
      return "närmaste planeten #{self.random_planet.name}" if rnd < 40
      if rnd < 60
        planet.attributes << 'Dödsplanet'
        return "dödsplaneten #{planet.name}" 
      end
      if rnd < 80
        bem = self.ny_ras(true)
        planet.attributes << 'Hemplaneten åt ' + bem.name
        planet.befolkningar << bem.name if rand(100) < 70
        bem.planet = planet
        return "#{bem.name}'s hemplanet #{planet.name}"
      end
      if rnd < 95
        planet.attributes << 'Urtidsplanet'
        return "urtidsplaneten #{planet.name}"
      end
      if rnd < 100
        planet.attributes << 'Har en bebodd mittenkärna'
        return "mitten av planeten #{planet.name}"
      end
      if rnd < 120
        what = %w{rymdhamn rymdstation}.sample
        planet.attributes << 'Har viktig ' + what
        return "#{what} på planeten #{planet.name}"
      end
      return "en satelit runt #{self.random_planet.name}" if rnd < 130
      if rnd < 140
        org = self.land
        kolonityp = Planet::KOLONITYPER.sample
        planet.attributes << "Har en #{kolonityp} från #{org}"
        return "en #{kolonityp} från #{org} på planeten #{planet.name}"
      end
      if rnd < 150
        org = self.mystiskt_land
        planet.attributes << "Befolkningen koloniserade ursprungligen #{org}"
        planet.befolkningar << planet.get_befolkning if planet.befolkningar.length < 2
        return "hemmen på planeten #{planet.name} åt dom som ursprungligen koloniserade #{org}"
      end
      org = self.mystiskt_land
      kolonityp = Planet::KOLONITYPER.sample
      planet.attributes << "Har en gammal #{kolonityp} från #{org}"
      return "en gammal #{kolonityp} från #{org} på planeten #{planet.name}"
    end
    if rnd < 170
      livsa = self.livsaskadning
      return "religiösa helgedomar åt #{self.ond_gud} i #{self.land_el_planet}" if livsa.include?('ond')
      return "religiösa helgedomar i #{self.land_el_planet}"
    end
    return HimlaKropp.random(self)                     if rnd < 180
    return self.land                                   if rnd < 190
    return "#{self.land}s militära ledningscentral"    if rnd < 200
    return ['hela Jorden','Mars','Venus','Merkurius','Ceres','Jupiter','Uranus','Neptunus','Pluto','Civilisationens centrum','Vulkan','Planet X'].sample if rnd < 220
    return "liten stad i #{self.land}"                 if rnd < 230
    return "stäpp i #{self.land}"                      if rnd < 240
    return "liten amerikansk stad i #{self.amerika}"   if rnd < 250
    return "en dold grotta i #{self.amerika}"          if rnd < 260
    return "huvudstaden i #{self.land}"                if rnd < 270
    if rnd < 280
      plats = self.land_el_planet
      return "ett djursjukhus för #{self.djur(false)} i #{plats}" if rand(100) < 50
      person = self.random_person(plats)
      return "ett djursjukhus för #{self.djur(false)} i #{plats} som ägs av #{person.name}"
    end
    return "ett slott i #{self.mystiskt_land}"         if rnd < 290
    return "en gruva för #{self.ray}-kristaller i #{self.land_el_planet}" if rnd < 300
    return "huvudstaden i #{self.mystiskt_land}"       if rnd < 310
    return "mystiska #{self.ray} som utstrålar från #{self.land_el_planet}" if rnd < 320
    return "den mystiska platsen #{self.mytisk_plats}" if rnd < 330
    return self.mytisk_plats                           if rnd < 340
    return RandomName.stad                             if rnd < 350
    return self.land                                   if rnd < 360
    
    somewhere   = self.mytisk_plats                    if rand(100)<2
    somewhere ||= RandomName.stad                      if rand(100)<15
    somewhere ||= self.land_el_planet # Anropa bara den här metoden en gång för den kan skapa en ny planet i ett anrop
    
    xn = ['','','','','','','','','','stor ','liten ','gigantisk ','jätteliten ','bortglömd ','hemlig ','förbjuden ','populär ','helig ','enslig '].sample
    xt = ['','','','','','','','','','stort ','litet ','gigantiskt ','jättelitet ','bortglömt ','hemligt','förbjudet ','populärt ','heligt ','ensligt '].sample
    
    return "en #{xn}skola för #{self.magityp(true)} i #{somewhere}" if rnd < 370
    return "en #{xn}#{%w(arena idrotssarena idrottsplats inomhusarena).sample} för #{self.idrott} i #{self.land_el_planet}" if rnd < 375
    if rnd < 380
      person = self.random_person(somewhere)
      return "en #{xn}#{%w(arena idrotssarena idrottsplats inomhusarena).sample} för #{self.idrott} i #{somewhere} som ägs av #{person.name}"
    end
    
    if rnd < 385
      frans = ["en mystisk luffare","en man i ett mörkt hörn på en bar","en läkare"]
      platser = frans.map{|x| x + " i #{somewhere}"}
      return platser.sample
    end
    
    frans = ["ett #{xt}multistellärt bolag","urangruvor","en #{xn}bank","en #{xn}ensligt belägen farm","en #{xn}enslig mörk skog",
             "en #{xn}restaurang","en #{xn}spökstad","en #{xn}kongress för advokater","en #{xn}kanal","en #{xn}kongress för clowner","nyhetsredaktionerna",
             "en #{xn}skönhetstävling","skolorna","lärarna","en #{xn}rymdkryssare"]
    platser = frans.map{|x| x + " i #{somewhere}"}
    
    if rand(100) < 30
      frans = ["ett #{xt}köpcentrum","en #{xn}tandläkarmotagning","en #{xn}pantbank","en #{xn}nöjespark","ett #{xt}mentalsjukhus","en #{xn}biograf","en #{xn}rymdhamn","en #{xn}park",
            "ett #{xt}plutoniumlager","ett #{xt}vapenlager","en #{xn}herrklubb","ett #{xt}palats","ett #{xt}städföretag","ett #{xt}pensionärshem",
            "en #{xn}simhall","en #{xn}övergiven bondgård","ett #{xt}vadslagningskontor","en #{xn}fiskebåt","en #{xn}outhyrd semesterstuga","ett #{xt}hem","en #{xn}radiostation",
            "en #{xn}snabbmatsrestaurang","ett #{xt}sjukhus","ett #{xt}kärnkraftsverk","en #{xn}rymdakademi","ett #{xt}slott","under en #{xn}sjö",
            "en #{xn}cirkus","en #{xn}racingbana","en #{xn}flygplats","ett #{xt}hotell","ett #{xt}pensionat",
            "en #{xn}skofabrik","en #{xn}robotfabrik (#{Person::ROBOTAR.sample}robotar)","en #{xn}gigantisk fabrik","en #{xn}rymdraketfabrik","en #{xn}vapenfabrik","ett #{xt}stålverk",
            "ett #{xt}storjordbruk","ett #{xt} grottsystem","en #{xn}teater","en #{xn}bridgeklubb",]
      platse2 = frans.map{|x| x + " i #{somewhere}"}
      platser.concat platse2
      person = self.random_person(somewhere)
      person.attributes << "Hittas ofta i #{somewhere}"
      return platser.sample + " som ägs av #{person.name}"
    end
    
    is = ["en #{xn}science fiction kongress","en #{xn}kloak","ett #{xt}köpcentrum","en #{xn}tandläkarmotagning","en #{xn}pantbank","en #{xn}skattgömma för en rymdpirat",
          "huvudstaden","en #{xn}poesitävling","ett #{xt}universitet","ett #{xt}storjordbruk","ett #{xt} grottsystem","en #{xn}teater","en #{xn}bridgeklubb",
          "en #{xn}nöjespark","ett #{xt}mentalsjukhus","en #{xn}biograf","en #{xn}kompisklubb","ett #{xt}pensionärshem","ett #{xt}bröllop","en #{xn}begravning","en #{xn}rymdhamn",
          "en #{xn}park","ett #{xt}plutoniumlager","ett #{xt}vapenlager","en #{xn}herrklubb","ett #{xt}barnhem","en #{xn}plats där androider skapas","ett #{xt}kemilabb",
          "en #{xn}rymdkadett-skola","en #{xn}tunnelbana","en #{xn}simhall","en #{xn}övergiven bondgård","en #{xn}övergiven väg","ett #{xt}vadslagningskontor","en #{xn}kocktävling",
          "en #{xn}fiskebåt","ett #{xt}palats","ett #{xt}städföretag",
          "en outhyrd #{xn}semesterstuga","en #{xn}spioncentral","en #{xn}radiostation",
          "en #{xn}urskog","en #{xn}snabbmatsrestaurang","ett #{xt}sjukhus","ett #{xt}kärnkraftsverk","en #{xn}jättehemlig anläggning för atombombsprov",
          "en #{xn}rymdakademi","ett #{xt}slott","under en #{xn}sjö",
          "högt uppe på en #{xn}bergstopp","en #{xn}cirkus","en #{xn}racingbana","en #{xn}flygplats","ett #{xt}hotell","ett #{xt}pensionat","en #{xn}hemlig militär forskningsanläggning",
          "en #{xn}filminspelning","en #{xn}skofabrik","en #{xn}robotfabrik","en #{xn}fabrik","en #{xn}rymdraketfabrik","en #{xn}vapenfabrik","ett #{xt}stålverk","en #{xn}glaciär"]
    platse2 = is.map{|x| x + " i #{somewhere}"}
    platser.concat platse2
    return platser.sample
  end
  
  # Tabell 27.1 - Land
  def land
    prefix = %w(Västra Östra Norra Övre Bortre Centrala Inre).sample
    rnd = rand(100)
    return prefix + " #{self.amerika}"                                if rnd < 6
    return self.amerika                                               if rnd < 15
    return %w(Sydamerikansk Östereuropeisk Sydöstasiatisk Antarktisk Västindisk Mellanamerikansk Afrikansk).sample + " militärdiktatur" if rnd < 17
    return %w(Asiatisk Afrikansk Mellanamerikansk).sample + " djungel" if rnd < 19
    return self.mystiskt_land                                         if rnd < 20
    return prefix + ' ' + COUNTRIES.sample                            if rnd < 30
    return prefix + ' ' + self.mystiskt_land                          if rnd < 31
    return COUNTRIES.sample
  end
  
  # Tabell 27.1.1 - Amerika
  def amerika
    rnd = rand(100)
    return 'New England'     if rnd < 25
    return 'Öststaterna'     if rnd < 35
    return 'Sydstaterna'     if rnd < 50
    return 'Louisiana'       if rnd < 55
    return 'Texas'           if rnd < 64
    return 'Mellanvästern'   if rnd < 77
    return 'Klippiga bergen' if rnd < 87
    return 'Kalifornien'     if rnd < 90
    return 'Hollywood'       if rnd < 93
    return 'Alaska'          if rnd < 97
    return 'Hawaii'
  end
  
  # Tabell 27.2 - Historienivå
  def historie_niva
    val = ['jägarstenålders','bronsålders','järnålders','romartids','vikingatids','medeltids','renässans',"industrialism (1800-tal):s",'vildavästerntids',
           'bondestenålders','långt över Jordens','Jordens nuvarande','tidig kolonial tids','människoap-kulturs','tidig rymdfarares','samuraitidens',
           'stäppnomadkulturs','herdekulturs','tidig stadskulturs','myrsamhälles','slavstyres','erövrarkulturs','krigarkulturs','meditationskulturs','upplyst och vis',
           '20-tals','50-tals','1900-tals','1700-tals']
    
    ar2 = ['ociviliserad','uråldrig','äldre och visare','krigar','byråkrat','teknikhatande','anarkoindividualistisk tekno','kleptokratisk','bioteknik','robotslav','fredsälskande',
           'tidsfarar','magiskt styrd','barbar','stjärnomspännande','tidig rymdfarar']
    val3  = ar2.map{|x| x + '-civilisations'}
    val32 = ar2.map{|x| 'ond ' + x + '-civilisations'}
    val4  = ar2.map{|x|  'fallande ' + x + '-civilisations'}
    miljo = ['telepatiskt kunnig, teknik fientlig','matfixerad','gudaliknande']
    val5 = miljo.map{|x| x + ' civilisations'}
    val = val + val + val3 + val32 + val4 + val5
    return val.sample + ' och ' + val.sample if rand(100) < 10
    return val.sample   
  end
  
  # Tabell 27.3 - Mystiskt land
  def mystiskt_land
    return MYTHIC_COUNTRIES.sample
  end
  
  # Tabell 27.3.1 - Mytisk plats
  def mytisk_plats
    return self.mystiskt_land if rand(100) < 16
    return MYTHIC_PLACES.sample
  end
  
  # Tabell 27.4 - Land el planet
  def land_el_planet
    rnd = rand(104)
    return HimlaKropp.random(self) if rnd < 15
    return 'tomma rymden'          if rnd < 18
    return 'öde rymden'            if rnd < 21
    return self.random_planet.name if rnd < 50
    return self.land               if rnd < 87
    return "en tidsdimensions på #{self.historie_niva}-nivå" if rnd < 95
    return 'asteroidbälte'         if rnd < 100
    return self.mystiskt_land
  end
  
  # Tabell 28 - strålar
  def ray
#34-35 Slump [Tab. 20.6]
    return 'Ondskestrålar (-2 HjP/påverkan)' if rand(100) < 2
    return 'Förvandlings till ' + self.ny_ras.name + '-strålar' if rand(100) < 3
    return 'Strålar som ger ' + self.psi_egenskap + ' som PSI-kraft' if rand(100) < 3
    
    out   = self.magityp(true).capitalize if rand(100) < 3
    out ||= self.musik.capitalize   if rand(100) < 3
    out ||= self.kanslor.capitalize if rand(100) < 3
    out ||= self.mutationsperiod + ' ' + self.mutation if rand(100) < 3

    rays = ['Kärleks','Jordbävnings','Teleportations','Döds','Döds','Döds','Värme','Kyl','Pest','Hypnos','Flygnings','Intelligensgivar','Intelligenssugar','Förstelnings','Ljus',
            'Gravitations','Maser','X','Lasso','Livsenergi',
            'Antigravitations','Radioktivitets','Orgon','Röntgen','Frys','Energi','Elektricitets','Kraft','Svaghets','Förvirrings','Galenskaps','Förstorings','Förminskning',
            'Tanke','Laser','Explosions','Traktor- (attraktions, knuff eller drag)','Uran','Svart ljus','Föryngrings','Föråldrings','Tids','Skyddsfälts','Reklam','Dröm',
            'Osynlighets','Röntgen','Antistrål','Purpur','Mutations [Tab. 21]','Stress','Lugnande','Aggresivitetsskapande','Glädje']
    
    out ||= rays.sample
    out += '- och ' + rays.sample if rand(100) < 10
    return out + '-strålar'
  end
  
  # Nya slumpsaker
  def no_skill
    if rand(100) < 60
      return ['Bränna','Dela sig','Pansar','Explodera','Flyga','Radiovågor','Regenerera','Rymdtidsvävshoppa','Krossa','Röntgensyn','Kärnreaktion','Svälla','Tända eld',
              'Krympa','Mala','Titta långt','Titta nära','Målsöka','Värme','Kyla','Osynlighet','Äta fiender','Slemma','Bli vätska','Ostoppbar','Telepati','Studsa',
              'Ignorera gravitationen','Skjuta projektiler'].sample
    end
    return "Stråla " + self.ray     if rand(100) < 10
    return self.magityp(true)       if rand(100) < 10
    return self.psi_egenskap+'-PSI' if rand(100) < 10
    return self.mutera              if rand(100) < 10
    return 'Transmutera saker till ' + self.material_hard    if rand(100) < 2
    return 'Transmutera sig till ' + self.material_hard      if rand(100) < 4
    return 'Förvandla vätska till ' + self.material_floating if rand(100) < 4
    return 'Spruta ' + self.material_floating                if rand(100) < 4
    if rand(100) < 80
      return ['Osårbar','Ge energi','Regenerera','Gudsemulering','Räkna svåra tal','Mångdimensionalogi','Visa rörliga bilder','Katalysera','Förtunnna sig',
              'Månggenerationsminne','Spå framtiden','Klona sig','Bygga kopior av sig själv','Skapa liv','Byta kropp'].sample
    end
    return ['Komma på lösning av scenario','Resa i tiden'].sample
  end
  
end