#!/usr/bin/python
#-*- coding:utf8 -*-

def epure_texte(chaine):

    #lettre e
    chaine = chaine.replace("ê", "e")
    chaine = chaine.replace("é", "e")
    chaine = chaine.replace("è", "e")
    #lettre a
    chaine = chaine.replace("à", "a")
    chaine = chaine.replace("â", "a")
    #lettre i
    chaine = chaine.replace("î", "i")
    chaine = chaine.replace("ï", "i")
    #apostrophe
    chaine = chaine.replace("m\'","")
    chaine = chaine.replace("l\'","")
    chaine = chaine.replace("d\'","")
    chaine = chaine.replace("c\'","")
    chaine = chaine.replace("j\'","")
    chaine = chaine.replace("n\'","")
    chaine = chaine.replace("qu\'","")
    chaine = chaine.replace("s\'","")
    chaine = chaine.replace("t\'","")
    #retour à la ligne
    chaine= chaine.replace("\n","")
    
    return chaine


