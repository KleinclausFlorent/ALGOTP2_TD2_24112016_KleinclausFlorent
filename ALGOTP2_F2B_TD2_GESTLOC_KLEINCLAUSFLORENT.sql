create schema GESTLOC;
create dbspace SP_GESTLOC;

create table SIGNATAIRE ( NUMCLIENT char (12) not null,
										   NOM char (38) not null,
										   PRENOM char (38) not null,
										   DATENAISSANCE date not null,
										   NUMTELEPHONE decimal (10) not null,
										primary key (NUMCLIENT))
										in SP_GESTLOC;

create table COMMUNE ( NOMCOM char (38) not null,
										NBRHABITANT decimal (12) not null,
										DISTANCEAGENCE decimal (5) not null,
									primary key (NOMCOM))
									in SP_GESTLOC;

create table QUARTIER ( NOMQUART char (38) not null,
										NOMCOM char (38) not null,
								primary key (NOMQUART, NOMCOM),
								foreign key (NOMCOM) references COMMUNE
								 on delete no action on update cascade)
								in SP_GESTLOC;

create table LOGEMENT ( ADRESSELOG char (38) not null,
										 SUPERFICIE decimal (10) not null,
										 LOYER decimal (12) not null,
										 TYPELOG char (10) not null,
										 NOMCOM char (38) not null,
										 NOMQUART char (38) not null,
									primary key (ADRESSELOG),
									foreign key (NOMCOM) references COMMUNE
									 on delete no action on update cascade,
									foreign key (NOMQUART) references QUARTIER
									 on delete no action on update cascade)
									IN SP_GESTLOC;
					
create table CONTRAT ( NUMCONTRAT char (12) not null,
									   DATEDEBUT date not null,
									   DATEFIN date not null,
									   NUMCLIENT char (12) not null,
									   ADRESSELOG char (38) not null,
									primary key (NUMCONTRAT),
									foreign key (NUMCLIENT) references SIGNATAIRE
									 on delete no action on update cascade,
									foreign key (ADRESSELOG) references LOGEMENT
									 on delete no action on update cascade)
									IN SP_GESTLOC;
									
create unique index XSIGNATAIRE_NUMCLIENT on SIGNATAIRE(NUMCLIENT);
create unique index XCOMMUNE_NOMCOM on COMMUNE(NOMCOM);
create unique index XQUARTIER_NOMQUART on QUARTIER(NOMQUART);
/*pas le temps*/