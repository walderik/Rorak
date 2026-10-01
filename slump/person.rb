# ruby script/runner 'script/slump/slump.rb'
# En NPC i regel

# Vid sällsynta tillfällen passar dock en karaktär inte in på
#  Omvänd skurk eller någon annan karaktärstyp. I så fall kan GO
#  konstruera en ny, efter det enkla mönster som finns i tabell 1, på
#  sidan 133. Det är bara att fördela HjP och FP, så att totalsumman
#  blir lika med de övriga typerna, och sedan ge typen två grundfärdigheter.
#  Vid fördelningen kan en bra grundregel vara att mer
#  kunniga karaktärstyper har mer FP, medan mer flexibla typer har
#  fler HjP.
#  Vill du ha förslag på andra karaktärstyper så rekommenderar jag
#  kapitel 12 (sidan 99) vilket handlar om olika NPC-typer. Det är
#  lätt att tänka sig några av dessa typer som Frihetskämpe,
#  Komisk person och Stålråtta som karaktärstyper. Alla former av
#  skurkar är dock uteslutna och att spela Galactic Overlord är alltid
#  helt förbjudet.
class Person
  TYPER = %w(människa BEM robot android)
  ROBOTAR = %w(städ fiskare brytar hushålls gatuarbetar strids mördar döds byggarbetar nöjjes dans fabriksarbetar diplomat soptunne spejar pilot chafförs översättar predikant
               leksaks meka kompis bästis hisskötare polis armbrytar boxnings symaskins diskmaskins smed smugglar försäljar trädgårdstomte trädgårdsmästar spion räknestickehanterar
               reparatörs lönnmördar livvakts vampyr bensinpumps påklädar betjänts buttler nany dommare läkar kirurg scout flygmaskins invasions dykare urverks utomjordisk
               repslagar knypplar diskar vakt hund kanin häst katt kock rörrensar hamnsjåar tavelhängar tråddragar artist konstnärs vägläggare våg zombie plantage toalettpapperhållar
               kompis gjuteri förpackare lärare rektor- tränar elektriker dräng författare bud bultar lillebrors tvättstuge antropolog- desinfektions tidmätar navigatör målare
               fixar politiker svets kamera mangel bergsbestigare blodprovs murare publik skräddar gräv kaffebryggar jultomte jurist skruvar fångvaktar vaktmästar kassapparats
               morse gramofon sjukskötar sorterings sekrerar hållafast borrar håltagar stämpel bibliotikarie äventyrar gatsopar soppkokar hammar sovar butler badmästar hovslagar
               ökengrävar soptunne berättar bandspelar soldat sorterings måttbands matlagnings advokat produktprovar grovarbetar dödgrävar böjjar byråkrat bagare sockerbagare
               fladdermus personalchefs disco)
               
  FOBITYPER = ['öppna ytor','fåglar','spindlar','ormar','trånga utrymmen','hissar','hajjar','skämd mjölk','människor','religion','rymdhjältar','att duscha','mörker','höga ljud',
               'höjder','höga höjder','flyga','rymden','kräkas','vilda djur','insekter','korsa vägar','sprutor','vapen','katter','smärta','köra bil','åka rymdraket','titta uppåt',
               'blåsig vind','män','kvinnor','bin','växter','eld','blixtar','stjärnor','himlen','flöjter','ensamhet','baciller','mitta','falla','ödlor','kräldjur','åska,paddor',
               'gift','sin spegelbild','clowner','hundar','träd','slänga saker','uppstoppade djur','inbillad fulhut','fula saker','öde platser','arbete','att rodna','fobier',
               'ljus','knän','gå över en bro','vatten','skriva','tala inför folk','nakenhet','solljus','talet 666','hästar','långa ord','sömn','somna','fiskar','myror','snabba rörelser',
               'små slutna utrymmen','stormar','sand','snören','maskiner','möss och råttor','smuts','döden','döda saker','nyheter','sjukdomar','tandvård','folksamlingar',
               'höra sitt namn','ormar','retiler','fladdermöss','kroppslukt','kroppsbehåring','allt','starka lukter','fredagen den 13:2','dockor','barn','fattigdom','att svälja',
               'att kvävas','skägg','skolan','maskar','bli iaktagen','getingar','bli levande begravd','siffran 4:a','mörka, djupa vatten','teaterbesök','operationer','bli fet',
               'färgen gult','djur','robotar','androider']
               
  BROTTSLINGSTYPER = %w{ficktjuv tjuv rånare bankrånare mördare giftmördare styckmördare smugglare kidnappare förfalskare solåvårare}
  
  SAMLA = %w(dock skiv antikvitets bok frimärks fjärils insekts sko tennsoldats virus orkide staty bil mynt sedlar pengar militaria konst tennstops granat silver porslins dock medalj 
             bil båt motorcykel flygplans samlar
             rymdhjälte svärd uniform kniv kuriosa fisk kaffe konst staty silversked ädelstens klock fickur verktygs tändsticksasks tenn mässing smyckes möbel porslinsräv robot 
             BEM kylskåpsmagnets handduks cyklar slem amorin souvenir ordspråks gåt)
      
  
  attr_accessor :name, :relation, :magi, :skp, :typ, :ras, :alignment, :ond_religion, :attributes, :sidekicks, :boplatser, :skills
  
  def initialize(options)
    options ||= Hash.new
    default_options = {:is_man => (rand(100) < 60), :typ => nil, :is_ond => (rand(100) < 40), :har_relation => (rand(100) < 10),
                       :ar_magiker => (rand(100) < 5), :ar_rymdskurk => (rand(100) < 10),
                       :skp_bonus => 0, :name => nil, :attributes => [], :stubb => false, :level => 1}
    @options = default_options.merge options
    @scenario = @options[:scenario]
    
    @sidekicks = Array.new
    @boplatser = Array.new
    @skills    = Hash.new
    @level = @options[:level]
    
    @options[:is_ond] = true if @options[:ar_rymdskurk]
    
    @attributes = (options[:attributes] || Array.new) #if options[:attributes] != false
    
    ledare = @options[:ar_rymdskurk]
    @name = @options[:name] || "#{(@options[:is_man] ? RandomName.boy(ledare) : RandomName.girl(ledare))} #{RandomName.last}"
    
    @typ = @options[:typ].titleize if @options[:typ].present?
    @typ ||= self.get_typ
    
    unless options[:stubb]
      @level += rand(10) if self.is_a?(Monster)
      @relation = self.relation if @options[:har_relation]
    
      @skp = @options[:is_ond] ? self.get_skp(@options[:ar_rymdskurk]) : -self.get_skp(false)
      @skp += self.get_skp(false) if @typ.include?('android') && @skp > 0 # Alla vet att androider är extra onda
      @skp += @options[:skp_bonus].to_i
      @options[:is_ond] = false if @skp < 0 && @options[:is_ond]
      
      # Dyrkar man en ond gud får man lite bonus-ondska
      if @options[:is_ond] && (rand(100) < 5)
        @ond_religion = 'Dyrkar fanatiskt ' + @scenario.ond_gud 
        matchdata = @ond_religion.match(/\+(\d+) (skp)/i)
        div = @options[:ar_rymdskurk] ? 40 : 100
        @skp += (matchdata[1].to_i/div).to_i if matchdata.present? && matchdata[1].present?
        @attributes << @ond_religion
      end
      
      @alignment = @options[:is_ond] ? 'ond' : @scenario.livsaskadning(true,false)
      if @alignment == 'ond'
        @skp = -@skp if @skp < 0         # kolla att onda har skurkpoäng
      elsif @alignment ==  'neutral'
        @skp = 0
      else
        @skp = (@skp/3).to_i if @skp < 0 # För alla tveksamt goda
      end
      
      @magi = @scenario.magityp(false) if @options[:ar_magiker] || (@options[:is_ond] && (rand(100)<5))
      @attributes << 'Kan ' + @magi if @magi.present?
      @attributes << "Kan använda '#{@scenario.psi_egenskap}'-PSI" if rand(100) < 4 || (@options[:ar_rymdskurk] && (rand(100)<25) && !@typ.include?('robot'))
      if @skp > 0 || @options[:is_ond] || (rand(100)<10 && ['känslosam','neutral','irrelevant'].include?(@alignment))
        @attributes << self.ond_egenskap
      end
      @level += rand((@skp/2).abs).to_i
      if @options[:ar_rymdskurk]
        @level += rand(3) + rand(3)
        (rand(3)+1).times do 
          @attributes << self.ond_egenskap
        end
      end
    end
    # Ta sist reda på var personen bor, om ens känt
    @boplatser << @options[:boplats] if  @options[:boplats].present?
    while rand(100) < 25 && @boplatser.length < 3
      somewhere = nil
      somewhere   = @scenario.mytisk_plats     if rand(100)<2
      somewhere ||= @scenario.plats            if rand(100)<500
      somewhere ||= RandomName.stad            if rand(100)<15
      somewhere ||= @scenario.land_el_planet # Anropa bara den här metoden en gång för den kan skapa en ny planet i ett anrop
      @boplatser << somewhere
    end
    # Skapa sidekicks. Först bara onda till en Rymdskurk
    if @options[:ar_rymdskurk]
      rand(5).times do
        @sidekicks << self.sidekick(@options[:is_ond])
      end
    end
  end
  
  def to_a
    out = [@name]
