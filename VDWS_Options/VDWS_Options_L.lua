-- some variables --
VDW.VDWS.Local = VDW.VDWS.Local or (function()
	local base = {
		TIP_CLOSE_PANEL = "Close this panel!",
-- tab --
		T_TIP = "Options for %s",
-- panel --
-- box --
-- widget --
		W_STYLE = "Style",
		W_VISIBILITY = "Visibility",
		W_COLOR = "Color",
		W_CHECKBOX_TIP = "Check me! if you want the %s to be shown",
		W_S_TIP = "What kind of style do you want the %s to be?",
		W_C_TIP = "What color do you want the %s to be?",
		W_SLIDER_TIP = "You can also use the mouse wheel or the edge buttons to change the value.",
		W_ATTACH_TIP = "Check me! if you want to %s",
-- profiles --
		P_TAB = "Profiles",
		P_TITLE = "Create, Load, Delete Profiles!",
		P_SUB_CREATE = "Create Profiles",
		P_SUB_LOAD = "Load Profiles",
		P_SUB_DELETE = "Delete Profiles",
		P_TIP_CREATE = "Enter a profile name in the edit box and press Enter to save your settings/options.",
		P_TIP_LOAD = "Select a profile to load.",
		P_TIP_DELETE = "Select a profile to delete.",
		P_WRN_NEED = "Please enter a profile name.",
		P_WRN_EXIST = "This profile already exists. Please try another name.",
		P_WRN_LOAD = "There are no profiles to load.",
		P_WRN_DELETE = "There are no profiles to delete.",
	}
	local o = {
		frFR = {
			TIP_CLOSE_PANEL = "Fermer ce panneau !",
-- tab --
			T_TIP = "Options pour %s",
-- panel --
-- box --
-- widget --
			W_STYLE = "Style",
			W_VISIBILITY = "Visibilité",
			W_COLOR = "Couleur",
			W_CHECKBOX_TIP = "Cochez-moi si vous voulez afficher %s",
			W_S_TIP = "Quel style voulez-vous pour %s ?",
			W_C_TIP = "Quelle couleur voulez-vous pour %s ?",
			W_SLIDER_TIP = "Vous pouvez aussi utiliser la molette de la souris ou les boutons sur les bords pour changer la valeur.",
			W_ATTACH_TIP = "Cochez-moi si vous voulez %s",
-- profiles --
			P_TAB = "Profils",
			P_TITLE = "Créer, charger, supprimer des profils !",
			P_SUB_CREATE = "Créer un profil",
			P_SUB_LOAD = "Charger des profils",
			P_SUB_DELETE = "Supprimer des profils",
			P_TIP_CREATE = "Saisissez un nom de profil dans le champ de texte et appuyez sur Entrée pour sauvegarder vos réglages/options.",
			P_TIP_LOAD = "Sélectionnez un profil à charger.",
			P_TIP_DELETE = "Sélectionnez un profil à supprimer.",
			P_WRN_EXIST = "Ce profil existe déjà. Essayez un autre nom.",
			P_WRN_NEED = "Entrez un nom de profil.",
			P_WRN_LOAD = "Aucun profil à charger.",
			P_WRN_DELETE = "Aucun profil à supprimer.",
		},
		deDE = {
			TIP_CLOSE_PANEL = "Dieses Panel schließen!",
-- tab --
			T_TIP = "Optionen für %s",
-- panel --
-- box --
-- widget --
			W_STYLE = "Stil",
			W_VISIBILITY = "Sichtbarkeit",
			W_COLOR = "Farbe",
			W_CHECKBOX_TIP = "Hake mich an, wenn du möchtest, dass %s angezeigt wird",
			W_S_TIP = "Welchen Stil möchtest du für %s?",
			W_C_TIP = "Welche Farbe möchtest du für %s?",
			W_SLIDER_TIP = "Du kannst auch das Mausrad oder die Randtasten verwenden, um den Wert zu ändern.",
			W_ATTACH_TIP = "Hake mich an, wenn du %s möchtest",
-- profiles --
			P_TAB = "Profile",
			P_TITLE = "Profile erstellen, laden, löschen!",
			P_SUB_CREATE = "Profil erstellen",
			P_SUB_LOAD = "Profile laden",
			P_SUB_DELETE = "Profile löschen",
			P_TIP_CREATE = "Gib einen Profilnamen in das Eingabefeld ein und drücke Enter, um deine Einstellungen/Optionen zu speichern.",
			P_TIP_LOAD = "Profil zum Laden auswählen.",
			P_TIP_DELETE = "Profil zum Löschen auswählen.",
			P_WRN_EXIST = "Dieses Profil existiert bereits. Bitte einen anderen Namen wählen.",
			P_WRN_NEED = "Bitte einen Profilnamen eingeben.",
			P_WRN_LOAD = "Keine Profile zum Laden.",
			P_WRN_DELETE = "Keine Profile zum Löschen.",
		},
		esES = {
			TIP_CLOSE_PANEL = "Cerrar este panel!",
-- tab --
			T_TIP = "Opciones para %s",
-- panels --
-- box --
-- widget --
			W_STYLE = "Estilo",
			W_VISIBILITY = "Visibilidad",
			W_COLOR = "Color",
			W_CHECKBOX_TIP = "Márcame si quieres que se muestre %s",
			W_S_TIP = "¿Qué estilo quieres para %s?",
			W_C_TIP = "¿Qué color quieres para %s?",
			W_SLIDER_TIP = "También puedes usar la rueda del ratón o los botones del borde para cambiar el valor.",
			W_ATTACH_TIP = "Márcame si quieres %s",
-- profiles --
			P_TAB = "Perfiles",
			P_TITLE = "¡Crear, cargar y eliminar perfiles!",
			P_SUB_CREATE = "Crear perfil",
			P_SUB_LOAD = "Cargar perfiles",
			P_SUB_DELETE = "Eliminar perfiles",
			P_TIP_CREATE = "Escribe un nombre de perfil en el cuadro de texto y pulsa Intro para guardar tu configuración/opciones.",
			P_TIP_LOAD = "Selecciona un perfil para cargar.",
			P_TIP_DELETE = "Selecciona un perfil para eliminar.",
			P_WRN_EXIST = "Este perfil ya existe. Prueba con otro nombre.",
			P_WRN_NEED = "Introduce un nombre de perfil.",
			P_WRN_LOAD = "No hay perfiles para cargar.",
			P_WRN_DELETE = "No hay perfiles para eliminar.",
		},
		esMX = {
			TIP_CLOSE_PANEL = "Cerrar este panel!",
-- tab --
			T_TIP = "Opciones para %s",
-- panel --
-- box --
-- widget --
			W_STYLE = "Estilo",
			W_VISIBILITY = "Visibilidad",
			W_COLOR = "Color",
			W_CHECKBOX_TIP = "Márcame si quieres que se muestre %s",
			W_S_TIP = "¿Qué estilo quieres para %s?",
			W_C_TIP = "¿Qué color quieres para %s?",
			W_SLIDER_TIP = "También puedes usar la rueda del ratón o los botones del borde para cambiar el valor.",
			W_ATTACH_TIP = "Márcame si quieres %s",
-- profiles --
			P_TAB = "Perfiles",
			P_TITLE = "¡Crear, cargar y eliminar perfiles!",
			P_SUB_CREATE = "Crear perfil",
			P_SUB_LOAD = "Cargar perfiles",
			P_SUB_DELETE = "Eliminar perfiles",
			P_TIP_CREATE = "Escribe un nombre de perfil en el cuadro de texto y pulsa Intro para guardar tu configuración/opciones.",
			P_TIP_LOAD = "Selecciona un perfil para cargar.",
			P_TIP_DELETE = "Selecciona un perfil para eliminar.",
			P_WRN_EXIST = "Este perfil ya existe. Prueba con otro nombre.",
			P_WRN_NEED = "Introduce un nombre de perfil.",
			P_WRN_LOAD = "No hay perfiles para cargar.",
			P_WRN_DELETE = "No hay perfiles para eliminar.",
		},
		ptBR = {
			TIP_CLOSE_PANEL = "Fechar este painel!",
-- tab --
			T_TIP = "Opções para %s",
-- panel --
-- box --
-- widget --
			W_STYLE = "Estilo",
			W_VISIBILITY = "Visibilidade",
			W_COLOR = "Cor",
			W_CHECKBOX_TIP = "Marque-me se você quiser que %s seja exibido",
			W_S_TIP = "Que estilo você quer para %s?",
			W_C_TIP = "Que cor você quer para %s?",
			W_SLIDER_TIP = "Você também pode usar a roda do mouse ou os botões da borda para alterar o valor.",
			W_ATTACH_TIP = "Marque-me se você quiser %s",
-- profiles --
			P_TAB = "Perfis",
			P_TITLE = "Criar, carregar e excluir perfis!",
			P_SUB_CREATE = "Criar perfil",
			P_SUB_LOAD = "Carregar perfis",
			P_SUB_DELETE = "Excluir perfis",
			P_TIP_CREATE = "Digite um nome de perfil na caixa de texto e pressione Enter para salvar suas configurações/opções.",
			P_TIP_LOAD = "Selecione um perfil para carregar.",
			P_TIP_DELETE = "Selecione um perfil para excluir.",
			P_WRN_EXIST = "Este perfil já existe. Tente outro nome.",
			P_WRN_NEED = "Digite um nome de perfil.",
			P_WRN_LOAD = "Não há perfis para carregar.",
			P_WRN_DELETE = "Não há perfis para excluir.",
		},
		itIT = {
			TIP_CLOSE_PANEL = "Chiudi questo pannello!",
-- tab --
			T_TIP = "Opzioni per %s",
-- panel --
-- box --
-- widget --
			W_STYLE = "Stile",
			W_VISIBILITY = "Visibilità",
			W_COLOR = "Colore",
			W_CHECKBOX_TIP = "Spuntami se vuoi che %s venga mostrato",
			W_S_TIP = "Che stile vuoi per %s?",
			W_C_TIP = "Che colore vuoi per %s?",
			W_SLIDER_TIP = "Puoi anche usare la rotellina del mouse o i pulsanti sul bordo per cambiare il valore.",
			W_ATTACH_TIP = "Aggancia alla barra di lancio",
-- profiles --
			P_TAB = "Profili",
			P_TITLE = "Crea, carica ed elimina profili!",
			P_SUB_CREATE = "Crea profilo",
			P_SUB_LOAD = "Caricare profili",
			P_SUB_DELETE = "Eliminare profili",
			P_TIP_CREATE = "Inserisci un nome profilo nella casella di testo e premi Invio per salvare impostazioni/opzioni.",
			P_TIP_LOAD     = "Seleziona un profilo da caricare.",
			P_TIP_DELETE   = "Seleziona un profilo da eliminare.",
			P_WRN_EXIST = "Questo profilo esiste già. Prova un altro nome.",
			P_WRN_NEED = "Inserisci un nome per il profilo.",
			P_WRN_LOAD = "Nessun profilo da caricare.",
			P_WRN_DELETE = "Nessun profilo da eliminare.",
		},
		ruRU = base,
		zhCN = base,
		zhTW = base,
		koKR = base,
	}
	local loc = GetLocale()
	local ov = o[loc]
	if type(ov) == "string" then ov = o[ov] end
	if ov then
		for k, v in pairs(ov) do base[k] = v end
	end
	return base
end)()
