#!/usr/bin/python
#-*- coding:utf8 -*-

import re

def epure_texte(chaine):

    #lettre e
    chaine = re.sub("ê", "e", chaine)
    chaine = re.sub("é", "e", chaine)
    chaine = re.sub("è", "e", chaine)
    #lettre a
    chaine = re.sub("à", "a", chaine)
    chaine = re.sub("â", "a", chaine)
    #lettre i
    chaine = re.sub("î", "i", chaine)
    chaine = re.sub("ï", "i", chaine)
    #apostrophe
    chaine = re.sub("m\'","",chaine)
    chaine = re.sub("l\'","",chaine)
    chaine = re.sub("d\'","",chaine)
    chaine = re.sub("c\'","",chaine)
    chaine = re.sub("j\'","",chaine)
    chaine = re.sub("n\'","",chaine)
    chaine = re.sub("qu\'","",chaine)
    chaine = re.sub("s\'","",chaine)
    chaine = re.sub("t\'","",chaine)
    #retour à la ligne
    chaine = re.sub("\n","",chaine)
    print(chaine)
    return chaine

    