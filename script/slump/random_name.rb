class RandomName

  GIRLS = %w(Lisbeth Maggan Doris Misley Dagmar Annette Alicia Hokey Lise Lotte Magdalena Johanna Pepsi Ultima Regalia Pippi Manilla Georgia Ådel Amalfrieda Ada Millan Hjördis 
              Alessandra Alex Alexandra Alexa Cassandra Desdemona Emmanuelle Gwendolyn Mirabella Philomena Loise Noppa Norpa Alberta Adalberta Albrun Esmeralda Vilhelmina Klarabella 
              Harrietta Constantia Jacqueline Waqi Shunnareh Sarsoureh Rigel Rima Laila Solstråle Månstråle Elderberry Sunflower Asta Gabriella Carin Erika Georgina Freja Gry Agneta 
              Margareta Rey Kay Kaj Kajsa Kritan Ellinor Paris Delphine Eleonor Andrea Angela Angelika Adolfa Antoinette Hanna Gunvor Zulema Carina Karina Anna Karin Emelie Ylva 
              Ettan Nettan Alice Lisen Kim Katarina Naila Adolfine Anita Adriane Anna Anne Antje Agatha Antonia Elin Ellen Anna Ada Adela Bella Adina Adriana Agnes Matilda Magda 
              Sanna Beata Morrigan Morgana Beate Beate Beatrix Beatrice Brigitte Birgitta Charlotte Barbara Christiane Jackie Angelina Ange Camilla Kamilla Larissa Olga Agnes Juni 
              Alice Leah Dora Dorothea Elke Elisabeth Else Emma Edda Erna Eva Frida Fausta Fabiola Felicitas Barbro Jordan Alicia Leia Alma Lilly Alva Linnea Amanda Liv Amelia Livia 
              Astrid Li My Ayla Lova Belle Bianca Lovisa Bonnie Luna Lykke Beatrice Csaba Arild Lisa Jojjo Lisa Annika Felicia Martina Ulla Elvira Josefine Frauke Gaby Gabriele Fieke 
              Geraldine Gerda Gerta Gertraud Gisa Gisberta Gisela Gitte Hedwig Hedda Waldhild Waltrada Wendelgard Wanda Nyamko Linda Elin Maj Lis Mona Gunborg Kristina Fia Adelina 
              Nadenka Nadezhda Alena Alieta Nadja Nadyenka Alla Nasta Alyona Nastasia Anastasia Natasha Nelli Annushka Nikita Anya Nina Kicki Arina Oksana Olga Belka Panya 
              Polina Bojana Christina Raisa Daria Roza Diana Sabina Dinara Dominika Saschenka Sasha Duschinka Dusica Slava Ekaterina Sofia Elena Eleonora Sonja Esfir Sonya Stefaniya 
              Evelina Svea Sveta Svetlana Feodora Taisia Gala Galina Tamara Grusha Tanya Inessa Inga Irina Ivanna Tatiana Jelena Jelina Vanja Karina Vanka Katerina Vanna Katia Katina 
              Katinka Venera Venus Kenya Vera Khrystyna Kira Veronika Klara Victoria Ksenia Violetta Violet Lada Lara Viveca Larisa Lelyah Vor Lena Lidia Yana Lilia Yarina Asia
              Europa Yasemin Lizabeta Yasmina Yekaterina Luba Lucya Lucy Gabriel Ludmila Manya Margarita Yuriko Maria Zasha Marianna Marina Zia Marisha Marta Masha Matrena Ester
              Elsi Elsy Oceania Frigida Gotica Venus Hestia Hera Birgitta Titania Ida Idun Hel Cornelia Aurora Rut Korea Nefretiti Salome Afrodite Athena Beirut Persefone Angelica 
              Malin Ingeborg Ingemo Murael Duni Lunabelle Zimal Irha Mileya Kayan Kabher Hoorain Linelle Miraal Mistral Abrish Rittal Amaira Eleysa Mileah Raitl Aava Almaas Celina
              Elara Liyana Nyra Watin Heylin Maiza Ember Amber Advika Daneen Melaher Wateen Anabia Aylina Ruftalem Cinemon Chimamanda Amada Melael Aarna Eliora Eminella Laren
              Loelle Lovelia Aleyah Inaaya Mineah Retal Lovi Jovi Cataleya Lamia Larissa Elsa Lina Maia Ambrosia Melissa Andromeda Ariadne Apollonia Myrra Artemis Astria Astra Asta
              Nemesis Atalanta Nike Atena Pandora Panope Paris Penelope Persefone Dione Therese Abriana Bambi Bianca Caprice Cara Carin Carlotta Cettina Contessa Domnina Donatella
              Fabiana Fiorella Fiorenza Geatana Gioia Giordana Giovanna Graziella Ilaria Italia Svea Justina Lanza Lave Liona Luca Lucia Luciana Mariabella Marietta Marsala Mia
              Ella Michelle Mila Natalia Ornella Prima Primavera Quorra Racarda Romana Ruffina Sidonia Sienna Sistine Speranza Tessa Trilby Sizzy Zissy Mamma Desiré)

  def initialize
