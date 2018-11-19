class OffersAdapter {
  // gets data from API
  constructor() {
    this.baseUrl = 'http://localhost:3000';
  }

  getOffers() {
    return fetch(`${this.baseUrl}/offers.json`)
    .then(res => res.json())
    .catch(error => console.error(error));
  }

  getOffer(id) {
    return fetch(`${this.baseUrl}/offers/${id}.json`)
    .then(res => res.json())
    .catch(error => console.error(error));
  }

  getCurrentUser() {
    return fetch(`${this.baseUrl}/user`)
    .then(res => res.json())
    .catch(error => console.error(error));
  }
}
