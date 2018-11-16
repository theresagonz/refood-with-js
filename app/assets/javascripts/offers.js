class Offers {
  constructor() {
    this.offers = [];
    this.adapter = new OffersAdapter();
    this.fetchAndLoadOffers();
  }

  fetchAndLoadOffers() {
    this.adapter.getOffers()
      .then(offers => {
        offers.forEach(offer => {
          this.offers.push(new Offer(offer));
        });
      })
      .then(() => this.render())
      .catch(error => console.error(error));
  }

  render() {
    document.querySelector('#offers-list').innerHTML = this.offers.map(offer => offer.renderLi()).join('');
  }
}