#    srand
  end
  
  def RandomName.girl(ledare = false)
    names  = GIRLS
    50.times{ names << RandomName.random_string.capitalize }
    
    name_prefix ||= %w(Dr. Doktor Ms Miss Dame Fru Grevinna Prof. Professor Major Kapten General Minister Captain Doctor Protector Drottning Kejsarinna Ordförande Sekreterare Prinsessan Furstinnan) 
    
    name   = names.sample + '-' + names.sample if rand(100) < 7
    name ||= names.sample
    name += ' ' + ('A'..'Z').to_a.sample if rand(100) < 10
    
    return name_prefix.sample + ' ' + name if rand(100) < 10 || ledare
    return name
    
  end
  
  def RandomName.boy(ledare = false)
    names  = %w(Muller Tomas Hinter Benjamin Antony Nestor Kelly Sven Daniel Swensk Joakim Jocke Timmy Åke Örjan Charles Volodymyr Petro Ihor Ior Oleksandr Mykola Oleksij Shmyhal Edmundur 
                Art Adamsker Pöcke Alessandro Clementine Fredrik Fredrico Alex Alexander Alexsandro Maximilianus Max Maximus Maximisimus Hugo Dale Manos Albrun Adel Rashaad Ibrahim Linus 
                Hassan Frederico Tomas Thomas Tomaso Figuero Ramon Caron Carolus Tony Tim Barth Virus Noppe Abbo Abo Alberich Elberich Agilbert Dolf Clemens Gabriel Erik Göran George Juno 
                Douglas Ståle Jens Hjorvard Frode Roy Kay Kaj Kritan Pelle Pellinor Johan Morgan Amadeus Amadeo Armin Arnold Berthold Balduin Sigard Harabanar Eric Gunnar Viggo Jörgen 
                Bartholomew Beauregard Montgomery Norik Ettan Daniel Jim Mats Kjell Simon Magnus Kim Botho Benno Chlodwig Clemens Dagobert Hartman Harkilar Pelle Anton Sune Peter 
                Hannes Morgan Jon John Fredrik Adrian Göran Björn Ben Parsi Klas Storebror Börje Carl Calle Kalle Peder Tor Tore Ture Emil Erhard Lance Lancet Dag Jackie Ange Ola Olle 
                Olov Olof Håkan Andreas Anders Alov Aleg Varg Wolf Kristian Christian Felix Fingal Johan Erwin Fabian Fabius Falco Fleke Lo Mo Lovis Lykke Jan Steffen Isak Graf Ultimor 
                Ferdinand Freddy Florianus Friedrich Gandolf Georg Georg Georg Georg Georg Engelbrecht Eduard Christoph Azdin Bror Vilde Neo Bryan Per Pär Åke Lars Ove Kalle Michel Morris 
                Wa Tobias Justin Gerwig Giselbert Godehard Gottfried Gottlieb Götz Hansdieter Hans Dieter Hartmann Hartmut Heiko Hasso Hasse Harald Hauke Walbert Weikhard Walderik Walpurgis Welfhard 
                Waldebert Wendelbert Waldemar Woldemar Walfried Wastl Werner Wedekind Septimus Wernfried Butcha Sabuni Flash Fabian Zane Algernon Fergus Tobias Buck Rufus Fergus Hök Devin 
                Kevin Dregen Rock Marlcolm Igor Derek Dagge Dusty Emanuel Ingemark Zohan Tiar Falke Falkon Avyaan Ivaan Ivan Kayan Kiaan Jaxx Ahil Kabiel Priam Rajan Rejjan Kylo Lijon
                Lejon Aylan Floke Folke Yuvaan Makbel Villot Vilgon Vilmer Albus Helix Kaon Mucad Mazon Yoab Agastya Ayansh Rudransh Roger Robert Viaan Cassian Kion Ellian Sarim Samarin
                Sebion Troi Zayn Divit Jaxon Kylian Milas Midas Kiian Nelion Aadvik Arvid Knox Rohaan Easton Gastgon Gillion Gilliam Lias Bob Bobbo Sture Agato Amedeo Ilya Nikita Goergi
                Amerigo Aretino Arrigo Attilio Benvenuto Biondello Borachio Braulio Broinze Cajetan Carmelo Carmine Celesto Cirrillo Corrado Demarco Donato Donus Eriberto Ermanno Ettore Falito
                Fiorello Flavio Floritzel Fortino Galileo Genovese Giancarlo Gianni Gino Giovanni Honorius Hormisdad Hortensio Indro Lombardi Marco Mariano Martino Massimo Maurizio
                Mercury Messala Michelangelo Napoleon Nek Nino Nuncio Othello Paco Pancrazio Paolo Paris Philario Pino Pisano Primo Primus Rocco Proculeius Romeo Ruggerio Santo Santa 
                Saverio Silvano Solanio Taddeo Tancredo Ugo Uno Umberto Venezio Venturo Vesuvio Vitalian Vittorio Zanebono Zanipolo Frank Molgan Kasper Kaspian Shi Ji Bo Ted Tod Teodor
                Papa)
    50.times{ names << RandomName.random_string.capitalize }
    
    name_prefix ||= %w(Dr. Doktor Mr Sir Herr Greve Prof. Professor Major Kapten General Minister Captain Doctor Protector Kung Kejsar Ordförande Sekreterar Prins Furst) 
    
    name   = names.sample + '-' + names.sample if rand(100) < 7
    name ||= names.sample
    name << (' ' + ('A'..'Z').to_a.sample) if rand(100) < 10
    
    name = name_prefix.sample + ' ' + name if rand(100) < 10 || ledare
    return name
  end
  
  def RandomName.last
    names  = %w(Andersson Libby Hjort Dimma Tillberg Nerdy Emmenthalerberg Lemmon Shiny Frost Zimmerman Überblücker Wassermitter Mitterfeller Hemmeldemmel Materhorn Johansson Roos Röse Müller Topper Pahlo 
                Andersén Andrén Blackhouse Österström Achté Bräutigam Delbrück Flügge Çelik Şahin Wróblewski Gonçalves Oliveira Hjort Lillebror Storebror Brorsson Kemppainen Aronsson Kjellson Persson Iklódi
                Svensson Järndahl Erixon Aallosvaara Kristersson Borgholm Fiskarholm Rappe Glansberg Snaberg Holmberg Hallonbacka Ängstrand Västerskog Kummelberg Danylyuk Azarov Paduan Danielsson Änglamark 
                Gustavsson Bertilsson Denkert Stekvek Makron Svensson Delorean Hoppe Grevo Sigbrandt Lycke Rappe Mulshine Roos Lööf Andersson Quirk Edström Hontjaruk Nobel Egers Ahvenuslampi Alangonmäki 
                Hangasvuori Antesson Svensson Johansson Pettersson Nilsson Nilsdotter Tryggvesson Jonsson Dahlström Karlsson Lunström Wallmo Lantz Peres Florin Kopek Thelberg Petersson Nordström Sandin 
                Runström Backström Bäckström Lindström Hult Hultkvist Lindahl Rundahl Kindberg Nyberg Nyström Nydal Rydberg Denys Ölmunger Lerden Nordal Nordberg Kindahl Malm Modin Norberg Zelenskyj 
                Sjmyhal Misley Barkley Putin Akari Olovsson Olofsson Olofsen Jensen Jepson Jephson Jepsen Jeppesen Porosjenko Gillek Söderberg Ambjörnsson Antonsson Haber Holm Alling Holmberg Hallgren 
                Ben Benben Ragnerstam Jansson Hofling Videgård Eberhart Börjesson Thorell Carlsson Harding Mozard Bash Hayden Ferm Dehn Morgonstråle Dagg Rapace Hallon Hallin Kleerup Steinmaier Preppe 
                Skugge Durström Edwardsson Nordegren Epstein Alling Storskär Arlov Wolf Åström Strömberg Bergström Åberg Ånglok Bergkvist Granat Fisk Fågel Gädda Borre Kryckel Eng Enkel Härnek Forslin 
                Renklint Ekberg Härberg Renberg Nordberg Lindberg Nyberg Makron Veritas Standar Ritter Jäger Sackrisson Labba Isaksson Nilsen Klar Weng Kallbo Månsen Hedman Unemyr Graaf Hedin Hurdin 
                Lagerman Lagerfält Lagerberg Lager Lagersjö Lagerblad Lagerdal Lagersen Lagersten Nelson Panther Tiger Ramone Glam Vikars Grossman Madsen Lagerström Bergsjö Camara Evander Vinblad Vingård 
                Linné Houellebecqs Blomberg To Olsbu Röiseland Dudenbostel Preuss Sola Hinz Reztsova Cranston Sullican Remington Hedvall Knivile Zaphir Rubin Diamant Krutov Rastapopulus Myllymäki Ångstrom 
                Hell Black Vokovera Tusen Granat Morgoth Moria Moldor Toth Thyk Kanker Totenkoph Quasar Sinclair Pemberton Arkwright Sundholm Mumin Åker Åkerberg Åkerbacka Åkerbacke Åkerskog Åkerman 
                Åkervarg Åkerkvist Åkerquist Åkergård Åkerfält Åkerstam Åkerström Åkersjö Åkerguld Åkerek Åkersköld Biden Korell Jemtoff Silver Silverberg Silverbacka Silverbacke Silverkog Silverman 
                Silvervarg Silverkvist SilverQuist Silvergård Silverfält Silverstam Silverström Silversjö Silverek Silversköld Öberg Öbacka Öman Ökvist Öquist Ögård Öfält Östam Öström Silverö Öholm Noren 
                Fury Alabaster Quisling Kisinger Quark Kefi Nonjer Kleffner Makron Ouch Boxbon Beard Hicks Flowers Rosen Rosenberg Rosenbacka Rosenbacke Rosenskog Rosenvarg Rosenkvist Rosenquist Rosengård 
                Moon Rosenfält Rosenstam Rosenström Rosensjö Rosenguld Rosensköld Doyle Davenport McCullough Hooper Dior Punk Platina Rasputin Ek Ekberg Ekbacka Ekbacke Ekskog Ekenskog Ekman Ekenvarg 
                Ekenkvist Ekenquist Ekengård Ekenfält Ekenstam Ekström Ekenksjö Ekensköld Mackaron Mictlantecuhtli Barton George Bernard Riley Harmon Hood Richmond Dye Rasmussen Strong Fletcher Rowland 
                Cooper Sheehan Gray Gry Couch Simon McClain Carr Casey Melton ONeil Sellers Hartley Costa Noble Sexton Driscoll Ritter Wyatt Hök Dufva Kråk Sprängare Dentika Eskerson Lundström Ågren Hedman 
                Cederström Abakumov Abdulov Abramov Agapov Agafonov Alexeyev Andreyev Antonov Arsenyev Artyomov Alekseev Angeloff Mabuse Pälsänger Norin Wagner Stuka Frigid Gotic Bering Bertling
                Arkhangelsky Aslanov Andreev Belyaev Belov Babanin Balabanov Balakin Paludan Balakirev Balandin Baranov Barinov Belsky Babin Bocharov Borisyuk Borovkov Borodin Bortnik Bortsov Berlin
                Bugrov Bychkov Chaban Chernoff Chugunov Davydov Dmitriev Devin Dobrow Dominik Drozdov Uggla Igelkotte Martin Egorov Elin Evanoff Fedorov Gorky Gorbachev Gusev Galkin Garin Genrich
                Gurin Golubev Snygg Ibragimov Ilyin Ivanov Kuznetsov Kalashnik Kozlov Kamenev Komarov Kotov Kiselyov Kravtsov Kovalyov Krupin Kuzmin Glad Svart Stare Marin Lagunov Lebedev Lenkov
                Medvedev Morozov Mikhailov Meknikov Molchalin Molotov Nikolaev Novikov Nikitin Westwood Orlov Pasternak Petrov Pavlov Petukhov Jordan Plotnikov Popov Poletov Portnov Rabinovich Rogov
                Rybakov Smirnov Sidorov Mondrian Sokolov Semyonov Stepanov Ocean Triton Biden Eros Sorpresini Solina Tortilone Krishna Jacobs Hansen Dow Jones Pollak Nato Washington Katsanidou 
                Oberg Graneloni Hodges Rossi Rosso Marciano Fabiano Sebastiano Cappellari Lanaro Cestaro Fucilla Scarlo Sbarbaro Soru Nieddu Madu Biondi Quattrochi Cicala Volpe Colletta Checati
                Cecati Alessandrini Alessandro Albino Accomoando Achille Abromo Albertini Albertelli Alfonso Alu Agresti Agosto Aquila Antonino Amorosi Capozzi Canal Campolo Polo Lotus Messel Broman
                Müller Schmidt Schneider Fischer Weber Schäfer Meyer Wagner Becker Bauer Hoffmann Schulz Koch Richter Klein Wolf Schröder Neumann Braun Werner Schwarz Zimmermann Schmitt Hartmann Schmid
                Weiß Krüger Lange Meier Walter Köhler Maier Beck König Krause Schulze Huber Mayer Frank Lehmann Kaiser Fuchs Herrmann Peters Stein Jung Möller Berger Martin Friedrich Scholz Keller
                Groß Hahn Roth Günther Vogel Schubert Winkler Schuster Lorenz Ludwig Baumann Heinrich Otto Simon Graf Kraus Krämer Böhm Schulte Albrecht Franke Winter Schumacher Vogt Haas Sommer Schreiber
                Engel Ziegler Dietrich Brandt Seidel Kuhn Busch Horn Arnold Kühn Bergmann Pohl Pfeiffer Wolf Voigt Sauer Granström Arbsjö Björklund Sydov Fortenbach Katamadze Bonde Bondesson Is Engelbrekt
                Kerro Weibel Nielsen Refs Lockney Krämer Pin Tao Hüttner Pellikaan Baker Cooper Butcher)
    20.times{ names << RandomName.random_string.capitalize }
    15.times{ names << RandomName.bem.capitalize }
