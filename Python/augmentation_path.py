def augmentation_path():
    import sys
    L=['C:\\Program Files\\PyScripter\\Lib\\rpyc.zip',
     'C:\\Python27\\lib\\site-packages\\six-1.7.3-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\requests_oauthlib-0.4.1-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\requests-2.4.3-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\oauthlib-0.7.2-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\pip-1.4-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\oauth2-1.5.211-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\simplejson-3.6.5-py2.7.egg',
     'C:\\Python27\\lib\\site-packages\\httplib2-0.9-py2.7.egg',
     'C:\\Windows\\SYSTEM32\\python27.zip',
     'C:\\Python27\\DLLs',
     'C:\\Python27\\lib',
     'C:\\Python27\\lib\\plat-win',
     'C:\\Python27\\lib\\lib-tk',
     'C:\\Python27',
     'C:\\Python27\\lib\\site-packages',
     'c:\\python27\\lib\\site-packages']

    for element in L:
        sys.path.append(element)