#    out << 'Rymdskurk?   ' + (@options[:ar_rymdskurk] ? "JA" : "NEJ")
    out << 'Kön:         ' + (@options[:is_man] ? "Man" : "Kvinna")
    out << "Relation:    " + [han_hon.capitalize, 'är', @relation].join(' ') if @relation.present?
    out << 'Typ:         ' + @typ
    out << 'Nivå:        ' + @level.to_s if @level > 0
    out << 'Yrke:        ' + @yrke if @yrke.present?
    out << 'Ond/God:     ' + @alignment.capitalize
    out << 'Skurkpoäng:  ' + @skp.to_s if @skp > 0
    out << 'Hjältepoäng: ' + (-@skp).to_s if @skp < 0
    out << 'Bor:         ' + @boplatser.join(', ') if @boplatser.present?
#    out << ' - MONSTER' if self.is_a?(Monster)
    self.attributes.uniq.each do |attribute|
      out << ' - ' + attribute
    end
    if self.sidekicks.present?
      out << ''
      out << (@skp > 0 ? '   Henchmen: ' : '   Sidekicks: ')
      self.sidekicks.each do |sidekick|
        sidekick.to_a.each do |a|
          out << '    ' + a
        end
        out << ''
      end
    end
    return out
  end
  
  def to_s
    return self.to_a.join("\r\n")
  end
  
  # Tabell 11.3 - Skurkstyrka
  # Tabell 12.3 - Rymdskurk - styrka
  def get_skp(ar_rymdskurk=false)
    rnd = rand(100)
    unless ar_rymdskurk
      return 4 if rnd < 10
      return 6 if rnd < 25
      return 8 if rnd < 35
      return 12 if rnd < 60
      return 14 if rnd < 80
      return 16 if rnd < 90
      return 18 if rnd < 95
      return 20 if rnd < 98
      return 25 
    end
    return self.get_skp(false) if rnd < 10
    return 18 if rnd < 40
    return 20 if rnd < 60
    return 25 if rnd < 80
    return 30 if rnd < 90
    return 40 if rnd < 95
    return 70 if rnd < 98
    return 101 + rand(100)
  end
  
  def get_typ
