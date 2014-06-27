#!/bin/bash
#===================================================================================
#
#         FAILAS: lrt.sh
#
#     NAUDOJIMAS: Instrukcijos pateikimos faile SKAITYK.md
#
#      APRAŠYMAS: Scenarijus groja LRT internetu transliuojamus kanalus Jūsų 
#                 pasirinktame grotuve.
#
# PRIKLAUSOMYBĖS: curl, medija grotuvas.
#   REIKALAVIMAI: --- 
#       AUTORIUS: AKMC komanda (GitHUB prisidėję asmenys)
#      LICENCIJA: GPL v2
#
#        VERSIJA: 0.alpha
#        SUKURTA: 2014-06-28
#===================================================================================

#-----------------------------------------------------------------------------------
# Kintamieji
#-----------------------------------------------------------------------------------

grotuvas='mpv'							# video grotuvas
url_base='http://www.lrt.lt/mediateka/tiesiogiai'		# URL iki kanalo

# grotuvas_param='--vf crop=1050:574:0:2 --deinterlace=yes'	# papildomi video grotuvo parametrai
 
#-----------------------------------------------------------------------------------
# Procedūra
#-----------------------------------------------------------------------------------
case ${1} in
    -h|--help)
        echo "Naudojimas: ${0} [kanalas]"
        echo ""
        echo "TV kanalai:"
        echo " tv1 (1) - Lietuvos televizija"
        echo " tv2 (2) - LRT Kultūra"
        echo " tv3 (3) - LRT Kultūra"
        echo "Radijo kanalai:"
        echo ""
        ;;
    tv1|1)
        ${grotuvas} ${grotuvas_param} $(curl -s ${url_base}/lrt-televizija | grep -oP 'rtmp\S+[a-z0-9]{32}')/ltv1 
        ;;
    tv2|2)
        ${grotuvas} ${grotuvas_param} $(curl -s ${url_base}/lrt-kultura | grep -oP 'rtmp\S+[a-z0-9]{32}')/ltv2
        ;;
    tv3|3)
        ${grotuvas} ${grotuvas_param} $(curl -s ${url_base}/lrt-lituanica | grep -oP 'rtmp\S+[a-z0-9]{32}')/world
        ;;
    *)
        echo "Nenurodytas kanalas!"
        echo ""
        echo "Pagalba: ${0} -h"
        echo ""
        ;;
esac

#-----------------------------------------------------------------------------------
# TODO
#-----------------------------------------------------------------------------------
# 1. Pasitikrinimą ar transliuojama (kartais netransliuojama internetu dėl autorinių teisių)
# 2. Uždaryti terminalo langą sėkmingai paleidus kanalą? (&; disown; exit)
# 3. Papildyti radijo kanalais
# 4. Pasitikrinti ar pasirinktas grotuvas yra įdiegtas (hash arba which)
