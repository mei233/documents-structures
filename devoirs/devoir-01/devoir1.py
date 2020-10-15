#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 10 12:03:59 2020

@author: Mei GAN
"""
from lxml import etree
import pandas as pd


def get_data(CSV_file):
    '''

    Parameters
    ----------
    CSV_file : un fichier CSV

    Returns
    -------
    dicte : une liste de dictionnaire

    '''
    
    df = pd.read_csv(CSV_file, delimiter =";",header=0, names=['type', 'statut',
                                                  'adresse','arrondissement','horaire','acces-pmr','relais-bebe','equipement',
                                                      'geo_shape','geo_point_2d' ]) 

    dicte = df.to_dict(orient="records")
    return dicte

def TYPE(*args): 
    return {"type":' '.join(args)}

def STATUT(*args):
    return {"statut":' '.join(args)}


def generatXML(CSV_file):
    '''
    Parameters
    ----------
    CSV_file : un fichier CSV

    NO Returns
    -------
    en sortie un fichier XML 
    '''
    dicte = get_data(CSV_file)
    racine = "toilettes"
    DTD_file = "wc.dtd"
    root = etree.Element(racine)
    for item in dicte:
        toilette = etree.SubElement(root, "toilette", type=item['type'],statut=str(item['statut']))
        
        adresse = etree.SubElement(toilette, "adresse")
        
        libelle = etree.SubElement(adresse, "libelle")
        libelle.text = str(item['adresse'])
        
        arrondissement = etree.SubElement(adresse, "arrondissement")
        arrondissement.text = str(item['arrondissement'])
        
        horaire = etree.SubElement(toilette, "horaire")
        horaire.text = str(item['horaire'])
        
        services = etree.SubElement(toilette, "services")
        acces_pmr = etree.SubElement(services, "acces-pmr")
        acces_pmr.text = str(item['acces-pmr'])
        relais_bebe = etree.SubElement(services, "relais-bebe")
        relais_bebe.text = str(item['relais-bebe'])
        
        equipement = etree.SubElement(toilette, "equipement")
        equipement.text = str(item['equipement'])
        

        root.append(toilette)
    # print(etree.tostring(root,pretty_print=True))

    tree = etree.ElementTree(root)

    doctype = f'<!DOCTYPE {racine} SYSTEM "{DTD_file}">'
    tree.write('toilettes-paris.xml',pretty_print=True, encoding='utf-8',xml_declaration=True,doctype=doctype)


CSV_file = "sanisettesparis.csv"
generatXML(CSV_file)