#    puts names.sort.inspect
    
    return names.sample + '-' + names.sample if rand(100) < 10
    return names.sample + ' ' + names.sample if rand(100) < 10
    return names.sample
    
  end 
  
  def RandomName.planet
    prefix = %w(Alpha Beta Gamma Delta Epsilon Zeta Eta Theta Iota Karysppa Lambda Mu Nu Xi Omicron Pi Rho Sigma Tau Ypsilon Phi Chi Psi Omega Ultima Förenade Old Nya New Lilla Stora Major 
                Närmre Prime Primordial Popular Galactus Central Minor Bortre Gamla Old Gröna Lugna Vackra Cleansed Ryska Major Stängda Fina Andra)
    names1 = %w(Proxima Alpha Beta Omega Pi Zetz Phi Dolgor Dark Trie Klitschko Bortre Tellus Mars Furry Minor Zeta Seminol Rapid Frigida Aqua Central Venusia Kryo Isolerade Nosferatu Bitter 
                Alepha Moria Big Lilla Alfa Sinister Förenade Modulo Caret Prime Tensor Nord Syd Samlade Giganto Venuso Lleron Chappero Uima Gnupke Torra Aether Alastor Apollo Ares 
                Atlas Caerus Castor Chaos Charon Karon Kronos Crion Deimos Dionysus Erebus Eros Ero Hades Heracles Herkules Hermes Hesperus Hypnos Kratos Morpheus Moros Nereus Not Notus 
                Ocean Oceanus Onegiri Paean Pan Plutus Pollus Poseidon Priapus Tartarus Triton Typhon Uran Zelus Zephyr Krak Kraken Betelguese Biden Ero Hill Shub Niggurath Shudde M'ell 
                Tsathogghua Yog Sotthoth Azathoth Cthugha Hastur Thoth Anubis Isis Ra Seth Aapep Amam Sekhmet Zeus Zues Suez Kronos Poseidon Polis Flisk Hades Triton Trion Titan Gigant 
                Hecate Typhon Tyfon Loke Oden Tor Trym Surtur Fenris Yama Shiva Rudra Garuda Hari-hara Ratri Ahriman Roman Hefaistos Finland Korea Sverige Amerika Kanada Brittania China
                Tokyo Norge Noreg Krishna Ixchel Coyote Malsum Glooskap Nimrod Nemesis Baal Salomo Morfeus Erlik Arawn Louhi Loviatar Touni Hunter Merkuri Ceres Aten Apollo Artemis Ares 
                Hermes Demeter Hades Hekate Pan Abaris Kabirer Abas Kadmos Acamas Kakia Achanta Kalkas Kalliope Achelous Kalypso Acis Karon Charon Caron Oden Wotan Colombo Conakry Acheron 
                Acteon Kassandra Adamanthea Kasiopeja Admetos Ker Aeacus Keraon Matton Aega Kererna Aegeus Ceto Aegina Clio Klotes Aegyptus Knossos Aeneas Koios Aero Persefone Aeter Koros 
                Aethra Kratesis Kreon Agamedes Krios Agamemnon Kronos Kron Agave Ladon Laios Aglaia Aion Leda Ajax Akilles Hyra Letho Alastor Albion Brazil Alcippe Lipse Algos Algea Lybia 
                Lykomedes Lykos Amalthea Amor Psyche Medusa Ananke Melpomene Memnon Anchises Meneleos Merope Metid Midas Antigone Minos Antiope Apollon Morfeus Arachne Moros Ares Myrmex 
                Najad Argos Narcissus Nausikaa Nestor Niobe Atlas Nyx Nox Odysseus Boreas Brimo Orfeus Orion Palamedes Charon Karon Pallas Peleus Daidalos Damakles Deimos Delfi Demeter Pluton 
                Pollux Dike Diomedes Dionysos Pontos Dois Dryad Echo Echidna Elektra Prometheus Proteus Pygmalion Pyramus Pyrrah Eos Pytia Python Epione Rhea Erebos Salamis Erigone Eir 
                Saurus Sauron Eros Selene Europa Euros Sinope Siren Sisyfos Skylla Smyrna Sparta Steno Styx Forkys Syrinx Frixos Fryxos Gaia Tartaros Galatea Ganymedes Telamon Geras Telamos 
                Gordios Gordon Teles Gripar Gyges Hades Tethys Halia Thalia Harmonia Harpya Thanatos Theia Hebe Hefaistos Theseus Hektor Helena Thisbe Helia Helios Tsifone Helle Titania 
                Hellen Titius Hemera Triton Hemerea Hera Tyche Herakles Tyfon Urania Hermes Uranos Hermione Volupta Hero Leander Xantippa Herse Zenia Xena Hesperos Zefyros Hestia Hippokarne 
                Hippokamp Hippos Hippolyte Horkos Hosia Hyander Hydra Hygieja Hyllos Hyperion Hypnos Iapetus Daktyl Idomeneus Ikaros Inakos Oile Io Lokaste Iris Irun Ithaka Ixion Saab 
                IBM Polis Abba Eneri Russia Danske Intel Enigma Smoldering Utopian Utopiska Rykande Dusk Kaos Kronans Perfekta Perfected Prime Electric Förvisade Banished Gårdagens Yester
                Deimon Demon Morgondagens Savage Infernal Supreme Enlightened Upplysta Bitter Brända Burned Wicked Cursed Förbannade Järn Iron Sopa Ping)
    30.times{ names1 << RandomName.last.capitalize}
    30.times{ names1 << RandomName.random_string.capitalize}
    20.times{ names1 << RandomName.stad}
    names1.concat GIRLS
    20.times{ names1 << RandomName.bem.capitalize}
    
    name = names1.sample
    name = prefix.sample + ' ' + name if rand(100) < 30
    extra = rand(4)-2
    if extra > 0
      extra.times do
        name << ' ' + names1.sample
      end
    end
    name << ' ' + ( rand(9) + 1 ).to_s if rand(100) < 75
    if rand(100) < 11
      name = 'Nya ' + name
    elsif rand(100) < 5
      name = 'Gamla ' + name
    end
    if name.split.size < 2
      name << ' ' + names1.sample
    end
    return name
  end
  
  def RandomName.random_string
    c = %w( b c d f g h j k l m n p qu r s t v w x z ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr xi ar dr)
    v = %w( a e i o u y ai ie ü ei ae)
    f, r = true, ''
    (rand(5)+2).times do
      r << ( f ? c[ rand * c.size ] : v[ rand * v.size ] )
      f = !f
    end
    return r
  end
  
  # Inte från en ursprunglig tabell, utan där det bara står stad
  def RandomName.stad
    prefix = %w(Nya Gamla Västra Östra Norra Södra Övre Bortre Lilla Centrala)
    names = %w(Oslo Göteborg Stockholm York London Åmål Perstorp Malmö Köpenhamn Berlin Moskva Paris Lyon Johanesburg Umeå Jönköping Bern Falköping Manilla Nanjing Tehran Monterrey Shenzhen Tokyo 
               Kyoto Lahore Makao Dubai Tunis Dallas Lagos Sidney Ankara Baku Jaipur Dhaka Houston Singapore Jeddah Mecka Karachi Being Kyiv Skillingaryd Vladivostok Nairobi Bratislava Paris Oslo 
               Malmö Rabat Macao Madrid Barcelona Lille Bryssel Antwerpen Minsk Borlänge Amsterdam Aten Baku Belgrad Budapest Bukarest Dublin Helsingfors Lissabon Ljubljana Nicosia Prag Reykjavik 
               Riga Rom Sofia Tallin Tbilisi Tirana Vaduz Valletta Warszawa Wien Uddevalla Teheran Miami Edinburgh Bergen Turin Shanghai Alger Amman Amsterdam Haag Bagdad Linköping Bangkok Beirut
               Bogotá Brasília Canberra Caracas Dakar Damaskus Djibouti Freetown Hanoi Havanna Jerusalem Kabul Kairo Katmandu Manila Nairobi Nuuk Peking Port-au-Prince Rabat Taipei Washington
               Wellington Zagreb Kapetown Milano)
    names.concat ['New York','Los Angeles','Hong Kong','San Diego','Mexiko City','Sankt Petersburg','Andorra la Vella','Monte Carlo','Abu Dhabi','Buenos Aires','Kuala Lumpur']
    name = names.sample
    name = prefix.sample + ' ' + name if rand(100) < 15
    return name
  end
  
  def RandomName.bem(suggestions=nil)
    if suggestions.present?
      return suggestions.sample.capitalize if rand(100) < 5
      return RandomName.bem + ' ' + suggestions.sample.capitalize if rand(100) < 15
      return suggestions.sample.capitalize + ' ' + RandomName.bem if rand(100) < 15
    end
    return RandomName.random_string.split(" ").each {|word| word.capitalize!}.join(" ") if rand(100) < 25
    # Glob
    if rand(100) < 20
      c = %w( b d l bl gl g m n ng mn)
      v = %w( oo ao o u oe a aa )
    elsif rand(100) < 20
      c = %w( kl tl t k pl rk kr q r x xi c z )
      v = %w( u y e ie ei i)
    elsif rand(100) < 10
      c = %w( blog lo dl g gl l ng bl blob b)
      v = %w( oo o u oe a å ö )
    elsif rand(100) < 10
      c = %w( peki pike p k kp pk ps ks)
      v = %w( ee ii e i ie ie )
    else
      c = %w( b c d f g h j k l m n p qu r s t v w x z ch kr fr nd ng nk nt ph pr rd sh sl sp st th tr xi ar dr sch ch sj)
      v = %w( a e i o u y ai ie ü ei ae)
    end
    f, r = true, ['','','','','',(RandomName.bem(suggestions)+' '),].sample # Möjligheten att få två namn
    (rand(6)+1).times do
      r << ( f ? c[ rand * c.size ] : v[ rand * v.size ] )
      f = !f
    end
    latin = (rand(100)<999) ? ['ina','us','inus','ius','alis','alius','ax','axus','us','iens','iens','us'].sample : ''
    r = r+'s' if !r.end_with?('s', 'x','c','z') && rand(100)<65
    r = r.split(" ").each {|word| word.capitalize!}.join(" ")
    prefixes = %w(Mega Nya Äldre Stora Black Red Mindre Homo Större Kloka Vice Första Ursprungliga Närmre Bortre Äldre Yngre Sista Lupus Catus Felis Camelus Castor)
    return (prefixes.sample + ' ' + r.capitalize+latin).split(" ").each {|word| word.capitalize!}.join(" ") if rand(100) < 15
    return (r.capitalize+latin).split(" ").each {|word| word.capitalize!}.join(" ")
  end
  
end