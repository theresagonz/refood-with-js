class Offer {
  constructor(offerJSON) {
    this.adapter = new OffersAdapter();
    // this.initBindingsAndEventListeners();

    // this.adapter.getOffer(id).then(fetchOffer(id));

    this.id = offerJSON.id;
    this.giverId = offerJSON.giver_id;
    this.headline = offerJSON.headline;
    this.city = offerJSON.city;
    this.state = offerJSON.state;
    this.description = offerJSON.description;
    this.availability = offerJSON.availability;
    this.closed = offerJSON.closed;
    this.deleted = offerJSON.deleted;
    this.createdAt = offerJSON.created_at;
  }

  initBindingsAndEventListeners() {
    $('#show-request-form').on('click', (e) => {
      e.preventDefault();
      $('#place-for-form').html(this.renderForm());
    });
  }

  fetchOffer(id) {
    this.adapter.getOffer(id)
      .then(offer => offer.json())
      .then(data => new Offer(data));
  }

  renderLi() {
    return `
      <li class="list-obj left-padding">
        <h5><a href="offers/${this.id}">${this.headline}</a></h5>
        <div>${this.city}, ${this.state}</div>
      </li>
    `;
  }

  renderInfo() {
    $('#offer-description').innerHTML = this.renderLi();
  }

  renderForm() {
    return `
      <form>
        <label for="request-message">
        <input type="text" id="request-message">
        <input type="submit">
      </form>
    `
  }
}
