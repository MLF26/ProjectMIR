#!/usr /bin/env python
# -*- coding=utf8 -*-

def python_timeline(user):
    import augmentation_path
    augmentation_path.augmentation_path()
    import tweepy

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

    timeline = api.user_timeline(screen_name=user, include_rts=True, count=100)
    for tweet in timeline:
        print ("Text:", tweet.text)
        print ("Created:", tweet.created_at)

python_timeline("olabayle")