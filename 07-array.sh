#!/bin/bash

#array is like masala petta, okate dantlo multiple values store cheskochu, oke variable lo we can
#store multiple values.

#ila oka movie ane variable lo we can put multiple values
MOVIES=("court" ,"Subham" ,"Hi nanna" ,"Ante sundaraniki")

#array lo index starts from 0, court=0, subham=1, hi nanna=3... ala

echo "First movie: ${MOVIES[0]}" #to execute court, flower brackets pedthe 0 ni index input laga teeskuntundi
#lekapothe it prints 0 in the output

echo "All movies: ${MOVIES[@]}" #ikada to print all movies we use @ = all



