<%@ Page Title="Academias Próximas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProxAcademias.aspx.cs" Inherits="ProjectFit.Views.ProxAcademias" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="container">
            <h2 id="title">Academias Próximas</h2>
            <p>Encontre academias próximas da sua localização em um raio de 8 km.</p>

            <div id="map" style="height: 400px; border-radius: 12px; margin-bottom: 30px;"></div>

            <h3>Lista de Academias</h3>
            <div id="academy-list" class="row g-4 gy-5"></div>
        </div>
    </main>

    <style>
        .academy-card {
            background: #fff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .academy-card:hover {
            transform: translateY(-5px);
        }

        .academy-card h5 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }

        .academy-card p {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 10px;
        }

        .academy-card .distance {
            font-size: 14px;
            color: #007bff;
        }

        .btn-directions {
            background-color: #0070e8;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .message {
            text-align: center;
            padding: 20px;
        }
    </style>

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        let map;

        function initialize(lat, lng) {
            if (map) map.remove();

            map = L.map('map').setView([lat, lng], 14);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; OpenStreetMap contributors'
            }).addTo(map);

            L.marker([lat, lng]).addTo(map)
                .bindPopup('<strong>Você está aqui</strong>')
                .openPopup();

            fetchNearbyAcademies(lat, lng);
        }

        function fetchNearbyAcademies(lat, lng) {
            const radius = 8000;
            const query = `
                [out:json][timeout:25];
                (
                    node["leisure"="fitness_centre"](around:${radius},${lat},${lng});
                    way["leisure"="fitness_centre"](around:${radius},${lat},${lng});
                    relation["leisure"="fitness_centre"](around:${radius},${lat},${lng});
                    node["amenity"="gym"](around:${radius},${lat},${lng});
                    way["amenity"="gym"](around:${radius},${lat},${lng});
                    relation["amenity"="gym"](around:${radius},${lat},${lng});
                    node["sport"="fitness_centre"](around:${radius},${lat},${lng});
                    way["sport"="fitness_centre"](around:${radius},${lat},${lng});
                    relation["sport"="fitness_centre"](around:${radius},${lat},${lng});
                );
                out center;
            `;

            fetch('https://overpass-api.de/api/interpreter', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `data=${encodeURIComponent(query)}`
            })
                .then(response => response.json())
                .then(data => {
                    const academyList = document.getElementById('academy-list');
                    academyList.innerHTML = '';

                    if (data.elements.length === 0) {
                        academyList.innerHTML = '<div class="message text-muted">Nenhuma academia encontrada nas proximidades.</div>';
                        return;
                    }

                    data.elements.forEach(element => {
                        const coords = getCoordinates(element);
                        if (!coords) return;

                        const name = element.tags?.name || 'Academia sem nome';
                        const address = element.tags?.['addr:street']
                            ? `${element.tags['addr:street']}, ${element.tags['addr:city'] || ''}`
                            : 'Endereço não disponível';

                        const dist = calculateDistance(lat, lng, coords.lat, coords.lon).toFixed(2);

                        addMarker(name, coords.lat, coords.lon, address);
                        addAcademyCard(name, address, coords.lat, coords.lon, dist);
                    });
                })
                .catch(err => {
                    document.getElementById('academy-list').innerHTML = '<div class="message text-danger">Erro ao carregar academias.</div>';
                    console.error(err);
                });
        }

        function getCoordinates(element) {
            if (element.type === "node") {
                return { lat: element.lat, lon: element.lon };
            } else if (element.center) {
                return { lat: element.center.lat, lon: element.center.lon };
            }
            return null;
        }

        function calculateDistance(lat1, lon1, lat2, lon2) {
            const R = 6371;
            const dLat = (lat2 - lat1) * Math.PI / 180;
            const dLon = (lon2 - lon1) * Math.PI / 180;
            const a =
                0.5 - Math.cos(dLat) / 2 +
                Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                (1 - Math.cos(dLon)) / 2;

            return R * 2 * Math.asin(Math.sqrt(a));
        }

        function addMarker(name, lat, lon, address) {
            L.marker([lat, lon]).addTo(map)
                .bindPopup(`<strong>${name}</strong><br>${address}`);
        }

        function addAcademyCard(name, address, lat, lon, distance) {
            const container = document.getElementById('academy-list');

            const card = document.createElement('div');
            card.className = 'col-12 col-md-6 col-lg-4 academy-card';

            card.innerHTML = `
                <h5>${name}</h5>
                <p>${address}</p>
                <p class="distance">${distance} km</p>
                <button class="btn-directions" onclick="openDirections('${name}', ${lat}, ${lon})">Ver Rota</button>
            `;

            container.appendChild(card);
        }

        function openDirections(name, lat, lon) {
            const url = `https://www.google.com/maps/dir/?api=1&destination=${encodeURIComponent(name)}&destination=${lat},${lon}`;
            window.open(url, '_blank');
        }

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    pos => initialize(pos.coords.latitude, pos.coords.longitude),
                    () => alert("Não foi possível obter sua localização.")
                );
            } else {
                alert("Geolocalização não suportada pelo navegador.");
            }
        }

        document.addEventListener('DOMContentLoaded', getLocation);
    </script>
</asp:Content>
