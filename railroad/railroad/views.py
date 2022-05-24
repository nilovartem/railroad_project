from django.shortcuts import render
from pyvis.network import Network
from django.http import HttpResponse
from django.shortcuts import render
from railroad.models import Station
from railroad.models import Link
from railroad.models import Zone
from django.core import serializers
import pdb
import logging
from json import dumps
# Create your views here.
def railroad_app(request):
    #получить список станций
    stationsJSON = serializers.serialize('json',Station.objects.all())
    linksJSON = serializers.serialize('json', Link.objects.all())
    zonesJSON = serializers.serialize('json', Zone.objects.all())
    #length = len(stations)
    #pdb.set_trace()
    #pdb.set_trace()
    #pdb.pprint(stationsJSON)
    return render(request, 'main_app.html', {'stations': stationsJSON, 'links': linksJSON, 'zones': zonesJSON})