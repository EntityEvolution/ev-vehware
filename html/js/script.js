const doc = document;
const wrapper = doc.getElementById('wrapper');

window.addEventListener('load', () => {
    this.addEventListener('message', e => {
        switch (e.data.action) {
            case 'show':
                wrapper.style.display = 'flex';
            break;

            case 'hide':
                wrapper.style.display = 'none';
            break;
        }
    });

    doc.getElementById('sel-class').addEventListener('change', e => changeClass(e.target.value, 'item-container'));
    doc.getElementById('exit').addEventListener('click', () => fetchNUI('getVehicleData'));
})

window.addEventListener('DOMContentLoaded', () => {
    fetch('../config/config.json')
    .then((response) => response.json())
    .then((data) => appendData(data))
    .catch((error) => {console.log('Config Error: ' + error)})
})

function changeClass(target, className) {
    if (target != 'all') {
        let showClass = doc.getElementsByClassName(target)
        let targetClass = doc.getElementsByClassName(className);
        for (let i=0; i < targetClass.length; i++) {
            targetClass[i].style.display = 'none'
        }
        for (let i=0; i < showClass.length; i++) {
            showClass[i].style.display = 'flex'
        }
        return
    } else {
        const allClass = doc.getElementsByClassName('item-container');
        for (let i=0; i < allClass.length; i++) {
            allClass[i].style.display = 'flex';
        }
    }
}

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

        mainItem.classList.add('item-container', `${dataItem.type}`);
        imgCont.classList.add('veh-img');
        vehTitle.classList.add('veh-title');
        vehDesc.classList.add('veh-desc');
        vehsCont.classList.add('veh-vehs');

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
        if (dataItem.type == 'high') {
            mainItem.style.order = '3'
        } else if (dataItem.type == 'medium') {
            mainItem.style.order = '2'
        } else {
            mainItem.style.order = '1'
        }
        vehBtn.addEventListener('click', () => {
            fetchNUI('getVehicleData', {type: dataItem.type, vehicles: dataItem.vehiclesSpawn, coords: dataItem.spawnLocation})
        })

        imgCont.append(imgType, imgVeh);
        mainItem.append(imgCont, vehTitle, vehDesc, vehsCont, vehBtn);
        mainContainer.appendChild(mainItem);
    });
}

const fetchNUI = async (cbname, data) => {
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data)
    };
    const response = await fetch(`https://ev-vehware/${cbname}`, options);
    return await response.json();
}

doc.onkeyup = e => {
    if (e.key == 'Escape') {
        fetchNUI('getVehicleData');
    }
}