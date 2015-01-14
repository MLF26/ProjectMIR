# -*- codint=utf8 -*-

def extraire_tweets(Liste):
    '''Cette fonction permet de r??cup??rer les tweets correspondants aux mots cl??s demand??s'''
    '''Cette fonction prend en argument une liste de mots cl??s'''

    import csv, codecs, tweepy, time
    from datetime import datetime

    tps1=time.clock() #temps au d?but du programme
    yesterday = str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(datetime.now().day-1) #date d'hier pour param?tre du curseur
    today =str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(datetime.now().day) #date actuelle pour parametre curseur et nom fichier
    #Variables that contains the user credentials to access Twitter API
    access_token = "2962470483-rZuoGwuNlbgbkz4Dw6Aw7quaKTW8RqnnrB5iZFw"
    access_token_secret = "4J5YB1VKdagcwT3p0G2ubaWFSB59lxu6XGFtsBuIrPjUU"
    consumer_key = "2E2b3wIvgKYI3m0o0RfVjqehk"
    consumer_secret = "Ru2u7IDLm8WoesorllQPufKILzDhGIFx1CnPRI3iJjIAlItwBl"

    #OAuth process, using keys and tokens
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.secure=True
    auth.set_access_token(access_token, access_token_secret)

    #Creation of the actual interface, using authentification
    api=tweepy.API(auth)

    #R??cup??ration des tweets
    Liste_de_tweets=[]
    Liste_de_tweets.append(["keyword","user.id","user.screen_name", "user.location", "coordinates", "created_at", "geo", "id_str", "in_reply_to_screen_name", "in_reply_to_status_id_str", "in_reply_to_user_id_str", "retweet_count", "retweeted", "source", "source_url", "text", "truncated"])

    #Boucle sur les mots cl??s de recherche
    for mot in Liste:

        #Boucle sur les tweets r??sultats d'une requ??te
        for tweet in tweepy.Cursor(api.search, q=mot, since=yesterday, until=today,lang='fr').items():

            attributs_tweets=[mot]
            attributs_tweets.append(tweet.user.id)
            attributs_tweets.append(tweet.user.screen_name)
            attributs_tweets.append(tweet.user.location)
            attributs_tweets.append(tweet.coordinates)
            attributs_tweets.append(tweet.created_at)
            attributs_tweets.append(tweet.geo)
            attributs_tweets.append(tweet.id_str)
            attributs_tweets.append(tweet.in_reply_to_screen_name)
            attributs_tweets.append(tweet.in_reply_to_status_id)
            attributs_tweets.append(tweet.in_reply_to_user_id)
            attributs_tweets.append(tweet.retweet_count)
            attributs_tweets.append(tweet.retweeted)
            attributs_tweets.append(tweet.source)
            attributs_tweets.append(tweet.text)

            Liste_de_tweets.append(attributs_tweets)
            del attributs_tweets
            time.sleep(0.2) # respect de la fr?quence de l'api
    #On retourne un tableau contenant tous les tweets

    file = open("C:\\Users\\Olivier\\Documents\\Projet_MIR\\Fichier_csv\\" + today + ".csv", "wb")

    try:
        # Cr??ation de l'''??crivain'' CSV.
        writer = csv.writer(file)
        # ??criture de la ligne d'en-t??te avec les titres
        for element in Liste_de_tweets:
            writer.writerow([unicode(s).encode("utf-8") for s in element])
    finally:
        #
        # Fermeture du fichier source
        #
        file.close()
        tps2=time.clock() #temps ? la fin du programme
        print(str(len(Liste_de_tweets)-1) + u" Tweets recuperes en " + str(tps2-tps1) + "secondes")

a=extraire_tweets(["#ps","parti socialiste"])