#    return 'människa' if rand(100) < 80
    typ = Person::TYPER.sample.capitalize
    if typ == 'Bem'
      @ras = @scenario.random_ras(nil, false)
      typ << (' - ' + @ras.name)
      return typ
    elsif typ == 'Robot'
      robots = Person::ROBOTAR + ['åker runt och säger pip-','liten svart låda-','skadedjurs bekämpande ','hejja på-','göra gladare-','slå larm','grönsakshackar-']
      robot_typ = robots.sample.capitalize + 'robot'
      typ << (' - ' + robot_typ)
      @yrke = robot_typ
    elsif typ == 'Människa' || typ == 'Android'
      @yrke = 'Skomakare'
    end
    return typ
  end
  
  
  def han_hon
    return @options[:is_man] ? 'han' : 'hon'
  end
  
  def manlig_kvinnlig
    return @options[:is_man] ? 'manlig' : 'kvinnlig'
  end
  
  def relation
    is = ["bästa vän till någon i gruppen", "nära #{manlig_kvinnlig} vän till någon i gruppen", "#{manlig_kvinnlig} vän till gruppen", "#{slakting} till någon i gruppen", 
          "#{slakting} till gruppens ledare", "#{slakting} till någon i gruppen", "#{slakting} till #{manlig_kvinnlig} vän till någon i gruppen"]
    return is.sample
  end
  
  def slakting
    # Lägg till en bunt förändringar av SKP
    relative = ['okänd släkting','avlägsen släkting','barnbarn','kusin','tremänning','syssling','pyssling','barnbarnsbarn','tidig släkting','sen släkting','klon','barn','klon-barn']
    if @options[:is_man]
      relative.concat %w(man pappa far styvfar son bror morbror farbror farfar morfar)
    else
      relative.concat %w(fru mamma mor dotter styvmor syster moster tant faster farmor mormor)
    end
    title = relative.sample
    if rand(100) < 10
      title = "#{@alignment} #{title}" 
    elsif rand(100) < 10
      title ="#{%w(elak snäll älskad givmild generös snål tjuvaktig lättglömd elak snäll nära skämtsam lömsk).sample} #{title}"
    end
    if rand(100) < 10
      prefix = ['falsk', 'ingift', 'adopterad', 'bonus', 'förlorad eller trodd var död']
      title = "#{prefix.sample} #{title}"
    end
    return title
  end
  
  # Tabell 25 - Ond Egenskap
  def ond_egenskap
    # Annan brottskarriär [Tab. 11]
