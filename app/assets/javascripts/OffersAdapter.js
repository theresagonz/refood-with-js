class OffersAdapter {
  // provides interaction with API
  constructor() {
    this.baseUrl = 'http://localhost:3000';
  }

  getOffers() {
    return fetch(`${this.baseUrl}/offers.json`).then(res => {
      return res.json();
    }).catch(error => console.error(error));
  }

  getOffer(id) {
    return fetch(`${this.baseUrl}/offer/${id}.json`).then(res => {
      return res.json();
    }).catch(error => console.error(error));
  }
}
