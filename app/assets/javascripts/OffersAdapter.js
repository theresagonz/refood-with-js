class OffersAdapter {
  // provides interaction with API
  constructor() {
    this.baseUrl = 'http://localhost:3000/offers.json';
  }

  getOffers() {
    return fetch(this.baseUrl).then(res => {
      return res.json();
    }).catch(error => console.error(error));

  }
}
