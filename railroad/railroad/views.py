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
def draw():
    links = Link.objects.aggregate()
    length = len(links)
    #pdb.set_trace()
    net = Network(notebook=True)
    for link in links:
        f_id = f'{link.in_field}'
        s_id = f'{link.out}'
        net.add_node(1, label=f_id)
        net.add_node(2, label=s_id)
    net.add_edge(1, 2, weight=20)
    net.toggle_physics(False)
    net.show("templates/scheme.html")
def example():
    net = Network(notebook=True)
    net.add_node(9, label='Молоди')
    net.add_node(5, label='Столбовая')
    net.add_node(15, label='66 км')
    net.add_node(7, label='283 км')
    net.add_node(50, label='Сандарово', color='Red')
    
    net.add_edge(9, 5, weight=7)
    net.add_edge(5, 15, weight=5)
    net.add_edge(5,7, weight=6)
    net.add_edge(7,50, weight=5)
    net.toggle_physics(False)
    net.toggle_drag_nodes(True)
    net.show("templates/scheme.html")
    #net.toggle_drag_nodes(False)
