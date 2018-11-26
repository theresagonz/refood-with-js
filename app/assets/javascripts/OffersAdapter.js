class OffersAdapter {
  // gets data from API
  static getOffers() {
    return fetch(`http://localhost:3000/offers`, {
      headers: {
        Accept: 'application/json'
      }
    })
    .then(res => res.json())
    .catch(error => console.error(error));
  }

  static getOffer(id) {
    return fetch(`http://localhost:3000/offers/${id}.json`)
    .then(res => res.json())
    .catch(error => console.error(error));
  }

  static getCurrentUser() {
    return fetch(`http://localhost:3000/user`)
    .then(res => res.json())
    .catch(error => console.error(error));
  }
}
