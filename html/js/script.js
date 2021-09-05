const doc = document;

window.addEventListener('load', () => {
    this.addEventListener('message', e => {
        switch (e.data.action) {
            case 'show':

            break;

            case 'hide':

            break;
        }
    });

    doc.getElementById('sel-class').addEventListener('change', e => {
        console.log(e.target.value)
        switch (e.target.value) {
            case 'low':

            break;

            case 'medium':

            break;

            case 'high':

            break;
        }
    })
})

function openTab(target, className) {
    let showClass = doc.getElementById(target)
    let targetClass = doc.getElementsByClassName(className);
    for (let i=0; i < targetClass.length; i++) {
        targetClass[i].style.display = 'none'
    }
    for (let i=0; i < showClass.length; i++) {
        targetClass[i].style.display = 'flex'
    }
}

window.addEventListener('DOMContentLoaded', () => {
    fetch('../config.json')
    .then((response) => response.json())
    .then((data) => appendData(data))
    .catch((error) => {console.log('Config Error: ' + error)})
})

function appendData(data) {
    const mainContainer = doc.getElementById('vehicle-container');
    data.forEach(dataItem => {
        const mainItem = doc.createElement('div');
        const imgCont = doc.createElement('div');
        const imgType = doc.createElement('span');
        const imgVeh = doc.createElement('img');

        const vehTitle = doc.createElement('span');
        const vehDesc = doc.createElement('span');

        const vehsCont = doc.createElement('div');
        const vehBtn = doc.createElement('button');

        mainItem.classList.add('item-container', `${dataItem.type}`)
        imgCont.classList.add('veh-img')
        vehTitle.classList.add('veh-title')
        vehDesc.classList.add('veh-desc')
        vehsCont.classList.add('veh-vehs')

        imgVeh.src = dataItem.image;
        imgType.textContent = dataItem.imageType;
        imgType.style.backgroundColor = dataItem.imageTypeColor; 
        vehTitle.textContent = dataItem.title;
        vehDesc.textContent = dataItem.description;
        vehBtn.textContent = 'Accept';
        for (let i=0; i < dataItem.vehicles.length; i++) {
            const vehicle = doc.createElement('span');
            vehicle.textContent = dataItem.vehicles[i]
            vehsCont.appendChild(vehicle)
        }

        imgCont.append(imgType, imgVeh);
        mainItem.append(imgCont, vehTitle, vehDesc, vehsCont, vehBtn);
        mainContainer.appendChild(mainItem);
    });
}