#    23 Bionisk kroppsdel [Tab. 15]
#    30 Galen fanatisk forskare [Tab. 5.1]
#    32 Eg. övernaturlig [Tab. 9.1]
#    39 Annan egenskap [Tab. 20.6]
#    43 Hatar... [Tab. 3.2] - Part i krig
#    44 Hatar Tabell 17 - Sak
#    46 Hatar... [Tab. 1.2]
#    49 General [Tab. 19]
#    50 Förvarar ett kidnappningsoffer i sin källare [Tab. 1, utom [Tab. 11]]
#    58 Samlar... [Tab. 17] - Sak
#    60 Har en skurkaktig medhjälpare [Tab. 11]
#    62 Rutten kroppsdel [Tab. 21.1]

#    64 Verktygsmördare [Tab. 17.2]
#    65 Döljer en hemlighet [Tab. 5]
#    67 Planerar en katastrof [Tab. 4.1]
#    69 Har en skurkaktig släkting [Tab. 1.1] + [Tab. 11]
#    70 Har mördat en släkting [Tab. 1.1]
#       Äger en hemlig trupp med [1D100] soldater som används vid personlig fara [Tab. 19]
#    81 Har mördat en person [Tab. 5.2]
#    82 Amatörforskare [Tab. 5.1]
#    83 Har en slav [Tab. 5.2]
    rnd = rand(120)
    return "Spelar #{@scenario.musik}"                    if rnd < 1
    return "Till hälften #{@scenario.djur(true)}"         if rnd < 2
    if rnd < 3
      if @options[:ar_magiker]
        return "Galen magiker"
      else
        @options[:ar_magiker] = true
        return "Galen magiker med '" + @scenario.magityp(false) +"'"
      end
    end
    return "#{@scenario.land}-patriot"                   if rnd < 4
    return "I hemlighet från #{@scenario.mytisk_plats}"  if rnd < 5
    return "Gjord av #{@scenario.material_hard}"         if rnd < 6
    return "Har en #{@scenario.djur(true)} som husdjur"  if rnd < 7
    return "Förknippas med #{@scenario.material_hard}"   if rnd < 8
    return "Hatar #{@scenario.djur(false)}"              if rnd < 9
    if rnd < 10
      min_ras = @ras.name if @ras.present?
      return "Hatar BeM av rasen #{@scenario.random_ras(min_ras, false).name}"
    end
    if rnd < 11
      planet = @scenario.random_planet
      planet.attributes << "Ägs av #{self.name}"
      return "Äger planeten #{planet.name}" 
    end
    return "Vill förgöra #{@scenario.land}"              if rnd < 12
    return "Plågade #{@scenario.djur(false)} som barn"   if rnd < 13
    if rnd < 14
      planet = @scenario.random_planet
      planet.attributes << "Styrs i hemlighet av #{self.name}"
      return "Styr i hemlighet planeten #{planet.name}" 
    end
    return "Kan använda '#{@scenario.psi_egenskap}'-PSI" if rnd < 15
    return "Bryter på en dialekt från #{@scenario.land}" if rnd < 16
    return "Har tidigare härjat i #{RandomName.stad}"    if rnd < 17
    return "Fanatisk utövare a #{@scenario.idrott}"      if rnd < 18
    if rnd < 20
      relation = ['God vän med','Bästa vän med ','Fiende till','Dödsfiende till','Skolkamrat till','Kusin med','Hatar','Förälskad i','Syssling till'].sample
      person = @scenario.random_person(nil, self.name)
      person.attributes << "#{relation} #{self.name}"
      return "#{relation} #{person.name}"
    end
    return "Kan #{@scenario.mutationsperiod} #{@scenario.mutation}"   if rnd < 22
    if rnd < 24
      slakt_type = self.slakting
      mut = "Kan #{@scenario.mutationsperiod} #{@scenario.mutation}"
      slakt = "#{slakt_type} till #{self.name}"
      pers = @scenario.random_person(nil, self.name, {:scenario => @scenario, :is_ond => ((rand(100)<50)?true:nil), :typ => @typ, :attributes => [mut,slakt]})
      return "Har en #{slakt_type} (#{pers.name}) som #{mut}"
    end
    return "Har #{@scenario.kroppsdel} av #{@scenario.material_hard}" if rnd < 25
    return "Har ruttet #{@scenario.kroppsdel.capitalize}"             if rnd < 26
    
    sla_satt = %w(rasande lugnt iskallt överraskande kreativt brutalt sadistiskt).sample
    val = ['Galen','Schizofren','Hungrig','Paranoid','Giftassugen','Matematiker',"Var tidigare #{BROTTSLINGSTYPER.sample}","Är #{BROTTSLINGSTYPER.sample}",'Sexfixerad',"Fanatisk #{SAMLA.sample}samlare",
           'Maktgalen','Död','Fult ansikte','Äckligt skratt','Plötsliga raserianfall',"Tenderar att straffa alla som säger emot på ett #{sla_satt} sätt","Känd #{SAMLA.sample}samlare",
           "Talar på ett #{sla_satt} sätt", 'Gillar att leka katt och råtta med fiender','Tycker om att plåga oskyldiga','Dolda tentakler','Sinne för dramatik','Tränar jaktfalkar',
           'Estetikmotiverad','Talför (ormstunga)','Äckliga fysiska vanor','Stammar när arg','Taskig barndom','Hobbypatolog','Älskar tåg','Tycker om att glänsa','Äter rått kött','Ekonom',
           'Skrytsam',"Genomför sina planer på ett #{sla_satt} sätt",'Sprängämnesexpert','Älskar explosioner','Röker cigarrer','Har lapp för ögat','Har en guldtand','Pratar gnälligt',
           'Enormt egocentrisk','Pyroman','Dödade sin mamma','Har käpp','Hatar mutanter','Hatar robotar','Hatar androider','Bor på toppen av ett berg','Bor i en grotta','Girig','Epileptiker',
           'Bor under havet','Är rik','Bär monokel','Har lång vaxad mustasch','Håller ofta långa tal om sina onda planer','Förmåga att överleva katastrofer','Har förmågan att kontrollera hjärnor',
           'Hatar människor','Hatar androider','Vän med en korp','Excentrisk klädsmak','Olja i håret','Blemmor i hyn','Ärr i pannan','Har sur mage','Gör kräkljud','Snyter sig ofta',
           'Använder ofta sollampa','Äger ett fantastiskt palats','Otroligt rik','Går klädd i gamla slitna kläder','Cyniker','Äslakr fällor','Älskar sätta folk på prov','Sadist','Masochist',
           'Dödar underhuggare som misslyckas','Ensam','Envis','Klädsnobb','Hälsofanatiker','Tuggar tuggumi','Har hopväxta ögonbryn','Kedjeröker','Har agarofobi',"Har en fobi mot #{FOBITYPER.sample}",
           'Ädel','Älskar låta folk vänta','Älskar gåtor','Gör practical jokes mot fiender','Ansikte som liknar en dödskalle','Lögnare','Manipulatör','Nervärderar andra',
           'Fascinerad av smärta','Flottigt hår','Vassa armbågar','Bär prydnadssvärd','Lismande','Bjuder på godis vid gott humör','Hatar potatis','Alkoholiserad','Röker Opium',
           'Har en stark säkerhetstjänst','Har kalla händer','Fascist','Luktar sur mjölk','Skatteindrivare','Njuter av andras olycka','Snål',
           'Stjäl gärna från barn','Sjunger och sjunger falskt','Älskar parader','Har kalla händer','Har lysande ögon','Har hederskodex','Vill rädda världen','Groteskt fet']

    return val.sample
  end
  
  def sidekick(ond)
    henchman_egenskaper = ['lojal','hjälpsam','inställsam','imkompetent','sadistisk','småleende','ointelligent','girig','lismande','skjutglad','tystlåten','gnisslande skratt','fnittrar lätt',
                           'hatiskt','ganska snäll','sadomasochist','masochist','oskicklig','luktar illa','mutbar','oförmögen att följa order','oduglig','stabil','överskattar sin förmåga',
                           'illojal','solidatirk','trofast','kamratlig','spelad vänlig','tillgiven','schysst','trogen','trofast','rehårig','plikttrogen','yrkeskriminell',"Har en fobi mot #{FOBITYPER.sample}",
                           'sadist','plågoande','plågare','pennalist','elaking','grym','pinoande','fjäskande','krypande','sliskig','oljig','hal','honungslen','insmickrande','krypande',
                           'krälande','svär mycket','smickrande','svansande','servil']
    henchman_egenskaper.concat BROTTSLINGSTYPER
    options = {:scenario => @scenario, :is_ond => ((rand(100)<95)?true:nil), :typ => ((rand(100)<60) ? @typ : nil), :ar_rymdskurk => false, :attributes => [henchman_egenskaper.sample.capitalize]}
    if rand(100) < 95
      return Person.new(options)
    end
     return Monster.overnat_varelse(options)
  end
 
  # 'HållfasthetsPoäng hanteras separat, eftersom dom är speciella.
  # Se X ut behöver också lite speciell hantering, så jag väntar med den.
  SKILLS =  ['Analysera','Använda Räknesticka','Astrogation','Atom och strålvapen','Balansera','Bildsinne','Brottas','Brygga','Bryta','Bygga','Dansa','Ducka','Exo-Biologi','Fånga',
             'Förföra','Genteknik','Gömma sig','Göra Evighetsmaskin','Handha och köra maskiner','Hitta saker','Hoppa','Hyperrymd','Hypnotisera','Kasta','Kemi','Klättra',
             'Komma ihåg','Konentration','Kroppsarbete','Köpkunskap','Laga mat','Ledarskap','Lukta','Lyfta','Lönnmörda','Maskera','Meka','Metafysik','Militära färdigheter',
             'Musikalistet','Ockult','Orgel','Pilla','Pilot','Raketpilot','Reflexer','Rida','Robotlära','Rymdkrigskanon','Se bra ut','Simma','Sjukvård','Skjuta','Skrika',
             'Slå','Smyga','Spela','Springa','Spränga','Spåra','Stjäla','Tala snabbt','Trixa','Uppfinna','Veta']
             
 
  # Bems, robotar och androider kan ha ofärdigheter. Robotar och androider betalar dock dubbelt för dom
  # Sätt vilka och hur mycket av dom som den här personen har
  # En god person har totalt 18 poäng som nybörjare. 
  #  Karaktärstyp  : HjP : Fp : Max HjP : Fasta Färdigheter : Ofärd Kostn
  #  Duktig Pojke  : 14 4 30 Pilla, Klättra -----
  #  Fin Flicka    : 14 4 30 Se bra ut, Laga Mat -----
  #  Rymdhjälte    : 10 8 25* Skjuta, Raketpilot -----
  #  Rymdprinsessa : 10 8 25* Skrika, Förföra -----
  #  Omvänd Skurk  : 8 10 12 Skjuta, Smyga -----
  #  Vetenskapare  : 6 12 10 Analys, Uppfinna -----
  #  Forskare      : 6 12 10 Analys, Räknesticka -----
  #  BeM           : 11 9 20 Inga Fasta 1
  #  Robotar       : 1 16 5 Pansar, Komma ihåg 2
  #  Androider     : 1 17 5 Veta, Reflexer 2
  #
  #  Alla får också gratis 1 i Springa och 3 i HållfasthetsPoäng (mfl).

  def set_skills
    # Färdigheterna sparas i hashen @skills
    
  end
end
