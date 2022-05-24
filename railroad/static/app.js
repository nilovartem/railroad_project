
var selectedStations = new Array()
clicksCount = 0
var routeStations = new Array()
var routeLinks = new Array()


//Получаем зоны
zonesString = JSON.parse(document.getElementById('zones-data').textContent)
zonesObjects = JSON.parse(zonesString)
console.log(zonesObjects)
//Получаем станции и формируем узлы
stationsString = JSON.parse(document.getElementById('stations-data').textContent);
stationsObjects = JSON.parse(stationsString)
console.log(stationsObjects)
var nodes = new vis.DataSet([])
for (let i = 0; i < stationsObjects.length; i++) {
    var station = stationsObjects[i]
    color = getColorByStationID(station['pk'])
    var node = [{ id: station['pk'], label: station['fields']['name'], color:  color}]
    nodes.add(node)
    console.log(color)
}
//Получаем связи и формируем грани
linksString = JSON.parse(document.getElementById('links-data').textContent);
linksObjects = JSON.parse(linksString)
console.log(linksObjects)
var edges = new vis.DataSet([])
for (let i = 0; i < linksObjects.length; i++) {
    var link = linksObjects[i]
    edges.add([{ id: link['fields']['id'], from: link['fields']['in_field'], to: link['fields']['out'], label: link['fields']['travel_time'] + ' мин.' }])

}
var container = document.getElementById('mynetwork');
var data = {
    nodes: nodes,
    edges: edges
};
var options = {
    nodes: {
        physics: false,
        /*color: {
            background: 'white',
            border: 'blueviolet',
        },*/
        borderWidth: 1,
        borderWidthSelected: 1,
        shape: 'hexagon',
        scaling: {
            label: {
                enabled: true,
                min: 50,
                max: 50,
            }
        },
    },
    edges: {
        physics: true
    }
};

var network = new vis.Network(container, data, options);

network.on('click', function (properties) {
    var ids = properties.nodes;
    var station = nodes.get(ids)
    //routeHandler(station)
    displayStationInfo(station)
});

function displayStationInfo(station) {
    console.log('Выбранная станция: ', station)
    var header = document.getElementById('station_name')
    header.innerHTML = station[0]['label']
}
function routeHandler(station) {
    clicksCount++
    selectedStations.push(station)
    if (clicksCount == 2) {
        console.log('Содержимое массива', selectedStations)
        findRoute()
        clicksCount = 0
        selectedStations = new Array()
    }


}
function findRoute() {
    console.log('Поиск маршрута:')
    console.log(stationsObjects)
    console.log(linksObjects)
    var start = getStationByID(selectedStations[0][0]['id'])
    var finish = getStationByID(selectedStations[1][0]['id'])
    console.log('Старт ', start)
    console.log('Финиш ', finish)
    routeStations.push(start)
    getCheapestNode(start, finish, 100)
    console.log('Станции маршрута ', routeStations)
    console.log('Связи маршрута ', routeLinks)
    highlighRoute()




}
//deprecated
function paintNode(node, color) 
{
    node.color = {
        border: '#000000',
        background: 'color',
        highlight: {
            border: '#2B7CE9',
            background: '#D2E5FF'
        }
    }
    nodes.update(node);
}
function highlighRoute() {

    mySelection = {
        nodes: selectedStations,
        edges: desiredEdges
    };

    myOptions = {
        highlightEdges: true
    };

    network.setSelection(mySelection, myOptions);
}
function getStationByID(id) {
    for (var i = 0; i < stationsObjects.length; i++) {
        if (stationsObjects[i].pk == id) {
            return stationsObjects[i]
        }
    }
}
function getColorByStationID(id) {
    station = getStationByID(id)
    zone_id = station['fields']['zone']
    for (var i = 0; i < zonesObjects.length; i++) {
        if (zonesObjects[i]['pk'] == zone_id) {
            return zonesObjects[i]['fields']['color']
        }
    }
}
function getCheapestNode(cheapest_station, finish, cheapest_time) {
    var cheapest_link;
    for (let i = 0; i < linksObjects.length; i++) {
        if (linksObjects[i]['fields']['in_field'] == cheapest_station['pk']) {
            if (parseFloat(linksObjects[i]['fields']['travel_time']) < cheapest_time || linksObjects[i]['fields']['out'] == finish['pk']) {
                cheapest_time = linksObjects[i]['fields']['travel_time']
                cheapest_station = getStationByID(linksObjects[i]['fields']['out'])
                cheapest_link = linksObjects[i]
            }

        }
        if (linksObjects[i]['fields']['out'] == cheapest_station['pk']) {
            if (parseFloat(linksObjects[i]['fields']['travel_time']) < cheapest_time || linksObjects[i]['fields']['in_field'] == finish['pk']) {
                cheapest_time = linksObjects[i]['fields']['travel_time']
                cheapest_station = getStationByID(linksObjects[i]['fields']['in_field'])
                cheapest_link = linksObjects[i]
            }

        }
        if (cheapest_station == finish) {
            break
        }
        console.log('Наименьшее время в цикле ', cheapest_time)
        console.log('Cheapest station ', cheapest_station)
        console.log('Finish station ', finish)
    }

    //console.log('Cheapest station', cheapest_station)
    routeStations.push(cheapest_station)
    routeLinks.push(cheapest_link)
    if (cheapest_station != finish) {
        getCheapestNode(cheapest_station, finish, cheapest_time)
    }
}
//не делал
function setSchemeLegend()
{
    
    var container = document.getElementById('legend');
       
    var square = '#33cccc'
    container.color = square
}