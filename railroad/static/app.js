    
    var selectedStations = new Array()
    clicksCount = 0
    //Получаем станции и формируем узлы
    stationsString = JSON.parse(document.getElementById('stations-data').textContent);
    stationsObjects = JSON.parse(stationsString)
    var nodes = new vis.DataSet([])
    for (let i = 0; i < stationsObjects.length; i++)
    {
        var station = stationsObjects[i]
        nodes.add([{id: station['pk'], label: station['fields']['name']}])
        
    }
    //Получаем связи и формируем грани
    linksString = JSON.parse(document.getElementById('links-data').textContent);
    linksObjects = JSON.parse(linksString)
    console.log(linksObjects)
    var edges = new vis.DataSet([])
    for (let i = 0; i < linksObjects.length; i++)
    {
        var link = linksObjects[i]
        edges.add([{from: link['fields']['in_field'], to: link['fields']['out']}])
        
    }
var container = document.getElementById('mynetwork');
var data = {
    nodes: nodes,
    edges: edges
};
var options = {
    nodes:{
        //physics: 'false',
        color:{
            background: 'white',
            border: 'blueviolet',
        },
        borderWidth: 1,
        borderWidthSelected: 1,
        shape: 'square',
        scaling: {
            label: {
                enabled: true,
                min: 60,
                max: 60,
            }
        },
      }
};

var network = new vis.Network(container, data, options);

network.on('click', function(properties) {
    var ids = properties.nodes;
    var station = nodes.get(ids)
    routeHandler(station)
    displayStationInfo(station)  
});

function displayStationInfo(station)
{
    console.log('Выбранная станция: ', station)
    var header = document.getElementById('station_name')
    header.innerHTML = station[0]['label']
}
function routeHandler(station)
{
    clicksCount++
    selectedStations.push(station)
    if(clicksCount == 2)
    {
       console.log('Содержимое массива', selectedStations)
       clicksCount = 0
       selectedStations = new Array()
    }
}