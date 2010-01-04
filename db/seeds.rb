User.create(
  :email => 'fdlambert@gmail.com', :password => 'mdpemail0', :password_confirmation => 'azerty',
  :first_name => 'Frédéric', :last_name => 'de Lambert'
)

User.create(
  :email => 'slimanihamza@gmail.com', :password => 'mdpemail', :password_confirmation => 'mdpemail',
  :first_name => 'Hamza', :last_name => 'Slimani'
)

user = User.create(
  :email => 'julien.biard@gmail.com', :password => 'bombastic', :password_confirmation => 'bombastic',
  :first_name => 'Julien', :last_name => 'Biard'
)

RULES =<<HTML
	<h2>Règlement du Jeu Concours</h2>

	<h4>ARTICLE 1 : DESCRIPTION DU JEU CONCOURS</h4>
	<p>
		Ce jeu concours est organisé par la société Emailing Management, au domicile Emailing Management, 39 avenue Lalla Yacout, 5ème ETG APPT D, 20000 Casablanca (Maroc).<br>
		Ce jeu concours est gratuit et sans obligation d’achat, et est ouvert à toute personne qui le reçoit ou y accède via d’autres membres, collaborateurs ou partenaires commerciaux.
	</p>

	<h4>ARTICLE 2 : CONDITIONS DE PARTICIPATION </h4>
	<p>
		<strong>2.1</strong> - La participation au présent jeu est gratuite.
	</p>
	<p>
		<strong>2.2</strong> - Ce jeu est accessible uniquement à toute personne physique majeure (plus de 18 ans) et résidant au Maroc.
	</p>
	<p>
		<strong>2.3</strong> - Ne seront pas admis à participer à ce jeu concours: membres du personnel de la société organisatrice, associés, fournisseurs d’Emailing Management.
	</p>

	<h4>ARTICLE 3 : LES ENTREPRISES PARTENAIRES</h4>
	<p>
		<strong>3.1</strong> - Il n’est pas obligatoire d’accepter les offres des entreprises partenaires pour participer au Jeu Concours.
	</p>
	<p>
		<strong>3.2</strong> - En choisissant l’option « Oui » dans un ou plusieurs cas des entreprises partenaires proposées para l’entreprise Emailing Management, vous autorisez à ce que vos données personnelles des formulaires précédemment remplis soient propriété des entreprises annonceuses.
	</p>

	<h4>ARTICLE 4 : CONDITIONS TECHNIQUES</h4>
	<p>
		<strong>4.1</strong> - Pour participer à ce jeu, chaque joueur devra s’inscrire sur le site où il devra remplir complètement le formulaire d’inscription en précisant ses coordonnées : nom, prénom et adresse e-mail … <br>
		Toute information personnelle indispensable pour participer au tirage au sort et communiquée par le participant dans le formulaire au moment de son inscription et dont il apparaîtrait qu’elle serait manifestement incohérente et/ou fantaisiste, ne sera pas prise en compte et entraînera la nullité de la participation dudit participant. <br>
		La participation au jeu est limitée à une inscription par personne et par e-mail.
	</p>
	<p>
		<strong>4.2</strong> - Le participant a la possibilité d’inviter par e-mail toutes les personnes de son choix. Chaque invité du participant recevra un email d’invitation, qui lui permettant de souscrire au jeu. Chaque invité inscrit au jeu via cet email et dont l’email est valide, permettra au participant d’obtenir une chance supplémentaire d’être tiré au sort. Le participant s’engage à avoir obtenu l’accord de ses « invités », titulaires des adresses email qu’il fournit à la société organisatrice.
	</p>
	<p>
		<strong>4.3</strong> - Toute personne qui ne remplirait pas sérieusement tous les champs demandés sera exclue du dit Jeu Concours. 
	</p>
	<p>
		Pour jouer, il suffit aux participants de remplir le(s) formulaire(s) demandés et de le(s) valider via le réseau Internet en cliquant sur le bouton prévu à cet effet, cela avant la date de fin de jeu. <br>
		Tous les participants qui auront rempli correctement tous les champs requis feront partie de la base de données qui permet de gagner le(s) prix
	</p>

	<h4>ARTICLE 5 : DURÉE DU JEU CONCOURS / ATTRIBUTION DES LOTS</h4>
	<p>
		<strong>5.1</strong> - Seront prises en compte toutes les participations reçues entre le 01 Septembre 2009 et le 31 Mars 2010 (inclusive)
	</p>
	<p>
		<strong>5.2</strong> - Le tirage au sort aura lieu le 13 Avril 2010 en présence d’un notaire.
	</p>
	<p>
		<strong>5.3</strong> - Les gagnants recevront un avis de gain par courrier électronique, à l’adresse informatique qu’ils auront indiquée dans le bulletin d’inscription, dans le mois suivant le jour du tirage au sort. Avant la remise du lot, le gagnant devra justifier de son identité. <br>
		Par ailleurs, Emailing Management ne pourra être en aucun cas tenu responsable en cas d’erreur ou de non distribution d’un avis de gain par courrier électronique résultant du fait des fournisseurs d’accès à internet. 
	</p>
	<p>
		<strong>5.4</strong> - Le lot sera envoyé directement aux gagnants à l’adresse postale figurant sur le bulletin d’inscription. Emailing Management ne saurait être tenu pour responsable de toute avarie, vol et perte intervenu lors de la livraison. Enfin, Emailing Management décline toute responsabilité en cas d’incident qui pourrait survenir à l’occasion de l’utilisation ou de la jouissance du lot gagné. <br>
		Le lot non réclamé, distribué ou retourné dans les 30 jours calendaires suivant l’envoi du gain sera alors déclaré comme perdu et ne sera pas remis en jeu.
	</p>

	<h4>ARTICLE 6 : DOTATIONS</h4>
	<p>
		<strong>6.1</strong> - Deux prix sont tirés au sort :
	</p>
	<p>
		<strong>Premier prix : </strong>Un week end pour 2 personnes à Paris ou Rome dans un Hotel 5 étoiles. Le gagnant pourra choisir l’hôtel, les vols et les  dates de son choix à condition que le prix total du lot gagné ne dépasse les 8.000 DH (800 euros) TTC. (les dates devront être communiquées au minimum 1 mois avant la date de départ). Le gagnant devra consommer son prix avant le 31 Décembre 2010.
	</p>
	<p>
		<strong>Deuxième prix :</strong> Deux ordinateurs MACBOOK (livraison non incluse)
	</p>
	<p>
		<strong>6.2</strong> - Un gagnant sera choisi pour le premier prix et deux gagnants pour le deuxième prix
	</p>
	<p>
		<strong>6.3</strong> - Les lots ne pourront donner lieu à aucune contestation, ni à la remise de leur contre-valeur en numéraire, ni à leur échange ou remplacement (il est entendu toutefois que la Société organisatrice se réserve la possibilité de substituer à tout moment aux lots proposés, d’autres lots d’une valeur équivalente).<br>
		Emailing Management se réserve le droit de remplacer un prix gagné par un prix de valeur équivalente ou supérieure, notamment sans que cela ne soit exhaustif, en cas de rupture de stock des lots initialement prévus ou de toute autre évènement imprévisible, irrésistible et extérieur qui rendrait impossible la délivrance des lots prévus dans des délais raisonnables. En aucun cas les gagnants ne pourront demander une contrepartie financière. Toutes les marques ou noms de produits cités sont des marques déposées par leurs propriétaires respectifs. 
	</p>
	<p>
		<strong>6.4</strong> - Les gagnants autorisent d’ores et déjà Emailing Management, dans le cadre d’une communication sur les résultats du jeu, à utiliser leurs nom et prénom, sur quelque support que ce soit, sans que cela leur confère droit à une rémunération, indemnisation ou un quelconque avantage autre que l’attribution de leur prix.
	</p>

	<h4>ARTICLE 7 : LIMITATION DES RESPONSABILITES</h4>
	<p>
		<strong>7.1</strong> - Emailing Management dégage toute responsabilité en cas de dysfonctionnement du réseau internet empêchant l’accès au site du jeu ou le bon déroulement du jeu. 
	</p>
	<p>
		<strong>7.2</strong> - Emailing Management se réserve le droit si des circonstances l’exigeaient, d’écourter, de prolonger, de modifier ou d'annuler le présent jeu, sans que sa responsabilité puisse être engagée par ce fait.<br>
		Toute modification des termes et conditions du présent jeu, sa suspension ou annulation seront communiquées aux participants par les mêmes moyens que ceux utilisés pour la promotion du jeu. 
	</p>

	<h4>ARTICLE 8 : FRAUDE</h4>
	<p>
		<strong>8.1</strong> - La participation à ce jeu implique l’acceptation pleine et entière du présent règlement dans son intégralité. Toute déclaration inexacte ou mensongère, toute fraude entraînera la disqualification du participant. Sera notamment considérée comme une fraude, le fait pour un participant de s’inscrire sous un prête-nom fictif ou emprunté à une personne tierce, chaque personne devant s’inscrire sous son propre et unique nom. 
	</p>
	<p>
		<strong>8.2</strong> - Il ne sera répondu à aucune demande téléphonique ou écrite concernant l'interprétation ou l'application du présent règlement, les mécanismes ou les modalités du concours ainsi que sur la liste des gagnants. 
	</p>

	<h4>ARTICLE 9 : PRIVACITÉ DES DONNÉES ET ACCEPTATION DU REGLEMENT</h4>
	<p>
		<strong>9.1</strong> - Les informations nominatives recueillies dans le cadre du présent jeu sont traitées conformément à la Loi de protection des données personnelles.
	</p>
	<p>
		<strong>9.2</strong> - Sous réserve de leur consentement explicite ou, selon les cas, à défaut d'opposition de leur part, les informations collectées sur les participants pourront être utilisées par et/ou ses partenaires afin de les informer de leurs nouveautés et offres susceptibles de les intéresser.
	</p>
	<p>
		<strong>9.3</strong> - Chaque participant dispose d’un droit d’accès, de rectification ou de radiation des informations nominatives le concernant, qu’il peut exercer à l’adresse du jeu auprès de la société Emailing Management . Par les présentes, les participants sont informés que lors de leur inscription, leur accord est demandé quant à la possibilité de transmettre leurs données nominatives à des partenaires commerciaux d’Emailing Management. 
	</p>
	<p>
		<strong>9.4</strong> - En acceptant de participer au Jeu Concours, les candidats acceptent intégralement les conditions générales du règlement du Jeu Concours (exposées ci-dessus) d’Emailing Management.
	</p>

	<h4>ARTICLE 10 : JURIDICTION </h4>
	<p>
		Le règlement est exclusivement régi par la loi marocaine. Toute question d’application ou d’interprétation du Règlement, ou toute question imprévue qui viendrait à se poser, sera tranchée souverainement, selon la nature de la question, par Emailing Management, dans le respect de la législation marocaine. Les contestations ne seront recevables que dans un délai d’une semaine après la clôture du tirage au sort.
	</p>

	<p>
		Règlement valide du 01 Septembre 2009 au 31 mars 2010.
	</p>
HTML

kit = Kit.create(
  :user => user,
  :rules => RULES,
  :default_country => 'MA',
  :lang => 'fr',
  :name => 'ClubVip',
  :title => 'ClubVip',
  :email_bg_color => '#4F78AE',
  :email_links_color => '#FFFFFF',
  :css => File.new("#{RAILS_ROOT}/public/static/stylesheets/kit/style.css"),
  :email1_picture => File.new("#{RAILS_ROOT}/public/static/emailing/img/concours.jpg"),
  :email2_picture => File.new("#{RAILS_ROOT}/public/static/emailing/img/felicitations.jpg"),
  :finished_at => 1.year.since
)

%w(bkg.gif btn_left.png btn_right.png terms.jpg visuel.jpg trefle.png).each do |file|
  CssPicture.create(
    :kit => kit,
    :picture => File.new("#{RAILS_ROOT}/public/static/stylesheets/kit/img/#{file}")
  )
end